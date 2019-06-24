library ieee;
use ieee.std_logic_1164.all;

entity master is
  generic (
    n : integer := 32;      -- Number of bits of operands
    m : integer := 8;       -- Numbe of stages
    k : integer := 4        -- Number of bits per stage
  );
  port(
    A, B : in std_logic_vector(n - 1 downto 0);
    Cin  : in std_logic;
    C    : out std_logic_vector(n - 1 downto 0);
    Cout : out std_logic
  );
end master;

architecture compose of master is
  signal carries : std_logic_vector(m downto 0);
  
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
  carries(0) <= Cin;
  ADD_GEN:
  for i in 0 to m - 1 generate
    ADDI : kbitadder generic map(k) 
    port map(a(((i + 1) * k) - 1 downto i * k), b(((i + 1) * k) - 1 downto i * k), carries(i), C(((i + 1) * k) - 1 downto i * k), carries(i + 1));
  end generate ADD_GEN;
  Cout <= carries(m);
end compose;
