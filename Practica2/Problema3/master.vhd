library ieee;
use ieee.std_logic_1164.all;

entity master is
  generic (
    n : integer := 8
  );
  port(
    clk, rst : in std_logic;
    flag : in std_logic;
    Din : in std_logic_vector(n - 1 downto 0);
    Dout : out std_logic_vector(n - 1 downto 0)
  );
end master;

architecture M of master is
  signal E, F, add : std_logic;
  signal F8_2 : std_logic_vector(1 downto 0);
  signal opr : std_logic_vector(1 downto 0);
  signal D : std_logic_vector(n - 1 downto 0);
  
  component FIFO is
  generic(
    m : integer := 8;     -- Number of bits
    n : integer := 2;     -- Address lines
    k : integer := 8      -- Number of data
  );
  port(
    rst, clk : in std_logic;
    opr : in std_logic_vector(1 downto 0);
    inD : in std_logic_vector(m - 1 downto 0);
    outD : out std_logic_vector(m - 1 downto 0);
    E, F : out std_logic
  );
  end component;
  
  component fifoCtrl is
  port(
    rst, clk : in std_logic;
    flag, add : in std_logic;
    opr : out std_logic_vector(1 downto 0)
  );
  end component;

  component Ctrl is
  port(
    rst, clk : in std_logic;
    E, F : in std_logic;
    F8_2 : out std_logic_vector(1 downto 0);
    avg : out std_logic
  );
  end component;
  
  component Avg is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    add : in std_logic;
    F8_2 : in std_logic_vector(n - 1 downto 0);
    D : in std_logic_vector(n - 1 downto 0);
    Dout : out std_logic_vector(n - 1 downto 0)
  );
  end component;

begin
  Q : FIFO generic map(n, 3, 8) port map(rst, clk, opr, Din, D, E, F);
  FC : fifoCtrl port map(rst, clk, flag, add, opr);
  C : Ctrl port map(rst, clk, E, F, F8_2, add);
  A : Avg generic map(n) port map(rst, clk, add, F8_2, D, Dout);
end M;
  