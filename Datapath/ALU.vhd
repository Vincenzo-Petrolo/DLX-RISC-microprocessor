library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
port (
    OP1, OP2 : in std_logic_vector(31 downto 0);
    ALU_OP : in std_logic_vector(3 downto 0);
    RES : out std_logic_vector(31 downto 0);
    ZERO : out std_logic
    );
end ALU;

architecture beh of ALU is

	signal RES_i : std_logic_vector(31 downto 0);
    
begin
    
    process (OP1, OP2, ALU_OP)
    begin
        if (ALU_OP = "0000") then
            RES_i <= OP1 and OP2;
        elsif (ALU_OP = "0001") then
            RES_i <= OP1 or OP2;
        elsif (ALU_OP = "0010") then
            RES_i <= std_logic_vector(signed(OP1) + signed(OP2));
        elsif (ALU_OP = "0110") then
            RES_i <= std_logic_vector(signed(OP1) - signed(OP2));
        elsif (ALU_OP = "0111") then
            if (OP1 < OP2) then
                RES_i <= std_logic_vector(to_unsigned(1, RES_i'length));
            else
                RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
            end if;
        elsif (ALU_OP = "1100") then
            RES_i <= OP1 nor OP2;
        else
            RES_i <= std_logic_vector(to_unsigned(0, RES_i'length));
        end if;
    end process;
    -- TO-DO: from sge to xori opecodes to be implemented
    
    process (RES_i)
    begin
        if (RES_i = std_logic_vector(to_unsigned(0, RES_i'length))) then
            ZERO <= '1';
        else
            ZERO <= '0';
        end if;
    end process;
	 
	 RES <= RES_i;
    
end beh;