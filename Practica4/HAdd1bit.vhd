-- 1-bit half adder
library ieee;
use ieee.std_logic_1164.all;

entity halfAdder is
  port (
    a, b : in std_logic;
    s, c : out std_logic
  );
end halfAdder;

architecture simple of halfAdder is
begin
  process(a, b)
  begin
    s <= a xor b;
    c <= a and b;
  end process;
end architecture simple;
