library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture Bench of tb is
  signal A, B, C : std_logic_vector(31 downto 0);
  signal Cin, Cout : std_logic;
  
  component master is
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
  end component;
  
begin
  A <= "10101010101010101010101010101010";
  B <= "01010101010101010101010101010101";
  Cin <= '1';
  M : master port map(A, B, Cin, C, Cout);
end;
