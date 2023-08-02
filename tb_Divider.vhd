library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Testbench_Divider is
end entity Testbench_Divider;

architecture Behavioral of Testbench_Divider is
    signal clk : STD_LOGIC := '0';
    signal start : STD_LOGIC := '0';
    signal dividend : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000001100100"; -- 100
    signal divisor : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000110"; -- 6
    signal quotient : STD_LOGIC_VECTOR(31 downto 0);
    signal remainder : STD_LOGIC_VECTOR(31 downto 0);
    signal done : STD_LOGIC := '0';
    
    constant CLK_PERIOD : time := 5 ns; -- Adjust the clock period as needed
    
begin
    -- Clock process
    process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Instantiate the Divider
    DUT: entity work.Divider
        port map (
            clk => clk,
            start => start,
            dividend => dividend,
            divisor => divisor,
            quotient => quotient,
            remainder => remainder,
            done => done
        );
    
    -- Reset process
    process
    begin
        start <= '0';
        wait for 10 ns;
        start <= '1';
        wait for 100 ns;
        start <= '0';
        wait;
    end process;
    
    -- Stimulus process
    process
    begin
        wait for 20 ns;
        -- Add more test cases if needed
        wait for 20 ns;
        wait for 20 ns;
        wait for 20 ns;
        wait for 20 ns;
        wait for 20 ns;
        wait for 20 ns;
        wait for 20 ns;
        wait for 20 ns;
        wait;
    end process;
    
end architecture Behavioral;
