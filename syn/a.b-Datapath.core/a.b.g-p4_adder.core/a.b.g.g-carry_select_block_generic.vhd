library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.all;

entity CARRY_SELECT_BLOCK_GENERIC is
  generic (
    NBIT : integer := 6
    );
  port (
    C_IN : in  std_logic;
    A, B : in  std_logic_vector(NBIT-1 downto 0);
    S    : out std_logic_vector(NBIT-1 downto 0)
    );
end entity CARRY_SELECT_BLOCK_GENERIC;

architecture STRUCTURAL of CARRY_SELECT_BLOCK_GENERIC is
  component RCA_GENERIC is
    generic (NBIT  : integer := 6);
    port (A  : in  std_logic_vector(NBIT-1 downto 0);
          B  : in  std_logic_vector(NBIT-1 downto 0);
          Ci : in  std_logic;
          S  : out std_logic_vector(NBIT-1 downto 0);
          Co : out std_logic);
  end component;

  component MUX21_GENERIC is
    generic (NBIT      : integer := 6);
    port (A   : in  std_logic_vector(NBIT-1 downto 0);
          B   : in  std_logic_vector(NBIT-1 downto 0);
          SEL : in  std_logic;
          Y   : out std_logic_vector(NBIT-1 downto 0));
  end component;

  signal S0, S1   : std_logic_vector(NBIT-1 downto 0);
  signal Co0, Co1 : std_logic; --not used and left floating

begin

  RCA0 : RCA_GENERIC generic map(NBIT => NBIT)
    port map(
      A => A, B => B, Ci => '0',
      S => S0, Co => Co0
      );
  RCA1 : RCA_GENERIC generic map(NBIT => NBIT)
    port map(
      A => A, B => B, Ci => '1',
      S => S1, Co => Co1
      );
  MUX : MUX21_GENERIC generic map(NBIT => NBIT)
    port map(
      A   => S0, B => S1,
      SEL => C_IN,
      Y   => S
      );

end STRUCTURAL;

configuration CONFIG_CARRY_SELECT of CARRY_SELECT_BLOCK_GENERIC is
  for STRUCTURAL
    for RCA0 : RCA_GENERIC use configuration WORK.CFG_RCA_GENERIC_BEHAVIORAL;
    end for;
    for RCA1 : RCA_GENERIC use configuration WORK.CFG_RCA_GENERIC_BEHAVIORAL;
    end for;
    for MUX : MUX21_GENERIC use configuration WORK.CFG_MUX21_GEN_BEHAVIORAL;
    end for;
  end for;
end configuration CONFIG_CARRY_SELECT;
