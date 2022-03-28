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

		-- Timebase
		count_in	: in	std_logic_vector(19 downto 0);
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
	signal sensor_input		: std_logic_vector(2 downto 0);
begin
	
	sensor_input(0) <= sensor_left;
	sensor_input(1) <= sensor_middle;
	sensor_input(2) <= sensor_right;

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
	
	process (state, sensor_left, sensor_middle, sensor_right, count_in, reset)
	begin
		case state is
			when forward 	=>
				dir_left	<= '1';
				dir_right	<= '0';
				rst_right	<= '0';
				rst_left	<= '0';
				rst_tb		<= '0';

				if ( unsigned(count_in) > to_unsigned(1000000, 20)) then
					new_state <= stop;
				else
					new_state <= forward;
				end if;

			when slight_left =>
				dir_left	<= '0';
				dir_right	<= '0';
				rst_right	<= '0';
				rst_left	<= '1';
				rst_tb		<= '0';

				if ( unsigned(count_in) > to_unsigned(1000000, 20)) then
					new_state <= stop;
				else
					new_state <= slight_left;
				end if;

			when sharp_left =>
				dir_left	<= '0';
				dir_right	<= '0';
				rst_right	<= '0';
				rst_left	<= '0';
				rst_tb		<= '0';

				if ( unsigned(count_in) > to_unsigned(1000000, 20)) then
					new_state <= stop;
				else
					new_state <= sharp_left;
				end if;
			
			when slight_right =>
				dir_left	<= '1';
				dir_right	<= '0';
				rst_right	<= '1';
				rst_left	<= '0';
				rst_tb		<= '0';

				if ( unsigned(count_in) > to_unsigned(1000000, 20)) then
					new_state <= stop;
				else
					new_state <= slight_right;
				end if;

			when sharp_right =>	
				dir_left	<= '1';
				dir_right	<= '1';
				rst_right	<= '0';
				rst_left	<= '0';
				rst_tb 		<= '0';

				if ( unsigned(count_in) > to_unsigned(1000000, 20)) then
					new_state <= stop;
				else
					new_state <= sharp_right;
				end if;
			when stop 	=>
				dir_left	<= '0';
				dir_right	<= '0';
				rst_right	<= '1';
				rst_left	<= '1';
				rst_tb		<= '1';
	
				if (sensor_input = "001") then
					new_state <= slight_left;
				elsif (sensor_input = "011") then
					new_state <= sharp_left;
				elsif (sensor_input = "100") then
					new_state <= slight_right;
				elsif (sensor_input = "110") then
					new_state <= sharp_right;
				else
					new_state <= forward;
				end if;
		end case;
	end process;
end architecture;