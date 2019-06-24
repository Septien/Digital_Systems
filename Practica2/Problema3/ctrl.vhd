library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Ctrl is
  port(
    rst, clk : in std_logic;
    E, F : in std_logic;
    F8_2 : out std_logic_vector(1 downto 0);
    avg : out std_logic
  );
end Ctrl;

architecture control of Ctrl is
  type state is (S0, S1, S2, S3, S4);
  signal Qn, Qp : state;
begin
  process(Qp, E, F)
  begin
    case Qp is
    when S0 =>
      if (F = '1') then
        Qn <= S1;         -- Start adding
      else
        Qn <= Qp;
      end if;
      avg <= '0';
      F8_2 <= "00";
      
    when S1 =>
      if (E = '1') then   -- Emty fifo
        Qn <= S2;
      else
        Qn <= Qp;
      end if;
      avg <= '1';         -- Start adding
      F8_2 <= "00";
      
    when S2 =>
      Qn <= S3;
      avg <= '0';
      F8_2 <= "10";
      
    when S3 =>
      if (E = '0') then
        Qn <= S4;
      else
        Qn <= Qp;
      end if;
      avg <= '0';
      F8_2 <= "00";
      
    when S4 =>
      if (E = '1') then
        Qn <= S3;
      else
        Qn <= Qp;
      end if;
      avg <= '1';
      F8_2 <= "01";
      
    end case;
  end process;
  Qp <= S0 when rst = '1' else Qn when rising_edge(clk);
end control;
