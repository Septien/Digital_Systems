----------------------------------------------------
-- LABORATORIO 2
-- CRUCE ENTRE DOMINIOS DE RELOJ
-- SISTEMAS DIGITALES
-- MAESTRIA EN INGENIERIA ELECTRICA
----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Problem1_Slow2Fast is
end Problem1_Slow2Fast;

architecture CDC of Problem1_Slow2Fast is 

signal CLK_10: 		std_logic;
signal CLK_100:		std_logic;
signal data_slow: 	std_logic;
signal rst : std_logic;
signal a, b, c : std_logic_vector(7 downto 0);

component master is
  generic(
    n : integer := 8
  );
  port(
    clkS, clkF, rst : in std_logic;
    a, b : in std_logic_vector(n - 1 downto 0);
    D : in std_logic;
    c : out std_logic_vector(n - 1 downto 0)
  );
end component;

begin  
  M : master port map(CLK_10, CLK_100, rst, a, b, data_slow, c);
  rst <= '1', '0' after 10 ns;
  a <= "10101010";
  b <= "01010101";
	process
	begin
	CLK_10 <= '0';
	wait for 50 ns;
	CLK_10 <= '1';
	wait for 50 ns;
	end process; 
	
	process
	begin
	CLK_100 <= '0';
	wait for 5 ns;
	CLK_100 <= '1';
	wait for 5 ns;
	end process; 
	
	
	
	process
	begin
	data_slow <= '0';
	wait for 100 ns;
	data_slow <= '1';
	wait for 100 ns;
	data_slow <= '0';
	wait;
	end process; 	
	
	
end CDC;

	
	
