library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.aluOpCodes.all;


entity ALU is
    port (
        OP1, OP2 : in std_logic_vector(31 downto 0);
        ALU_OP   : in std_logic_vector(3 downto 0);
        RES      : out std_logic_vector(31 downto 0);
        ZERO     : out std_logic
    );
end ALU;

architecture beh of ALU is

	component adder_generic is
	  generic (NBIT           : integer := 32;
		       NBIT_PER_BLOCK : integer := 4);
	  port (A    : in  std_logic_vector (NBIT-1 downto 0);
		    B    : in  std_logic_vector (NBIT-1 downto 0);
		    Cin  : in  std_logic;
		    Cout : out std_logic;
		    S    : out std_logic_vector (NBIT-1 downto 0));
	end component;

    signal RES_i : std_logic_vector(31 downto 0);
	signal P4_A_i, P4_B_i, P4_S_i : std_logic_vector(31 downto 0);
	signal P4_Cin_i, P4_Cout_i : std_logic;

begin
	
	ADDER : adder_generic generic map (NBIT => 32, NBIT_PER_BLOCK => 4) port map(A => P4_A_i, B => P4_B_i, Cin => P4_Cin_i, Cout => P4_Cout_i, S => P4_S_i);
	P4_A_i <= OP1; P4_B_i <= OP2;
    process (OP1, OP2, ALU_OP, P4_S_i, P4_Cout_i)
    begin
        if (ALU_OP = ALU_AND) then
            RES_i <= OP1 and OP2;
        elsif (ALU_OP = ALU_OR) then
            RES_i <= OP1 or OP2;
        elsif (ALU_OP = ALU_ADD) then
			P4_Cin_i <= '0';
            RES_i <= P4_S_i; -- Map the result only when if condition is true
        elsif (ALU_OP = ALU_SUB) then
            P4_Cin_i <= '1'; -- Set carry in to 1 to trigger subtraction
            RES_i <= P4_S_i; -- Map the result only when if condition is true
        elsif (ALU_OP = ALU_SLE) then
            if (signed(OP1) <= signed(OP2)) then --maybe this notation doesnt work
                RES_i   <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = ALU_SGE) then
            if (signed(OP1) >= signed(OP2)) then
                RES_i <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = ALU_SNE) then
            if (OP1 /= OP2) then
                RES_i <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = ALU_SEQ) then
            if (OP1 = OP2) then
                RES_i <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = ALU_SLT) then
            if (signed(OP1) < signed(OP2)) then
                RES_i <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = ALU_SGT) then
            if (signed(OP1) > signed(OP2)) then
                RES_i <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = ALU_XOR) then
            RES_i <= OP1 xor OP2;
        elsif (ALU_OP = ALU_SLL) then
            RES_i <= std_logic_vector(shift_left(unsigned(OP1), to_integer(unsigned(OP2))));
        elsif (ALU_OP = ALU_SRL) then
            RES_i <= std_logic_vector(shift_right(unsigned(OP1), to_integer(unsigned(OP2))));
        elsif (ALU_OP = ALU_BEQZ) then
            RES_i <= OP1;
        elsif (ALU_OP = ALU_BNEZ) then
            RES_i <= OP1;
        else
            RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
        end if;
    end process;

    process (RES_i, ALU_OP)
    begin
        if (RES_i = std_logic_vector(to_unsigned(0, RES_i'length)) and ALU_OP = ALU_BEQZ) then
            ZERO <= '1';
        elsif (RES_i /= std_logic_vector(to_unsigned(0, RES_i'length)) and ALU_OP = ALU_BNEZ) then
            ZERO <= '1';
        else
            ZERO <= '0';
        end if;
    end process;

    RES <= RES_i;

end beh;
