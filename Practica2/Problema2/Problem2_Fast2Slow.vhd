----------------------------------------------------
-- LABORATORIO 2
-- CRUCE ENTRE DOMINIOS DE RELOJ
-- SISTEMAS DIGITALES
-- MAESTRIA EN INGENIERIA ELECTRICA
----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Problem2_Fast2Slow is
end Problem2_Fast2Slow;

architecture CDC of Problem2_Fast2Slow is 

signal CLK_10: 		std_logic;
signal CLK_100:		std_logic;
signal data_fast: 	std_logic;
signal rst : std_logic;
signal a, b, c : std_logic_vector(7 downto 0);

  component master is
  generic(
    n : integer := 8
  );
  port(
    rst, clkF, clkS : in std_logic;
    D     : in std_logic;
    a, b  : in std_logic_vector(n - 1 downto 0);
    c     : out std_logic_vector(n - 1 downto 0)
  );
  end component;


begin
  rst <= '1', '0' after 10 ns;
  a <= "10101010";
  b <= "01010101";
  M : master port map(rst, CLK_100, CLK_10, data_fast, a, b, c);
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
	data_fast <= '0';
	wait for 15 ns;
	data_fast <= '1';
	wait for 10 ns;
	data_fast <= '0';
	wait;
	end process; 
	
end CDC;
