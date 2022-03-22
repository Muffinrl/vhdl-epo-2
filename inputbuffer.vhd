library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity inputbuffer is

	port (	clk		: in	std_logic;
		sensor_l_in	: in 	std_logic;
		sensor_m_in	: in 	std_logic;
		sensor_r_in	: in 	std_logic;

		sensor_l_out	: out	std_logic;
		sensor_m_out	: out	std_logic;
		sensor_r_out	: out	std_logic
	);

end entity;

architecture struct of inputbuffer is

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

	component flop is
		port (	clk	: in	std_logic;
			d	: in	std_logic_vector(2 downto 0);
			
			q	: out	std_logic_vector(2 downto 0)
		);
	end component;

	
	-- Input signals first 3-bit register
	signal ia, ib, ic	: std_logic;
	
	-- Output signals second 3-bit register
	signal oa, ob, oc	: std_logic;
	
	-- Output signal first 3-bit register
	signal f1_out: std_logic_vector(2 downto 0);

begin
	f1 : flop 		
		port map (	clk		=> clk,
				d(2)		=> ia,
				d(1)		=> ib,
				d(0)		=> ic,
				
				q 		=> f1_out
		);

	f2 : flop
		port map (	clk		=> clk,
				d		=> f1_out,

				q(2)		=> oa,
				q(1)		=> ob,
				q(0)		=> oc
		);

	buf : inputbuffer	
		port map (	clk		=> clk,
				-- Input signals of the buffer
				sensor_l_in	=> ia,
				sensor_m_in	=> ib,
				sensor_r_in	=> ic,

				-- Output signals of the buffer
				sensor_l_out	=> oa,
				sensor_m_out	=> ob,
				sensor_r_out	=> oc
		);

end architecture struct;