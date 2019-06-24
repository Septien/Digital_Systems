library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity addM is
  generic(
    n : integer := 8
  );
  port(
    Data1 : in std_logic_vector(n - 1 downto 0);
    Data2 : in std_logic_vector(n - 1 downto 0);
    add   : in std_logic;
    Result : out std_logic_vector(n - 1 downto 0)
  );
end addM;

architecture simple of addM is
begin
  process(Data1, Data2, add)
  begin
    if (add = '1') then
      Result <= std_logic_vector(unsigned(Data1) + unsigned(Data2));
    else
      Result <= Data2;
    end if;
  end process;
end simple;
