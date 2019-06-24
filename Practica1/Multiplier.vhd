library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
  generic(
    n : integer := 8
  );
  port(
    clk, rst : in std_logic;
    a, b     : in std_logic_vector(n - 1 downto 0);
    c        : out std_logic_vector(2 * n - 1 downto 0)
  );
end multiplier;

architecture simple of multiplier is
  -- Signals
  signal aR, bR : std_logic_vector(n - 1 downto 0);
  signal cR : std_logic_vector(2 * n - 1 downto 0);
  -- Components
  component R is
  generic(
    n : integer := 8
  );
  port(
    clk, rst : in std_logic;
    input    : in std_logic_vector(n - 1 downto 0);
    output   : out std_logic_vector(n - 1 downto 0)
  );
  end component;
  
  component M is
  generic(
    n : integer := 8
  );
  port(
    a, b : in std_logic_vector(n - 1 downto 0);
    c    : out std_logic_vector(2 * n - 1 downto 0)
  );
  end component;
  
begin
  registerA : R port map(clk, rst, a, aR);
  registerB : R port map(clk, rst, b, bR);
  mult      : M port map(aR, bR, cR);
  registerC : R generic map(16)
				    port map(clk, rst, cR, c);
end simple;
