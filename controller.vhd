library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller is
	port ( 	clk		: in 	std_logic;
		reset		: in 	std_logic;

		-- Sensor Input
		sensor_left	: in	std_logic;
		sensor_middle	: in	std_logic;
		sensor_right	: in	std_logic;

		-- Motor Direction
		dir_left	: out	std_logic;
		dir_right	: out	std_logic;

		-- Reset Motors
		rst_left	: out	std_logic;
		rst_right	: out 	std_logic;

		-- Reset Timebase
		rst_tb		: out	std_logic
	);

end entity;

architecture struct of controller is
	type controller_state is (	forward,
					slight_left,
					sharp_left,
					slight_right,
					sharp_right,
					stop 		);

	signal state, new_state		: controller_state;

begin
	process (clk)
	begin
		if(rising_edge (clk)) then
			if (reset = '1') then
				state 	<= stop;
			else
				state	<= new_state;
			end if;
		end if;
	end process;


	process ( clk, state )
	begin
		case state is
			when forward 	=>
				dir_left	<= '1';
				dir_right	<= '0';
				rst_left	<= '0';
				rst_right	<= '0';

			when slight_left =>
				dir_right	<= '0';
				rst_right	<= '0';
				rst_left	<= '1';



					