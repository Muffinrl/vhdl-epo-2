library IEEE;
use IEEE.std_logic_1164.all;

entity controller_tb is
end entity;

architecture structural of controller_tb is
	component inputbuffer is
		port (	clk		: in	std_logic;
			sensor_l_in	: in 	std_logic;
			sensor_m_in	: in 	std_logic;
			sensor_r_in	: in 	std_logic;

			sensor_l_out	: out	std_logic;
			sensor_m_out	: out	std_logic;
			sensor_r_out	: out	std_logic
		);
	end component;

	component motorcontrol is
		port (	clk		: in 	std_logic;
			reset		: in 	std_logic;
			direction	: in	std_logic;
			count_in	: in 	std_logic_vector(19 downto 0);
			
			pwm		: out	std_logic
		);
	end component;

begin

end architecture structural;