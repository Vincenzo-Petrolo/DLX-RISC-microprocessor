library IEEE;

use IEEE.std_logic_1164.all;
use WORK.constants.all;



entity MUX21_GENERIC is
  generic (NBIT      : integer := numBit;
           DELAY_MUX : time    := tp_mux);
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
      Y <= A after DELAY_MUX;
    else
      Y <= B after DELAY_MUX;
    end if;
  end process;
end BEH;

architecture STRUCT of MUX21_GENERIC is
  component ND2

    port (A : in  std_logic;
          B : in  std_logic;
          Y : out std_logic);
  end component;

  component IV

    port (A : in  std_logic;
          Y : out std_logic);
  end component;

  signal S_INV                  : std_logic;
  signal NAND_OUT_A, NAND_OUT_B : std_logic_vector(NBIT - 1 downto 0);
begin  -- architecture STRUCT

  INV : IV port map(A => SEL, Y => S_INV);

  GENERATION_LOOP : for i in 0 to NBIT - 1 generate
    A_NAND_i   : ND2 port map(A => SEL, B => B(i), Y => NAND_OUT_A(i));
    B_NAND_i   : ND2 port map(A => S_INV, B => A(i), Y => NAND_OUT_B(i));
    NAND_OUT_i : ND2 port map(A => NAND_OUT_A(i), B => NAND_OUT_B(i), Y => Y(i));
  end generate;

end architecture STRUCT;

configuration CFG_MUX21_GEN_BEHAVIORAL of MUX21_GENERIC is
  for BEH
  end for;
end CFG_MUX21_GEN_BEHAVIORAL;

configuration CFG_MUX21_GEN_STRUCTURAL of MUX21_GENERIC is
  for STRUCT
  end for;
end CFG_MUX21_GEN_STRUCTURAL;
