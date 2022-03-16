library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity flop_tb is
end entity flop_tb;

architecture structural of flop_tb is
	component flop is
		port (	
			clk		: in	std_logic;
			d		: in 	std_logic_vector(2 downto 0);
			q		: out	std_logic_vector(2 downto 0)
		);
	end component flop;

	signal clk 		: std_logic;
	signal d, q		: std_logic_vector(2 downto 0);

begin

	lblo: flop port map (	clk		=> clk,
				d		=> d,
				q		=> q
			);
				

	clk			<=	'0' after 0 ns,
					'1' after 10 ns when clk /= '1' else '0' after 10 ns;

	d			<=	"000" after 10ns,
					"001" after 40ns,
					"010" after 80ns,
					"011" after 120ns,
					"100" after 160ns,
					"101" after 200ns,
					"110" after 240ns,
					"111" after 280ns;
			
end architecture structural;