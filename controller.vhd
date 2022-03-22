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

--architecture struct of controller is
