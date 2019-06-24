-- Multiplexor 2, 1
library ieee;
use ieee.std_logic_1164.all;

entity mux2_1 is
  port(
    a, b : in std_logic;
    s    : in std_logic;
    c    : out std_logic
  );
end mux2_1;

architecture simple of mux2_1 is
begin
  process(a, b, s)
  begin
    if (s = '0') then
      c <= a;
    else
      c <= b;
    end if;
  end process;
end simple;
