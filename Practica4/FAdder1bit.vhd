-- 1-bit full adder
library ieee;
use ieee.std_logic_1164.all;

entity fullAdder is
  port(
    a, b : in std_logic;
    cin  : in std_logic;
    c    : out std_logic;
    cout : out std_logic
  );
end fullAdder;

architecture simple of fullAdder is
  signal c1, c2, c3 : std_logic;
begin
  process(a, b, cin)
  begin
    c <= (a xor b) xor cin;
    cout <= (a and b) or (cin and (a xor b));
  end process;
end simple;
