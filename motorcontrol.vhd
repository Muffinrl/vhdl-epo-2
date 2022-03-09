library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity motor_controller is
	port (	clk		: in 	std_logic;
		reset		: in 	std_logic;
		direction	: in	std_logic;
		count_in	: in 	std_logic_vector(19 downto 0);
		
		pwm		: out	std_logic
	);

end entity motor_controller;

architecture behavioural of motor_controller is

	type	motor_controller_state is (	motor_off,
						pulse_high,
						pulse_low);

	signal	state, new_state:	motor_controller_state;
	signal 	count		: 	unsigned(19 downto 0);


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

	
	process (state)
	begin
		case state is
			when motor_off 	=>
				pwm		<= '0';
				
				if( reset = '0') then
					new_state <= pulse_high;
				else
					new_state <= motor_off;
				end if;
			
			when pulse_high	=>
				pwm 		<= '1';

				if(direction = '0') then
				-- TODO: Verify
					if (count > x"0C34F") then
						new_state <= pulse_low;
					else
						new_state <= pulse_high;
					end if;
				else
					if (count > x"1869E") then
						new_state <= pulse_low;
					else
						new_state <= pulse_high;
					end if;
				end if;

			when pulse_low 	=>
				pwm		<= '0';

				--if(direction = '0') then
				-- TODO: finish code
				--else
				
				--end if;
		end case;			
	end process;
end architecture behavioural;

			
				