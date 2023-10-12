library ieee;
use ieee.std_logic_1164.all;

entity e_my_2bit3to1mux is
    port (
        sw    : in    std_logic_vector (9 downto 0);
        LEDR  : out   std_logic_vector (9 downto 0)
    );
end entity e_my_2bit3to1mux;

architecture a_my_2bit3to1mux_1 of e_my_2bit3to1mux is
begin
    process(sw)
    begin
        -- Use SW[9-8] as the 2-bit address input
        -- Use SW[5-0] as the input vectors U, V, and W
        -- Output M is selected based on the value of the address input
        LEDR(1 downto 0) <= (others => '0'); -- Initialize LEDR[1-0] to 0

        if sw(9 downto 8) = "00" then
            LEDR(1 downto 0) <= sw(5 downto 4); -- Select U
        elsif sw(9 downto 8) = "01" then
            LEDR(1 downto 0) <= sw(3 downto 2); -- Select V
        elsif sw(9 downto 8) = "10" then
            LEDR(1 downto 0) <= sw(1 downto 0); -- Select W
        else
            LEDR(1 downto 0) <= (others => '0'); -- Default: M = 0
        end if;
    end process;
end architecture a_my_2bit3to1mux_1;
