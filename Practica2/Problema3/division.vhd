library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity division is
  generic(
    n : integer := 8
  );
  port(
    denominator : in std_logic_vector(n - 1 downto 0);
    numerator : in std_logic_vector(n - 1 downto 0);
    result : out std_logic_vector(n - 1 downto 0)
  );
end division;

architecture simple of division is
begin
  process(denominator, numerator)
  begin
    result <= std_logic_vector(unsigned(numerator) / unsigned(denominator));
  end process;
end simple;
