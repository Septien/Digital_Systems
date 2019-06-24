library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
  generic(
    n : integer := 8
  );
  port(
    A : in std_logic_vector(n - 1 downto 0);        -- Multiplier
    B : in std_logic_vector(n - 1 downto 0);    -- Result of previous operation
    c : in std_logic;                           -- ith Value of multiplicant
    D : out std_logic_vector(n - 1 downto 0);   -- Current result
    prod : out std_logic
  );
end multiplier;

architecture rithmetic of multiplier is
  signal andR : std_logic_vector(n - 1 downto 0);
  signal result : std_logic_vector(n downto 0);
  signal Baux : std_logic_vector(n downto 0);

  component andM is
  generic(
    n : integer := 8  
  );
  port(
    A : in std_logic_vector(n - 1 downto 0);
    b : in std_logic;
    C : out std_logic_vector(n - 1 downto 0);
    d : out std_logic
  );
  end component;

  component Addition is
  generic(
    n : integer := 8
  );
  port(
    A : in std_logic_vector(n - 1 downto 0);
    B : in std_logic_vector(n - 1 downto 0);
    C : out std_logic_vector(n downto 0)
  );
  end component;

begin
  AM : andM generic map(n) port map(A, c, andR, open);
  AD : addition generic map(n) port map(B, andR, result);
  D <= result(n downto 1);
  prod <= result(0);
end rithmetic;