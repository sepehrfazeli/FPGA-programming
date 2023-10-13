library ieee;
use ieee.std_logic_1164.all;

entity e_my_4bit2to1mux is
    port (
        sw    : in    std_logic_vector (9 downto 0);
        LEDR  : out   std_logic_vector (9 downto 0)
    );
end entity e_my_4bit2to1mux;

architecture a_my_4bit2to1mux_1 of e_my_4bit2to1mux is
    signal s : std_logic; -- Declare s as a signal
    signal X,Y : std_logic_vector(3 downto 0); -- Declare X, M as a signal

begin
    process(sw)
    begin
        s <= sw(9); -- Assign sw(9) to signal s
        X <= sw(3 downto 0); -- Assign SW[3-0] to signal X
        Y <= sw(7 downto 4); -- Assign SW[7-4] to signal Y
        -- Use s as the address input
        -- Use X as input vector X
        -- Use Y as input vector Y
        -- Output M is selected based on the value of the address input
        LEDR(9) <= s;
        LEDR(3 downto 0) <= (others => '0'); -- Initialize LEDR[3-0] to 0

        if s = '0' then
            LEDR(3 downto 0) <= X; -- Select X
        else
            LEDR(3 downto 0) <= Y; -- Select Y
        end if;
    end process;
end architecture a_my_4bit2to1mux_1;
