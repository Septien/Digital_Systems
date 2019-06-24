library ieee;
use ieee.std_logic_1164.all;

entity StartC is
  port(
    rst, clk : in std_logic;
    D, EC    : in std_logic;
    ST       : out std_logic
  );
end StartC;

architecture simple of StartC is
  type state is (S0, S1);
  signal Qn, Qp : state;
begin
  combinational : process(Qp, D, EC)
  begin
    case Qp is
    when s0 =>
      if (D = '0') then
        Qn <= Qp;
      else
        Qn <= S1;
      end if;
      
      ST <= '0';
      
    when S1 =>
      if (EC = '0') then
        Qn <= Qp;
      else
        Qn <= S0;
      end if;
      
      ST <= '1';
      
    end case;
  end process combinational;
  Qp <= S0 when rst = '1' else Qn when rising_edge(clk);
  
end simple;
