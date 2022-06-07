library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity CLA is
  generic (NBIT           : integer := 32;
           NBIT_PER_BLOCK : integer := 8);
  port (A   : in  std_logic_vector (NBIT-1 downto 0);
        B   : in  std_logic_vector (NBIT-1 downto 0);
        Cin : in  std_logic;
        Co  : out std_logic_vector ((NBIT/NBIT_PER_BLOCK)-1 downto 0));
end CLA;

architecture structural_generic of CLA is
  component pgb is
    port (ai : in  std_logic;
          bi : in  std_logic;
          p  : out std_logic;
          g  : out std_logic);
  end component;

  component PG is
    port (Pik  : in  std_logic;
          Pdkj : in  std_logic;
          Gik  : in  std_logic;
          Gdkj : in  std_logic;
          Pij  : out std_logic;
          Gij  : out std_logic);
  end component;

  component G is
    port (Pik  : in  std_logic;
          Gik  : in  std_logic;
          Gdkj : in  std_logic;
          Gij  : out std_logic);
  end component;

  function log2 (value : positive) return natural is

    variable temp_log : natural := 0;

  begin

    while(2**(temp_log+1) <= value) and temp_log < 31 loop
      temp_log := temp_log + 1;
    end loop;

    return temp_log;

  end function;

  type signal_matrix is array(0 to log2(NBIT)) of std_logic_vector(0 to NBIT-1);
  signal pi_matrix                : signal_matrix;
  signal gi_matrix                : signal_matrix;
  signal p_pgb00_G00, g_pgb00_G00 : std_logic;

  constant I_MULTIPLIER : integer := NBIT_PER_BLOCK;

begin

--generate the first layer of PG blocks
  PG_NETWORK : for i in 0 to NBIT-1 generate
    carry_in_PG_G: if (i = 0) generate
      PG_0 : pgb port map(ai => A(i), bi => B(i), p => p_pgb00_G00, g => g_pgb00_G00);
      G_0  : G port map(Pik  => p_pgb00_G00,
                        Gik  => g_pgb00_G00,
                        Gdkj => Cin,
                        Gij  => gi_matrix(0)(i));
    end generate carry_in_pg_g;
    std_PG: if (i >= 1) generate
      PG_i : pgb port map(ai => A(i), bi => B(i), p => pi_matrix(0)(i), g => gi_matrix(0)(i));
    end generate std_PG;
  end generate;
  --generate the first tree
  FIRST_SUBGROUPING : for depth in 1 to log2(NBIT_PER_BLOCK) generate
    FIRST_MERGE : for j in 0 to NBIT_PER_BLOCK/(2**depth) -2 generate
      -- then there's space for PG block
      INITIAL_PG_i : PG port map(Pik  => pi_matrix(depth-1)(NBIT_PER_BLOCK-1 - j*(2**depth)),
                                 Gik  => gi_matrix(depth-1)(NBIT_PER_BLOCK-1 - j*(2**depth)),
                                 Pdkj => pi_matrix(depth-1)(NBIT_PER_BLOCK-1 -j*(2**depth) - 2**(depth-1)),
                                 Gdkj => gi_matrix(depth-1)(NBIT_PER_BLOCK-1 -j*(2**depth) - 2**(depth-1)),
                                 Pij => pi_matrix(depth)(NBIT_PER_BLOCK-1 -j*(2**depth)),
                                 Gij  => gi_matrix(depth)(NBIT_PER_BLOCK-1 -j*(2**depth)));
    end generate;
    INITIAL_G_i : G port map(Pik  => pi_matrix(depth-1)(2**depth -1),
                             Gik  => gi_matrix(depth-1)(2**depth -1),
                             Gdkj => gi_matrix(depth-1)(2**(depth-1) - 1),
                             Gij  => gi_matrix(depth)(2**depth -1));
  end generate;
  --now start the generic algo, with i starting from 2 bc the first group was
  --already done
  TREE : for i in 2 to NBIT/NBIT_PER_BLOCK generate
    SUBGROUPING : for depth in 1 to log2(NBIT_PER_BLOCK) generate
      MERGE : for j in 0 to NBIT_PER_BLOCK/(2**depth) -1 generate
        PG_i : PG port map(Pik  => pi_matrix(depth-1)(i*I_MULTIPLIER-1 - j*(2**depth)),
                           Gik  => gi_matrix(depth-1)(i*I_MULTIPLIER-1 - j*(2**depth)),
                           Pdkj => pi_matrix(depth-1)(i*I_MULTIPLIER-1 -j*(2**depth) -2**(depth-1)),
                           Gdkj => gi_matrix(depth-1)(i*I_MULTIPLIER-1 -j*(2**depth) -2**(depth-1)),
                           Pij  => pi_matrix(depth)(i*I_MULTIPLIER -j*(2**depth) -1),
                           Gij  => gi_matrix(depth)(i*I_MULTIPLIER -j*(2**depth) -1));
      end generate;
    end generate;

    -- if i add 1 PG is the number greater than log2(column_i) -1?
    REMAINING_PG : for depth in log2(NBIT_PER_BLOCK) to log2(i*I_MULTIPLIER)-2 generate
      REMAINING_PG_i : PG port map(Pik  => pi_matrix(depth)(i*I_MULTIPLIER-1),
                                   Gik  => gi_matrix(depth)(i*I_MULTIPLIER-1),
                                   Pdkj => pi_matrix(depth)(i*I_MULTIPLIER-1-2**(depth)),
                                   Gdkj => gi_matrix(depth)(i*I_MULTIPLIER-1-2**(depth)),
                                   Pij  => pi_matrix(depth+1)(i*I_MULTIPLIER-1),
                                   Gij  => gi_matrix(depth+1)(i*I_MULTIPLIER-1));

    end generate;
    -- add the final G block on multiple of NBIT_PER_BLOCK
    FINAL_G_i : G port map (Pik  => pi_matrix(log2(i*I_MULTIPLIER)-1)(i*I_MULTIPLIER-1),
                            Gik  => gi_matrix(log2(i*I_MULTIPLIER)-1)(i*I_MULTIPLIER-1),
                            Gdkj => gi_matrix(log2(2**log2(i*I_MULTIPLIER-1)))(2**log2(i*I_MULTIPLIER-1)-1),
                            Gij  => gi_matrix(log2(i*I_MULTIPLIER))(i*I_MULTIPLIER-1));

  end generate;

  --finally, map to the output
  COUT_MAPPING : for i in 1 to (NBIT/NBIT_PER_BLOCK) generate
    Co(i-1) <= gi_matrix(log2(i*NBIT_PER_BLOCK))(i*NBIT_PER_BLOCK-1);
  end generate;
end structural_generic;
