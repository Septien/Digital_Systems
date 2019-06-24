-- k-bit adder block
library ieee;
use ieee.std_logic_1164.all;

entity kbitadder is
  generic(
    k : integer := 4        -- Number of bits
  );
  port(
    a, b : in std_logic_vector(k - 1 downto 0);
    Cin  : in std_logic;
    c    : out std_logic_vector(k - 1 downto 0);
    Cout : out std_logic
  );
end kbitadder;

architecture rithmetic of kbitadder is
  signal S : std_logic_vector(k - 1 downto 0);
  signal fAdC : std_logic_vector(k downto 0);
  signal p : std_logic_vector(k downto 0);
  signal hAdC : std_logic_vector(k downto 0);
  
  component fullAdder is
  port(
    a, b : in std_logic;
    cin  : in std_logic;
    c    : out std_logic;
    cout : out std_logic
  );
  end component;
  
  component and2_1 is
  port(
    a, b : in std_logic;
    c    : out std_logic
  );
  end component;
  
  component halfAdder is
  port (
    a, b : in std_logic;
    s, c : out std_logic
  );
  end component;
  
  component mux2_1 is
  port(
    a, b : in std_logic;
    s    : in std_logic;
    c    : out std_logic
  );
  end component;
  
begin
  fAdC(0) <= '0';
  p(0) <= '1';
  hAdC(0) <= Cin;
  GEN_REG:
  for i in 1 to k generate
    fAdderI : fullAdder port map(a(i - 1), b(i - 1), fAdC(i - 1), S(i - 1), fAdC(i));
    and21I : and2_1 port map(p(i - 1), S(i - 1), p(i));
    hAdderI : halfAdder port map(S(i - 1), hAdC(i - 1), c(i - 1), hAdC(i));
  end generate GEN_REG;
  M21 : mux2_1 port map(fAdC(k), Cin, p(k), Cout);
end rithmetic;
