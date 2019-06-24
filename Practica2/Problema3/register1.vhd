library ieee;
use ieee.std_logic_1164.all;

-- Register
entity R1 is
  port(
    rst, clk : in std_logic;
    D : in std_logic;
    Q : out std_logic
  );
end R1;

architecture store of R1 is
  signal Qn, Qp : std_logic;
begin
  process(D)
  begin
    Qn <= D;
  end process;
  Qp <= '0' when rst = '1' else Qn when rising_edge(clk);
  Q <= Qp;
end store;
