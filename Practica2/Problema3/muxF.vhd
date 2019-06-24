library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity muxF is
  generic(
    n : integer := 8;
    m : integer := 8;
    k : integer := 2;
    l : integer := 1
  );
  port(
    flag8_2 : in std_logic_vector(1 downto 0);
    divisor : out std_logic_vector(n - 1 downto 0)
  );
end muxF;

architecture simple of muxF is
begin
  process(flag8_2)
  begin
    case flag8_2 is
    when "00" =>
      divisor <= std_logic_vector(to_unsigned(l, n));
      
    when "01" =>
      divisor <= std_logic_vector(to_unsigned(k, n));
      
    when others =>
      divisor <= std_logic_vector(to_unsigned(m, n));
    end case;
  end process;
end simple;
