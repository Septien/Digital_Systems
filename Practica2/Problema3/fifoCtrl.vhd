library ieee;
use ieee.std_logic_1164.all;

entity fifoCtrl is
  port(
    rst, clk : in std_logic;
    flag, add : in std_logic;
    opr : out std_logic_vector(1 downto 0)
  );
end fifoCtrl;

architecture Control of fifoCtrl is
  type state is (S0, S1, S2, S3);
  signal Qn, Qp : state;
  
begin
  process(Qp, flag, add)
  begin
    case Qp is
    when S0 =>                  -- Wait for first data to arrive
      if (flag = '1') then      -- A pulse arrives
        Qn <= S1;
      else
        Qn <= Qp;
      end if;
      opr <= "11";              -- Set fifo state to nop
      
    when S1 =>                  -- Store data at fifo
      Qn <= S2;
      opr <= "10";              -- Set fifo state to write
      
    when S2 =>                  -- Wait for data or signal of adding
      if (flag = '0' and add = '0') then  -- No pulse, no avarage
        Qn <= Qp;
      elsif (flag = '1') then             -- Pulse
        Qn <= S1;
      else
        Qn <= S3;                         -- Avarage
      end if;
      opr <= "11";              -- Set fifo state to nop
      
    when S3 =>                  -- Compute avarage
      if (add = '1') then       -- Keep adding
        Qn <= Qp;
      else
        Qn <= S2;
      end if;
      opr <= "01";              -- Set fifo state to read
      
    end case;
  end process;
        
  Qp <= S0 when rst = '1' else Qn when rising_edge(clk);
end Control;
