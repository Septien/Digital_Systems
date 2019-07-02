library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity boothAdd is
  generic(
    n : integer := 8          -- Number of bits
  );
  port(
    clk, rst : in std_logic;
    SM : in std_logic;                            -- Start multiplication
    A, B : in std_logic_vector(n - 1 downto 0);
    C : out std_logic_vector((2 * n) - 1 downto 0)
  );
end boothAdd;

architecture rithmetic of boothAdd is
  type state is (S0, S1, S2, S3, S4, S5);
  signal Qn, Qp : state;
  signal An, Ap : std_logic_vector(n - 1 downto 0);
  signal plusM, minusM : std_logic_vector(n - 1 downto 0);
  signal Qmn, Qmp : std_logic_vector(n - 1 downto 0);
  signal counterp, countern : unsigned(n - 1 downto 0);
  signal zeros : unsigned(n - 1 downto 0);
  signal Q_1n, Q_1p : std_logic;
  
begin
  zeros <= (others => '0');
  plusM <= A;
  minusM <= std_logic_vector(unsigned((not A)) + to_unsigned(1, n));
  combinational : process(SM, Qp, Q_1p, Qmp, Ap, counterp, zeros, B, minusM, plusM)
  begin
    case Qp is
    when S0 =>
      if (SM = '1') then
        Qn <= S1;
      else
        Qn <= Qp;
      end if;
      
      An <= (others => '0');
      Q_1n <= '0';
      Qmn <= B;
      countern <= to_unsigned(n, n);
      
    when S1 =>
      if (Qmp(0) = Q_1p) then
        Qn <= S4;
      elsif (Qmp(0) = '1' and Q_1p = '0') then
        Qn <= S2;
      else
        Qn <= S3;
      end if;
      An <= Ap;
      Q_1n <= Q_1p;
      Qmn <= Qmp;
      countern <= counterp;
      
    when S2 =>
      Qn <= S4;
      An <= std_logic_vector(unsigned(Ap) + unsigned(minusM));
      Q_1n <= Q_1p;
      Qmn <= Qmp;
      countern <= counterp;
      
    when S3 =>
      Qn <= S4;
      An <= std_logic_vector(unsigned(Ap) + unsigned(plusM));
      Q_1n <= Q_1p;
      Qmn <= Qmp;
      countern <= counterp;
      
    when S4 =>
      Qn <= S5;
      An(n - 1) <= Ap(n - 1);
      Qmn(n - 1) <= Ap(0);
      for i in n - 2 downto 0 loop
        An(i) <= Ap(i + 1);
        Qmn(i) <= Qmp(i + 1);
      end loop;
      Q_1n <= Qmp(0);
      countern <= counterp - 1;
      
    when S5 =>
      if (counterp = zeros) then
        Qn <= S0;
      else
        Qn <= S1;
      end if;
      An <= Ap;
      Q_1n <= Q_1p;
      Qmn <= Qmp;
      countern <= counterp;
      
    end case;
  end process combinational;
  
  sequential : process(rst, clk, Qn, An, Qmn, Q_1n, countern)
  begin
    if (rst = '1') then
      Qp <= S0;
    elsif (rising_edge(clk)) then
      Qp <= Qn;
      Ap <= An;
      Qmp <= Qmn;
      Q_1p <= Q_1n;
      counterp <= countern;
    end if;
  end process sequential;

  C((2 * n) - 1 downto n) <= Ap;
  C(n - 1 downto 0) <= Qmp;

end rithmetic;
  
  