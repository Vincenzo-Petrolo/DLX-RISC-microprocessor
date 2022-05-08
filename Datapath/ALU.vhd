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

    
begin
    
    process (OP1, OP2, ALU_OP)
    begin
        if (ALU_OP = "0000") then
            RES <= OP1 and OP2;
        elsif (ALU_OP = "0001") then
            RES <= OP1 or OP2;
        elsif (ALU_OP = "0010") then
            RES <= std_logic_vector(unsigned(OP1) + unsigned(OP2));
        elsif (ALU_OP = "0110") then
            RES <= std_logic_vector(unsigned(OP1) - unsigned(OP2));
        elsif (ALU_OP = "0111") then
            if (OP1 < OP2) then
                RES <= std_logic_vector(unsigned(1));
            else
                RES <= std_logic_vector(unsigned(0));
            end if;
        elsif (ALU_OP = "1100") then
            RES <= OP1 nor OP2;
        else
            RES <= std_logic_vector(unsigned(0));
        end if;
    end process;
    
    process (RES)
    begin
        if (RES = std_logic_vector(unsigned(0))) then
            ZERO <= '1';
        else
            ZERO <= '0';
        end if;
    end process;
    
end beh;