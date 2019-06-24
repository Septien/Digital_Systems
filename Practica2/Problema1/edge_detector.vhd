library ieee;
use ieee.std_logic_1164.all;

entity ED is
  port(
    rst, clk : in std_logic;
    D : in std_logic;
    pulse : out std_logic
  );
end ED;

architecture detector of ED is
  signal D1, D2 : std_logic;
begin
  process(clk, rst, D1, D2, D)
  begin
    if (rst = '1') then
      D1 <= '0';
      D2 <= '0';
    elsif (rising_edge(clk)) then
      D1 <= D;
      D2 <= D1;
    end if;
  end process;
  pulse <= (not D2) and D1;
end detector;
