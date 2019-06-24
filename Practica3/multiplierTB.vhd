library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture Bench of tb is
  signal clk, rst : std_logic := '0';
  signal A, B : std_logic_vector(7 downto 0);
  signal C : std_logic_vector(15 downto 0);
  
  component seqMultiplier is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    multiplierIn : in std_logic_vector(n - 1 downto 0);
    multiplicant : in std_logic_vector(n - 1 downto 0);
    result : out std_logic_vector((2 * n) - 1 downto 0)
  );
  end component;

begin
  clk <= not clk after 10 ns;
  rst <= '1', '0' after 10 ns;
  A <= "01010101";
  B <= "11001100";
  
  SM : seqMultiplier generic map(8) port map(rst, clk, A, B, C);
end Bench;
