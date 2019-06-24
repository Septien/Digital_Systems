library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seqMultiplier is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    multiplierIn : in std_logic_vector(n - 1 downto 0);
    multiplicant : in std_logic_vector(n - 1 downto 0);
    result : out std_logic_vector((2 * n) - 1 downto 0)
  );
end seqMultiplier;

architecture sequentialM of seqMultiplier is
  subtype registerWidth is std_logic_vector(n - 1 downto 0);
  type registerQ is array(natural range <>) of registerWidth;
  signal Qn, Qp : registerQ(0 to n - 1) := (others => (others => '0'));
  signal andR1 : std_logic_vector(n - 1 downto 0);

  component andM is
  generic(
    n : integer := 8  
  );
  port(
    A : in std_logic_vector(n - 1 downto 0);
    b : in std_logic;
    C : out std_logic_vector(n - 1 downto 0);
    d : out std_logic
  );
  end component;
  
  component multiplier is
  generic(
    n : integer := 8
  );
  port(
    A : in std_logic_vector(n - 1 downto 0);    -- Multiplier
    B : in std_logic_vector(n - 1 downto 0);    -- Result of previous operation
    c : in std_logic;                           -- ith Value of multiplicant
    D : out std_logic_vector(n - 1 downto 0);   -- Current result
    prod : out std_logic
  );
  end component;

begin
  AM : andM generic map(n) port map(multiplierIn, multiplicant(0), andR1, result(0));
  Qn(0) <= '0' & andR1(n - 1 downto 1);
  GEN_MUL:
  for i in 1 to n - 1 generate
    Mi : multiplier 
      generic map(n)
      port map(multiplierIn, Qp(i - 1), multiplicant(i), Qn(i), result(i));
  end generate GEN_MUL;
  
  sequential : process(rst, clk, Qn)
  begin
    if (rst = '1') then
      for i in 0 to n - 1 loop
        Qp(i) <= (others => '0');
      end loop;

    elsif (rising_edge(clk)) then
      for i in 0 to n - 1 loop
        Qp(i) <= Qn(i);
      end loop;

    end if;
  end process sequential;
  result((2 * n) - 1 downto n) <= Qp(n - 1);

end sequentialM;
