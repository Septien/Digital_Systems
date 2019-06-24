library ieee;
use ieee.std_logic_1164.all;

entity Avg is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    add : in std_logic;
    F8_2 : in std_logic_vector(1 downto 0);
    D : in std_logic_vector(n - 1 downto 0);
    Dout : out std_logic_vector(n - 1 downto 0)
  );
end Avg;

architecture compose of Avg is
  signal RA, RD : std_logic_vector(n - 1 downto 0);
  signal divisor : std_logic_vector(n - 1 downto 0);
  signal Qp : std_logic_vector(n - 1 downto 0);
  
  component addM is
  generic(
    n : integer := 8
  );
  port(
    Data1 : in std_logic_vector(n - 1 downto 0);
    Data2 : in std_logic_vector(n - 1 downto 0);
    add   : in std_logic;
    Result : out std_logic_vector(n - 1 downto 0)
  );
  end component;
  
  component muxF is
  generic(
    n : integer := 8;
    m : integer := 8;
    k : integer := 2;
    l : integer := 1
  );
  port(
    flag8_2 : in std_logic_vector(1 downto 0);
    divisor : out std_logic_vector(n - 1 downto 0)
  );
  end component;

  
  component division is
  generic(
    n : integer := 8
  );
  port(
    denominator : in std_logic_vector(n - 1 downto 0);
    numerator : in std_logic_vector(n - 1 downto 0);
    result : out std_logic_vector(n - 1 downto 0)
  );
  end component;
  
  component R is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    D : in std_logic_vector(n - 1 downto 0);
    Q : out std_logic_vector(n - 1 downto 0)
  );
  end component;

begin
  ADM : addM generic map(n) port map(D, Qp, add, RA);
  MUX : muxF generic map(n, 8, 2, 1) port map(F8_2, divisor);
  DIV : division generic map(n) port map(divisor, RA, RD);
  REG : R generic map(n) port map(rst, clk, RD, Qp);
  Dout <= Qp;
end compose;
