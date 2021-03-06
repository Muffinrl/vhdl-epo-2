library IEEE;
use IEEE.std_logic_1164.all;

entity robot is
	port (  clk             : in    std_logic;
		reset           : in    std_logic;

		sensor_l_in     : in    std_logic;
		sensor_m_in     : in    std_logic;
		sensor_r_in     : in    std_logic;

		motor_l_pwm     : out   std_logic;
		motor_r_pwm     : out   std_logic
	);
end entity robot;

architecture struct of robot is

	component controller is
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
	end component;
	
	component motorcontrol is
		port (	clk		: in 	std_logic;
			reset		: in 	std_logic;
			direction	: in	std_logic;
			count_in	: in 	std_logic_vector(19 downto 0);
		
			pwm		: out	std_logic
		);
	end component;

	component timebase is
		port ( 	clk		: in std_logic;
			reset		: in std_logic;
			count_out	: out std_logic_vector(19 downto 0) 
		);
	end component;

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

	signal sensor_l_s, sensor_m_s, sensor_r_s, dir_right, dir_left, timebase_reset, motor_l_reset, motor_r_reset : std_logic;
	signal count_in	: std_logic_vector(19 downto 0);

begin

	tb: timebase 		port map (clk => clk, reset => timebase_reset, count_out => count_in);
	mcl: motorcontrol 	port map (clk => clk, reset => motor_l_reset, direction => dir_left, pwm => motor_l_pwm, count_in => count_in);
	mcr: motorcontrol	port map (clk => clk, reset => motor_r_reset, direction => dir_right, pwm => motor_r_pwm, count_in => count_in);
	inb: inputbuffer	port map (clk => clk, sensor_l_in => sensor_l_in, sensor_m_in => sensor_m_in, sensor_r_in => sensor_r_in, sensor_l_out => sensor_l_s, sensor_m_out => sensor_m_s, sensor_r_out => sensor_r_s);
	ct: controller		port map (clk => clk, reset => reset, sensor_left => sensor_l_s, sensor_middle => sensor_m_s, sensor_right => sensor_r_s, count_in => count_in, rst_tb => timebase_reset, dir_left => dir_left, dir_right => dir_right, rst_left => motor_l_reset, rst_right => motor_r_reset);

end architecture struct;
