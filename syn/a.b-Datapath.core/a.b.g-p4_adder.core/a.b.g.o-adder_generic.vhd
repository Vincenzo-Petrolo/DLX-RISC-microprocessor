library IEEE;
use IEEE.std_logic_1164.all;

entity adder_generic is
  generic (NBIT           : integer := 32;
           NBIT_PER_BLOCK : integer := 4);
  port (A    : in  std_logic_vector (NBIT-1 downto 0);
        B    : in  std_logic_vector (NBIT-1 downto 0);
        Cin  : in  std_logic;
        Cout : out std_logic;
        S    : out std_logic_vector (NBIT-1 downto 0));
end adder_generic;

architecture add_struct of adder_generic is
  component CLA is
    generic (NBIT           : integer := 32;
             NBIT_PER_BLOCK : integer := 4);
    port (A   : in  std_logic_vector (NBIT-1 downto 0);
          B   : in  std_logic_vector (NBIT-1 downto 0);
          Cin : in  std_logic;
          Co  : out std_logic_vector ((NBIT/NBIT_PER_BLOCK)-1 downto 0));
  end component;

  component SUM_GENERATOR_GENERIC is
    generic (
      NBIT_PER_BLOCK : integer := 4;
      NBLOCKS        : integer := 8);
    port (
      A  : in  std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
      B  : in  std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
      Ci : in  std_logic_vector(NBLOCKS-1 downto 0);
      S  : out std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0));

  end component;

  signal carries : std_logic_vector ((NBIT/NBIT_PER_BLOCK) downto 0);
  signal xored_B : std_logic_vector(NBIT-1 downto 0);

begin
  -- map the first carry
  carries(0) <= Cin;

  xor_b: for i in 0 to NBIT-1 generate
    xored_B(i) <= B(i) xor Cin;
  end generate xor_b;

  carry : CLA generic map (NBIT, NBIT_PER_BLOCK) port map (A, xored_B, Cin, carries(NBIT/NBIT_PER_BLOCK downto 1));
  sum   : SUM_GENERATOR_GENERIC generic map (NBIT_PER_BLOCK, NBIT/NBIT_PER_BLOCK) port map (A => A, B => xored_B, Ci => carries(NBIT/NBIT_PER_BLOCK-1 downto 0), S => S);
  Cout <= carries(NBIT/NBIT_PER_BLOCK);

end architecture;

configuration CFG_ADDER_GENERIC_STRUCT of adder_generic is
  for add_struct
    for sum : SUM_GENERATOR_GENERIC use configuration WORK.CFG_SUM_GENERATOR_STRUCTURAL;
    end for;
  end for;
end CFG_ADDER_GENERIC_STRUCT;
