library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FIFO is
  generic(
    m : integer := 8;     -- Number of bits
    n : integer := 2;     -- Address lines
    k : integer := 8      -- Number of data
  );
  port(
    rst, clk : in std_logic;
    opr : in std_logic_vector(1 downto 0);
    inD : in std_logic_vector(m - 1 downto 0);
    outD : out std_logic_vector(m - 1 downto 0);
    E, F : out std_logic
  );
end FIFO;

architecture Narray of FIFO is
  subtype RegisterWidth is std_logic_vector(m - 1 downto 0);
  type memory is array(natural range <>) of RegisterWidth;
  signal RAM : memory(0 to k - 1);
  signal AE, AS : std_logic_vector(n - 1 downto 0);
  signal FP, EP : std_logic;
begin
  Output : process(As, EP, FP, RAM)
  begin
    outD <= RAM(conv_integer(unsigned(AS)));
    F <= FP;
    E <= EP;
  end process Output;
  
  Control : process(rst, clk)
  begin
    if (rst = '1') then
      AE <= (others => '0');
      AS <= (others => '0');
      EP <= '1';                  -- Empty memory
      FP <= '0';                  -- Non-full memory
    elsif (rising_edge(clk)) then
      case opr is
      when "00" =>                -- Read/write
        AE <= AE + 1;
        AS <= AS + 1;
        RAM(conv_integer(unsigned(AE))) <= inD;
      
      when "01" =>                -- Read only
        if (EP = '0') then        -- Non-empty memory
          if ((AS + 1) = AE) then
            EP <= '1';
          end if;
          AS <= AS + 1;
        end if;
        FP <= '0';
      
      when "10" =>                -- Write only
        if (FP = '0') then        -- Non-full memory
            RAM(conv_integer(unsigned(AE))) <= inD;
            if ((AE + 1) = AS) then
              FP <= '1';          -- Full memory
            end if;
            AE <= AE + 1;
          end if;
          EP <= '0';              -- Non-empty memory
      when others => null;
      end case;
    end if;
  end process Control;
end NArray;
