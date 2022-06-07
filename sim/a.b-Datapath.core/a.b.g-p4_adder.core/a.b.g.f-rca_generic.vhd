library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.all;
use WORK.constants.all;

entity RCA_GENERIC is
  generic (NBIT  : integer := 6;
           DRCAS : time    := 0 ns;
           DRCAC : time    := 0 ns);
  port (A  : in  std_logic_vector(NBIT-1 downto 0);
        B  : in  std_logic_vector(NBIT-1 downto 0);
        Ci : in  std_logic;
        S  : out std_logic_vector(NBIT-1 downto 0);
        Co : out std_logic);
end RCA_GENERIC;

architecture STRUCTURAL of RCA_GENERIC is

  component FA
    generic (DFAS : time := 0 ns;
             DFAC : time := 0 ns);
    port (A  : in  std_logic;
          B  : in  std_logic;
          Ci : in  std_logic;
          S  : out std_logic;
          Co : out std_logic);
  end component;

  signal CARRIES : std_logic_vector(NBIT-2 downto 0);  -- NBIT-2 because the
                                                       -- last bit would result
                                                       -- unused

begin  -- architecture STRUCTURAL

  ADDER : for i in 0 to NBIT-1 generate
    FIRST_FA : if (i = 0) generate  --on first iteration wire the Ci of the fulladder to Ci of
      --the top entity
      FA_1 : FA generic map (DFAS => DRCAS, DFAC => DRCAC)
        port map (A => A(i), B => B(i), Ci => Ci, S => S(i), Co => CARRIES(i));
    end generate;

    LAST_FA : if (i = NBIT-1) generate  --on last iteration wire the Co of the fulladder to
                                        --the Co of the top entity
      FA_NBIT : FA generic map (DFAS => DRCAS, DFAC => DRCAC)
        port map (A => A(i), B => B(i), Ci => CARRIES(i-1), S => S(i), Co => Co);
    end generate;

    OTHER_FA : if (i > 0 and i < NBIT-1) generate
      FA_i : FA generic map (DFAS => DRCAS, DFAC => DRCAC)
        port map (A => A(i), B => B(i), Ci => CARRIES(i-1), S => S(i), Co => CARRIES(i));
    end generate;
  end generate;
end architecture STRUCTURAL;

architecture BEHAVIORAL of RCA_GENERIC is

  signal S_TEMP : std_logic_vector(NBIT downto 0);

begin  -- architecture BEHAVIORAL

  S_TEMP <= (('0'&A) + ('0'&B) + Ci) after DRCAS;
  S      <= S_TEMP(NBIT-1 downto 0);
  Co     <= S_TEMP(NBIT)        after DRCAC;

end architecture BEHAVIORAL;

configuration CFG_RCA_GENERIC_STRUCT of RCA_GENERIC is
  for STRUCTURAL
    for ADDER
      for FIRST_FA
        for all : FA
          use configuration WORK.CFG_FA_BEHAVIORAL;
        end for;
      end for;

      for LAST_FA
        for all : FA
          use configuration WORK.CFG_FA_BEHAVIORAL;
        end for;
      end for;

      for OTHER_FA
        for all : FA
          use configuration WORK.CFG_FA_BEHAVIORAL;
        end for;
      end for;
    end for;
  end for;
end CFG_RCA_GENERIC_STRUCT;

configuration CFG_RCA_GENERIC_BEHAVIORAL of RCA_GENERIC is
  for BEHAVIORAL
  end for;
end CFG_RCA_GENERIC_BEHAVIORAL;
