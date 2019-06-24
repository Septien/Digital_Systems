library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Add is
  generic(
    n : integer := 8
  );
  port(
    rst, clk : in std_logic;
    h : in std_logic;
    a, b : in std_logic_vector(n - 1 downto 0);
    c : out std_logic_vector(n - 1 downto 0)
  );
end Add;

architecture fsm of Add is
  type state is (S0, S1);
  signal Qp, Qn : state;
begin
  combinational : process(Qp, h, a, b)
  begin
    case Qp is
      when S0 =>
        if (h = '1') then
          Qn <= S1;
        else
          Qn <= Qp;
        end if;
        c <= (others => '0');
        
      when S1 =>
        if (h = '1') then
          Qn <= Qp;
        else
          Qn <= S0;
        end if;
        c <= std_logic_vector(unsigned(a) + unsigned(b));

    end case;
  end process combinational;
  Qp <= S0 when rst = '1' else Qn when rising_edge(clk);
end fsm;
