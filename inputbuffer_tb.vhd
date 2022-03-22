library IEEE;
use IEEE.std_logic_1164.all;

entity inputbuffer_tb is
end entity inputbuffer_tb;

architecture structural of inputbuffer_tb is

	component inputbuffer is
		port (	clk		: in	std_logic;
			sensor_l_in	: in 	std_logic;
			sensor_m_in	: in 	std_logic;
			sensor_r_in	: in 	std_logic;

			sensor_l_out	: out	std_logic;
			sensor_m_out	: out	std_logic;
			sensor_r_out	: out	std_logic
		);
	end component inputbuffer;

	signal	clk 			: std_logic;
	signal 	l, m, r			: std_logic;

	signal	o			: std_logic_vector(2 downto 0);

begin
					
	lbl0: inputbuffer port map (	clk			=> clk,
					sensor_l_in		=> l,
					sensor_m_in		=> m,
					sensor_r_in		=> r,

					sensor_l_out		=> o(2),
					sensor_m_out		=> o(1),
					sensor_r_out		=> o(0)
				);


	clk			<=	'0' after 0 ns,
					'1' after 10 ns 	when clk /= '1' else '0' after 10 ns;
	l			<=	'0' after 0 ns,
					'1' after 40 ns 	when l /= '1' else '0' after 40 ns;
	m			<=	'0' after 0 ns,
					'1' after 80 ns		when m /= '1' else '0' after 80 ns;
	r			<=	'0' after 0 ns,
					'1' after 160 ns 	when r /= '1' else '0' after 160 ns;
	


end architecture structural;

