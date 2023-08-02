library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Divider is
    Port ( clk : in STD_LOGIC;
           start : in STD_LOGIC;
           dividend : in STD_LOGIC_VECTOR(31 downto 0);
           divisor : in STD_LOGIC_VECTOR(31 downto 0);
           quotient : out STD_LOGIC_VECTOR(31 downto 0);
           remainder : out STD_LOGIC_VECTOR(31 downto 0);
           done : out STD_LOGIC);
end Divider;

architecture Behavioral of Divider is
    signal r : unsigned(63 downto 0);
    signal q : unsigned(31 downto 0);
    signal count : integer := 0;
    signal state : integer := 0; -- FSM state
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is
                when 0 => -- Idle state
                    if start = '1' then
                        r <= unsigned(dividend) & "00000000000000000000000000000000";
                        q <= (others => '0');
                        count <= 0;
                        state <= 1;
                    end if;
                when 1 => -- Division loop
                    if r(63) = '1' then
                        r(63 downto 32) <= r(63 downto 32) + unsigned(divisor);
                    else
                        r(63 downto 32) <= r(63 downto 32) - unsigned(divisor);
                    end if;
                    r <= r sll 1; -- Now it should work fine since r is of type unsigned
                    q(30 downto 0) <= q(31 downto 1);
                    if r(63) = '1' then
                        q(31) <= '0';
                    else
                        q(31) <= '1';
                    end if;
                    count <= count + 1;
                    if count = 31 then
                        state <= 2;
                    end if;
                when 2 => -- Final correction
                    if r(63) = '1' then
                        r(63 downto 32) <= r(63 downto 32) + unsigned(divisor);
                        q(31) <= '0';
                    end if;
                    quotient <= std_logic_vector(q);
                    remainder <= std_logic_vector(r(63 downto 32));
                    done <= '1';
                    state <= 0;
                when others => 
                    state <= 0;
            end case;
        end if;
    end process;
end Behavioral;
