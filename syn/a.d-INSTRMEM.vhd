library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity INSTRMEM is
  port (
    ADDR_RD  : in std_logic_vector(31 downto 0);
    DATA_OUT : out std_logic_vector(31 downto 0)
  );
end INSTRMEM;

architecture beh of INSTRMEM is
begin
end beh;
