library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture Bench of tb is
  signal denominator, numerator, result : std_logic_vector(7 downto 0);

  component division is
  generic(
    n : integer := 8
  );
  port(
    denominator : in std_logic_vector(n - 1 downto 0);
    numerator : in std_logic_vector(n - 1 downto 0);
    result : out std_logic_vector(n - 1 downto 0)
  );
  end component;
begin
  D : division port map(denominator, numerator, result);
  denominator <= "01010101", "10101010" after 20 ns;
  numerator <= "10101010", "01010101" after 20 ns, "10101010" after 40 ns;
end Bench;
