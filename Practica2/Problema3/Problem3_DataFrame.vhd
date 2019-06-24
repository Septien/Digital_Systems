----------------------------------------------------
-- LABORATORIO 2
-- CRUCE ENTRE DOMINIOS DE RELOJ
-- SISTEMAS DIGITALES
-- MAESTRIA EN INGENIERIA ELECTRICA
----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Problem3_DataFrame is
end Problem3_DataFrame;

architecture CDC of Problem3_DataFrame is 
component ROM is
   port(
      I : in  std_logic_vector(7 downto 0);
      A : out std_logic_vector(23 downto 0)
      );
end component;	 

component master is
  generic (
    n : integer := 8
  );
  port(
    clk, rst : in std_logic;
    flag : in std_logic;
    Din : in std_logic_vector(n - 1 downto 0);
    Dout : out std_logic_vector(n - 1 downto 0)
  );
end component;

  component R1 is
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


signal CLK_100KHz:		std_logic;
signal CLK_50MHz : std_logic;
signal rst : std_logic;
signal ADD: unsigned(7 downto 0) := (others => '0');	   
signal flagSin, flagSout, flagFin, flagFout : std_logic := '0';
signal Output, output2: std_logic_vector(23 downto 0);

begin  
	
	process
	begin
	CLK_100KHz <= '0';
	wait for 5 us;
	CLK_100KHz  <= '1';
	wait for 5 us;
	end process;
	
	process
	begin
	CLK_50MHz <= '0';
	wait for 10 ns;
	CLK_50MHz <= '1';
	wait for 10 ns;
	end process;
	rst <= '1', '0' after 10 ns; 

	process
	begin
    flagSin <= '1';
    wait for 10 us;
    flagSin <= '0';
    wait for 10 us;
  end process;
ADD <= ADD+1 when rising_edge(CLK_100KHz);	
RSlow : R1 port map(rst, CLK_100KHz, flagSin, flagSout);
RFast : R1 port map(rst, CLK_50MHz, flagSout, flagFin);
EdgeD : ED port map(rst, CLK_50MHZ, flagFin, flagFout);
ROM_RD: ROM port map (std_logic_vector(ADD), Output);
M : master generic map(24) port map(CLK_50MHz, rst, flagFout, Output, output2);
	
end CDC;