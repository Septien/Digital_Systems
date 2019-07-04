library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture bench of tb is
  signal rst, clk : std_logic := '0';
  signal A, B : std_logic_vector(3 downto 0);
  signal C : std_logic_vector(7 downto 0);
  signal SM : std_logic;
  
  component boothAdd is
  generic(
    n : integer := 8          -- Number of bits
  );
  port(
    clk, rst : in std_logic;
    SM : in std_logic;                            -- Start multiplication
    A, B : in std_logic_vector(n - 1 downto 0);
    C : out std_logic_vector((2 * n) - 1 downto 0)
  );
  end component;

begin
  clk <= not clk after 10 ns;
  rst <= '1', '0' after 10 ns;
  A <= "0111";
  B <= "1111";
  SM <= '0', '1' after 10 ns, '0' after 40 ns;
  BA : boothAdd generic map(4) port map(clk, rst, SM, A, B, C);
end bench;
