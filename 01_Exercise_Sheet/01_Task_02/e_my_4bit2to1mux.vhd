library ieee;
use ieee.std_logic_1164.all;

entity e_my_4bit2to1mux is
port (
SW : in std_logic_vector(9 downto 0);
LEDR : out std_logic_vector(9 downto 0));
end entity e_my_4bit2to1mux;

architecture a_my_4bit2to1mux of e_my_4bit2to1mux is

-- Declaration Part

-- Signal declaration

signal s1_S_int : std_logic;
signal s1v_X_int, s1v_Y_int, slv_M_int : std_logic_vector(3 downto 0);

begin

s1v_X_int <= SW(3 downto 0);
s1v_Y_int <= SW(7 downto 4);
s1_S_int <= SW(9);


slv_M_int: for j in 0 to 3 generate
slv_M_int(j) <= (not(s1_S_int) and s1v_X_int(j)) or (s1_S_int and s1v_Y_int(j));
end generate;


LEDR(9) <= s1_S_int;
LEDR(8 downto 4) <= "00000";
LEDR(3 downto 0) <= slv_M_int;


end architecture a_my_4bit2to1mux;
