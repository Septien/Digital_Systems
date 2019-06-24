library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Addition is
  generic(
    n : integer := 8
  );
  port(
    A : in std_logic_vector(n - 1 downto 0);
    B : in std_logic_vector(n - 1 downto 0);
    C : out std_logic_vector(n downto 0)
  );
end Addition;

architecture rithmetic of Addition is
begin
  process(A, B)
  begin
    C <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
  end process;
end rithmetic;
