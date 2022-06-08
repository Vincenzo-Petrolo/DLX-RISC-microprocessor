library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity SUM_GENERATOR_GENERIC is
  generic (
    NBIT_PER_BLOCK : integer := 4;
    NBLOCKS        : integer := 8);
  port (
    A  : in  std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
    B  : in  std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
    Ci : in  std_logic_vector(NBLOCKS-1 downto 0);
    S  : out std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0));

end entity SUM_GENERATOR_GENERIC;

architecture STRUCTURAL of SUM_GENERATOR_GENERIC is
  component CARRY_SELECT_BLOCK_GENERIC is
    generic (
      NBIT : integer := 6
      );
    port (
      C_IN : in  std_logic;
      A, B : in  std_logic_vector(NBIT-1 downto 0);
      S    : out std_logic_vector(NBIT-1 downto 0)
      );
  end component;

begin  -- architecture STRUCTURAL

  BLOCKS : for i in 1 to NBLOCKS generate
    -- iterations example: i=1 A(3 downto 0), i=2 A(7 downto 4), ...i=8 A(31
    -- downto 28)
    CARRYSELBLOCK_i : CARRY_SELECT_BLOCK_GENERIC
      generic map (NBIT => NBIT_PER_BLOCK)
      port map (A    => A(i*NBIT_PER_BLOCK-1 downto (i-1)*NBIT_PER_BLOCK),
                B    => B(i*NBIT_PER_BLOCK-1 downto (i-1)*NBIT_PER_BLOCK),
                C_IN => Ci(i-1),
                S    => S(i*NBIT_PER_BLOCK-1 downto (i-1)*NBIT_PER_BLOCK));
  end generate;


end architecture STRUCTURAL;

configuration CFG_SUM_GENERATOR_STRUCTURAL of SUM_GENERATOR_GENERIC is
  for STRUCTURAL
    for BLOCKS
      for all : CARRY_SELECT_BLOCK_GENERIC
        use configuration WORK.CONFIG_CARRY_SELECT;
      end for;
    end for;
  end for;
end configuration;
