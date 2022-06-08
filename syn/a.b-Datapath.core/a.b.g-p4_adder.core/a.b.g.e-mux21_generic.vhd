library IEEE;

use IEEE.std_logic_1164.all;




entity MUX21_GENERIC is
  generic (NBIT      : integer := 4);
  port (A   : in  std_logic_vector(NBIT-1 downto 0);
        B   : in  std_logic_vector(NBIT-1 downto 0);
        SEL : in  std_logic;
        Y   : out std_logic_vector(NBIT-1 downto 0));
end MUX21_GENERIC;


architecture BEH of MUX21_GENERIC is
begin
  MUX_PROCESS : process (A, B, SEL)
  begin
    if (SEL = '0') then
      Y <= A;
    else
      Y <= B;
    end if;
  end process;
end BEH;

configuration CFG_MUX21_GEN_BEHAVIORAL of MUX21_GENERIC is
  for BEH
  end for;
end CFG_MUX21_GEN_BEHAVIORAL;
