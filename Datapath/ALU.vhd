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

    signal RES_i : std_logic_vector(31 downto 0);

begin

    process (OP1, OP2, ALU_OP)
    begin
        if (ALU_OP = ALU_AND) then
            RES_i <= OP1 and OP2;
        elsif (ALU_OP = ALU_OR) then
            RES_i <= OP1 or OP2;
        elsif (ALU_OP = ALU_ADD) then
            RES_i <= std_logic_vector(signed(OP1) + signed(OP2));
        elsif (ALU_OP = ALU_SUB) then
            RES_i <= std_logic_vector(signed(OP1) - signed(OP2));
        elsif (ALU_OP = ALU_SLE) then
            if (OP1 <= OP2) then --maybe this notation doesnt work
                RES_i   <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = ALU_SGE) then
            if (OP1 >= OP2) then
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
        elsif (ALU_OP = ALU_XOR) then
            RES_i <= OP1 xor OP2;
        elsif (ALU_OP = ALU_SLL) then
            RES_i <= std_logic_vector(shift_left(unsigned(OP1),to_integer(unsigned(OP2))));
        elsif (ALU_OP = ALU_SRL) then
            RES_i <= std_logic_vector(shift_right(unsigned(OP1),to_integer(unsigned(OP2))));
		elsif (ALU_OP = ALU_BEQZ) then
            RES_i <= OP1;
		elsif (ALU_OP = ALU_BNEZ) then
            RES_i <= OP1;
        else
            RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
        end if;
    end process;

    process (RES_i,ALU_OP)
    begin
        if (RES_i = std_logic_vector(to_unsigned(0, RES_i'length)) and ALU_OP = ALU_BEQZ) then
            ZERO <= '1';
        elsif(RES_i /= std_logic_vector(to_unsigned(0, RES_i'length)) and ALU_OP = ALU_BNEZ) then
            ZERO <= '1';
		else
			ZERO <= '0';
        end if;
    end process;

    RES <= RES_i;

end beh;
