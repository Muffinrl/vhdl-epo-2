library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity flop is
	port (	clk		: in	std_logic;
		d		: in 	std_logic_vector(2 downto 0);

		q		: out	std_logic_vector(2 downto 0)
);
end entity;

architecture struct of flop is
begin
	process(clk)
	begin
		if rising_edge(clk) then
			q <= d;
		end if;
	end process;
end architecture struct;