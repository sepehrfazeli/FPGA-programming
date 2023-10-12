library ieee;
use ieee.std_logic_1164.all;

entity e_my_first_fpga is
 port (	sw		:	in		std_logic_vector (9 downto 0);
			LEDR	:	out	std_logic_vector (9 downto 0));
end entity e_my_first_fpga;

architecture e_my_first_project_1 of e_my_first_fpga is 

begin 
	--LEDR(0) <=	sw(0);
	LEDR <=	sw;

end architecture e_my_first_project_1;