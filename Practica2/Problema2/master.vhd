library ieee;
use ieee.std_logic_1164.all;

entity master is
  generic(
    n : integer := 8
  );
  port(
    rst, clkF, clkS : in std_logic;
    D     : in std_logic;
    a, b  : in std_logic_vector(n - 1 downto 0);
    c     : out std_logic_vector(n - 1 downto 0)
  );
end master;

architecture simple of master is
  signal P : std_logic;
  signal ST, EC : std_logic;
  signal k : std_logic_vector(3 downto 0);
  
  component StartC is
  port(
    rst, clk : in std_logic;
    D, EC    : in std_logic;
    ST       : out std_logic
  );
  end component;

  component PCounter is
  generic(
    n : integer := 4
  );
  port(
    rst, clk : in std_logic;
    H : in std_logic;
    k : in std_logic_vector(n - 1 downto 0);
    EC : out std_logic;
    P : out std_logic
  );
  end component;
  
  component Add is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    h : in std_logic;
    a, b : in std_logic_vector(n - 1 downto 0);
    c : out std_logic_vector(n - 1 downto 0)
  );
  end component;

begin
  k <= "1010";
  SC : StartC port map(rst, clkF, D, EC, ST);
  PC : PCounter port map(rst, clkF, ST, k, EC, P);
  AD : Add port map(rst, clkS, P, a, b, c);
end simple;
