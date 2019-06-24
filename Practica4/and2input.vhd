-- 2-input 1-bit and
library ieee;
use ieee.std_logic_1164.all;

entity and2_1 is
  port(
    a, b : in std_logic;
    c    : out std_logic
  );
end and2_1;

architecture simple of and2_1 is
begin
  process(a, b)
  begin
    c <= a and b;
  end process;
end simple;
