library ieee;
use ieee.std_logic_1164.all;

entity e_my_2bit3to1mux is
port (
SW : in std_logic_vector(9 downto 0);
LEDR : out std_logic_vector(9 downto 0));
end entity e_my_2bit3to1mux;

architecture a_my_2bit3to1mux of e_my_2bit3to1mux is

-- Declaration Part

-- Signal declaration

signal slv_S_int : std_logic_vector(1 downto 0);
signal slv_U_int, slv_V_int, slv_W_int : std_logic_vector(1 downto 0);
signal slv_X_int, slv_M_int : std_logic_vector(1 downto 0);

begin

slv_U_int <= SW(1 downto 0);
slv_V_int <= SW(3 downto 2);
slv_W_int <= SW(5 downto 4);
slv_S_int (1 downto 0) <= SW(9 downto 8);

-- logic

gen_slv_X_and_slv_M: for j in 0 to 1 generate
slv_X_int(j) <= (not(slv_S_int(0)) and slv_U_int(j)) or (slv_S_int(0) and slv_V_int(j));
slv_M_int(j) <= (not(slv_S_int(1)) and slv_X_int(j)) or (slv_S_int(1) and slv_W_int(j));
end generate;

LEDR(1 downto 0) <= slv_M_int;
LEDR(9 downto 2) <= "00000000";


end architecture a_my_2bit3to1mux;
