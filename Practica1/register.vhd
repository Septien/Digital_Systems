library ieee;
use ieee.std_logic_1164.all;

entity R is
  generic(
    n : integer := 8
  );
  port(
    clk, rst : in std_logic;
    input    : in std_logic_vector(n - 1 downto 0);
    output   : out std_logic_vector(n - 1 downto 0)
  );
end R;

architecture store of R is
  signal Qn, Qp : std_logic_vector(n - 1 downto 0);
begin
  process(input)
  begin
    Qn <= input;
  end process;
  Qp <= (others => '0') when rst = '0' else Qn when rising_edge(clk);
  output <= Qp;
end store;
