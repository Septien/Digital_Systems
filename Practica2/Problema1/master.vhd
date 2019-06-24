library ieee;
use ieee.std_logic_1164.all;

entity master is
  generic(
    n : integer := 8
  );
  port(
    clkS, clkF, rst : in std_logic;
    a, b : in std_logic_vector(n - 1 downto 0);
    D : in std_logic;
    c : out std_logic_vector(n - 1 downto 0)
  );
end master;

architecture compose of master is
  signal Ds, mD, P : std_logic;
  
  component R is
  port(
    rst, clk : in std_logic;
    D : in std_logic;
    Q : out std_logic
  );
  end component;
  
  component ED is
  port(
    rst, clk : in std_logic;
    D : in std_logic;
    pulse : out std_logic
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
  RSlow : R port map(rst, clkS, D, Ds);
  RFast : R port map(rst, clkF, Ds, mD);
  EdgeD : ED port map(rst, clkF, mD, P);
  Addtn : Add port map(rst, clkF, P, a, b, c);
end compose;
