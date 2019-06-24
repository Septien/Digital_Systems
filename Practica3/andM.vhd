library ieee;
use ieee.std_logic_1164.all;

entity andM is
  generic(
    n : integer := 8  
  );
  port(
    A : in std_logic_vector(n - 1 downto 0);
    b : in std_logic;
    C : out std_logic_vector(n - 1 downto 0);
    d : out std_logic
  );
end andM;

architecture logic of andM is
begin
  process(A, b)
  begin
    for i in 0 to n - 1 loop
      C(i) <= A(i) and b;
    end loop;
    d <= A(0) and b;
  end process;
end logic;
