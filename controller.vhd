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
	signal count_in			: std_logic_vector(19 downto 0);
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

	process (clk)
	begin
		case sensor_input is
			when "000"	=>
				new_state <= forward;
			when "001"	=>
				new_state <= slight_left;
			when "010"	=>
				new_state <= forward;
			when "011"	=>
				new_state <= sharp_left;
			when "100"	=>
				new_state <= slight_right;
			when "101"	=>	
				new_state <= forward;
			when "110"	=>
				new_state <= sharp_right;
			when "111"	=>
				new_state <= forward;
			when others	=>
				new_state <= stop;
		end case;
	end process;
	
	process (state)
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

			when sharp_left =>
				dir_right	<= '0';
				dir_left	<= '0';
				rst_right	<= '0';
				rst_left	<= '0';
			
			when slight_right =>
				dir_left	<= '1';
				rst_right	<= '1';
				rst_left	<= '0';

			when sharp_right =>	
				dir_left	<= '1';
				dir_right	<= '1';
				rst_right	<= '0';
				rst_left	<= '0';
			when stop 	=>
				rst_right	<= '1';
				rst_left	<= '1';
		end case;
	end process;
end architecture;