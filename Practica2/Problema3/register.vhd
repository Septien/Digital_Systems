library ieee;
use ieee.std_logic_1164.all;

-- Register
entity R is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    D : in std_logic_vector(n - 1 downto 0);
    Q : out std_logic_vector(n - 1 downto 0)
  );
end R;

architecture store of R is
  signal Qn, Qp : std_logic_vector(n - 1 downto 0);
begin
  process(D)
  begin
    Qn <= D;
  end process;
  Qp <= (others => '0') when rst = '1' else Qn when rising_edge(clk);
  Q <= Qp;
end store;
