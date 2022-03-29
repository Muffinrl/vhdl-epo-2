library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity motorcontrol is
	port (	clk		: in 	std_logic;
		reset		: in 	std_logic;
		direction	: in	std_logic;
		count_in	: in 	std_logic_vector(19 downto 0);
		
		pwm		: out	std_logic
	);

end entity motorcontrol;

architecture behavioural of motorcontrol is

	type	motorcontrol_state is (		motor_off,
						pulse_high,
						pulse_low);

	signal	state, new_state:	motorcontrol_state;


begin
	
	process (clk)
	begin
		if(rising_edge (clk)) then
			if (reset = '1') then
				state 	<= motor_off;
			else
				state	<= new_state;
			end if;
		end if;
	end process;

	-- TODO: Verify
	process (state, direction, count_in)
	begin
		case state is
			when motor_off 	=>
				pwm		<= '0';
				new_state <= pulse_high;
			
			when pulse_high	=>
				pwm 		<= '1';

				if(direction = '1') then
					-- 2 ms pulse if direction is high.
					if ( unsigned(count_in) > to_unsigned(100000, 20)) then
						new_state <= pulse_low;
					else
						new_state <= pulse_high;
					end if;
				else
					-- 1 ms pulse if direction is low.
					if ( unsigned(count_in) > to_unsigned(50000, 20)) then
						new_state <= pulse_low;
					else
						new_state <= pulse_high;
					end if;
				end if;

			when pulse_low 	=>
				pwm		<= '0';
		end case;			
	end process;

end architecture behavioural;

			
				