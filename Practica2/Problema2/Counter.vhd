library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCounter is
  generic(
    n : integer := 4
  );
  port(
    rst, clk : in std_logic;
    H : in std_logic;
    k : in std_logic_vector(n - 1 downto 0);
    EC : out std_logic;
    P : out std_logic
  );
end PCounter;

architecture counter of PCounter is
  signal Qn, Qp, aux : unsigned(n - 1 downto 0);
begin
  aux <= unsigned(k);
  
  combinational : process(Qp, aux, H)
  begin
    if (Qp = aux) then
      P <= '0';
      Qn <= (others => '0');
      EC <= '1';
    else
      if (H = '1') then
        Qn <= Qp - 1;
        P <= '1';
      else
        Qn <= Qp;
        P <= '0';
      end if;
      EC <= '0';
    end if;
  end process combinational;
  Qp <= (others => '0') when rst = '1' else Qn when rising_edge(clk);

end counter;
