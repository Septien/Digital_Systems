library ieee;
use ieee.std_logic_1164.all;

entity ktb is
end ktb;

architecture bench of ktb is
  signal a, b, c : std_logic_vector(3 downto 0);
  signal Cin, Cout : std_logic;

  component kbitadder is
  generic(
    k : integer := 4        -- Number of bits
  );
  port(
    a, b : in std_logic_vector(k - 1 downto 0);
    Cin  : in std_logic;
    c    : out std_logic_vector(k - 1 downto 0);
    Cout : out std_logic
  );
  end component;
begin
  a <= "1010";
  b <= "0101";
  Cin <= '0';
  KBA : kbitadder port map(a, b, Cin, c, Cout);
end bench;