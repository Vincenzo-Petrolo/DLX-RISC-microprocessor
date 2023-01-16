library ieee;
use ieee.std_logic_1164.all;
--Contains different ALU opcodes
package aluOpCodes is

    constant ALU_OPCODE_LEN : integer := 4;
    -- Arithmetical operations
    constant ALU_ADD : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0000";
    constant ALU_SUB : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0001";
    constant ALU_SLE : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0010";
    constant ALU_SGE : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0011";
    -- Logical operations
    constant ALU_AND : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0100";
    constant ALU_OR  : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0101";
    constant ALU_XOR : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0110";
    constant ALU_SLL : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "0111";
    constant ALU_SRL : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "1000";
    constant ALU_SNE : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "1001";
    constant ALU_SEQ : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "1001";
    constant ALU_SLT : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "1010";
    constant ALU_SGT : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "1011";

    constant ALU_BEQZ : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "1010";
    constant ALU_BNEZ : std_logic_vector(ALU_OPCODE_LEN - 1 downto 0) := "1011";
end aluOpCodes;