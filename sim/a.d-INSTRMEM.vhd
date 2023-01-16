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

  type RAMtype is array (0 to 127) of std_logic_vector(31 downto 0);

  signal IRAM_mem : RAMtype;
  signal address  : std_logic_vector(31 downto 0);

begin -- IRam_Bhe
  address <= "00" & ADDR_RD(31 downto 2);
  --apply shift right by 2 positions to implement a division by 4 and access a word
  DATA_OUT <= IRAM_mem(conv_integer(unsigned(address)));

  -- purpose: This process is in charge of filling the Instruction RAM with the firmware
  -- type   : combinational
  -- inputs : Rst
  -- outputs: IRAM_mem
  FILL_MEM_P : process
    file mem_fp         : text;
    variable file_line  : line;
    variable index      : integer := 0;
    variable tmp_data_u : std_logic_vector(31 downto 0);
  begin -- process FILL_MEM_P
    file_open(mem_fp, "test.asm.mem", READ_MODE);
    while (not endfile(mem_fp)) loop
      readline(mem_fp, file_line);
      hread(file_line, tmp_data_u);
      IRAM_mem(index) <= std_logic_vector(unsigned(tmp_data_u));
      index := index + 1;
    end loop;
    wait;
  end process FILL_MEM_P;
end beh;
