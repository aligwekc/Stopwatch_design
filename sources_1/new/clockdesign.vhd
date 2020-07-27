----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Aligwekwe Chiamaka
-- 
-- Create Date: 11/28/2019 02:13:58 PM
-- Design Name: 
-- Module Name: clockdesign - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clockdesign is
 Port (    push_button : in STD_LOGIC_VECTOR (1 downto 0);
           CLK : in STD_LOGIC;
           anode : out STD_LOGIC_VECTOR (7 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0) );
end clockdesign;

architecture Behavioral of clockdesign is
--signal declaration
signal enable : std_logic:= '0';
signal start_button, sig1_button : integer:= 0;
signal count_a, count_b, count_c, count_d, count_e, count_f, count_g, count_h, disp_0, disp_1, disp_2, disp_3, disp_4, disp_5, disp_6, disp_7 : integer := 0;
signal count_1: integer :=0;
signal count_2: integer :=0;
signal temp_1: STD_LOGIC :='0';
signal temp_2: STD_LOGIC :='0';
signal disp_refresh, timer : STD_LOGIC;
signal disp : STD_LOGIC_VECTOR ( 1 downto 0) := (others => '0'); --keeps track of 7 segment displays


begin process(CLK) 
begin
if ( CLK'event and CLK ='1') then
  count_1 <= count_1 + 1;
        count_2 <= count_2 + 1;   
        --1 MHz / 250 Hz = 400,000
        --50% duty cycle = 400,000 / 2 = 200,000
       if (count_1 = 200000) then
           temp_1 <= NOT temp_1;
            count_1 <= 0;
        end if;
        --1 MHz / 100 Hz = 1,000,000
        --50% duty cycle = 1,000,000 / 2 = 500,000
        if (count_2 = 50000) then
           temp_2 <= NOT temp_2;
           count_2 <= 0;
           end if;
           end if;

end process;               
disp_refresh <= temp_1; --240 Hz 
timer <= temp_2;   

process (disp_refresh, timer, push_button, enable) is
begin
    --reset
    if (push_button(1) = '1' and enable = '0') then
        --display    
      
    
        count_a <= 0;
        count_b <= 0;
        count_c <= 0;
        count_d <= 0;
      
    end if;
    
    --rising edge
    if (timer='1' and timer'event) then
        if (enable = '1') then
            disp_0 <= count_a;
            disp_1 <= count_b;
            disp_2 <= count_c;
            disp_3 <= count_d;
       
            --if count reaches 9, add 1 to the next display
            count_a <= count_a + 1;
            if (count_a = 9) then
                count_a <= 0;
                count_b <= count_b + 1;
                if (count_b = 9) then
                    count_b <= 0;
                    count_c <= count_c + 1;
                        if (count_c = 9) then
                            count_c <= 0;
                           count_d <=count_d + 1;
                                if (count_d = 9) then
                                   count_d <= 0;
                            
                        end if;
                end if;
            end if;
        end if;
    end if;
 end if;  
end process;


process (disp_refresh)
begin
    if (disp_refresh='1' and disp_refresh'event) then
        case disp is
            when "00" =>
                case (disp_0) is
                    when 0 =>
                        anode <= "11111110";
                        cathode <= "11000000";
                    when 1 =>
                        anode <= "11111110";
                        cathode <= "11111001";
                    when 2 =>
                        anode <= "11111110";
                        cathode <= "10100100";
                    when 3 =>
                        anode <= "11111110";
                        cathode <= "10110000";
                    when 4 =>
                        anode <= "11111110";
                        cathode <= "10011001";
                    when 5 =>
                        anode <= "11111110";
                        cathode <= "10010010";
                    when 6 =>
                        anode <= "11111110";
                        cathode <= "10000010";
                    when 7 =>
                        anode <= "11111110";
                        cathode <= "11111000";
                    when 8 =>
                        anode <= "11111110";
                        cathode <= "10000000";
                    when 9 =>
                        anode <= "11111110";
                        cathode <= "10010000";
                    when others =>
                        anode <= "11111110";
                        cathode <= "11111111";
                end case;
                
            when "01" =>
                case (disp_1) is
                    when 0 =>
                        anode <= "11111101";
                        cathode <= "11000000";
                    when 1 =>
                        anode <= "11111101";
                        cathode <= "11111001";
                    when 2 =>
                        anode <= "11111101";
                        cathode <= "10100100";
                    when 3 =>
                        anode <= "11111101";
                        cathode <= "10110000";
                    when 4 =>
                        anode <= "11111101";
                        cathode <= "10011001";
                    when 5 =>
                        anode <= "11111101";
                        cathode <= "10010010";
                    when 6 =>
                        anode <= "11111101";
                        cathode <= "10000010";
                    when 7 =>
                        anode <= "11111101";
                        cathode <= "11111000";
                    when 8 =>
                        anode <= "11111101";
                        cathode <= "10000000";
                    when 9 =>
                        anode <= "11111101";
                        cathode <= "10010000";
                    when others =>
                        anode <= "11111101";
                        cathode <= "11111111";
                end case;
                
            when "10" =>
                case (disp_2) is
                    when 0 =>
                        anode <= "11111011";
                        cathode <= "01000000";
                    when 1 =>
                        anode <= "11111011";
                        cathode <= "01111001";
                    when 2 =>
                        anode <= "11111011";
                        cathode <= "00100100";
                    when 3 =>
                        anode <= "11111011";
                        cathode <= "00110000";
                    when 4 =>
                        anode <= "11111011";
                        cathode <= "00011001";
                    when 5 =>
                        anode <= "11111011";
                        cathode <= "00010010";
                    when 6 =>
                        anode <= "11111011";
                        cathode <= "00000010";
                    when 7 =>
                        anode <= "11111011";
                        cathode <= "01111000";
                    when 8 =>
                        anode <= "11111011";
                        cathode <= "00000000";
                    when 9 =>
                        anode <= "11111011";
                        cathode <= "00010000";
                    when others =>
                        anode <= "11111011";
                        cathode <= "01111111";
                end case;
                
            when "11" =>
                case (disp_3) is
                    when 0 =>
                        anode <= "11110111";
                        cathode <= "11000000";
                    when 1 =>
                        anode <= "11110111";
                        cathode <= "11111001";
                    when 2 =>
                        anode <= "11110111";
                        cathode <= "10100100";
                    when 3 =>
                        anode <= "11110111";
                        cathode <= "10110000";
                    when 4 =>
                        anode <= "11110111";
                        cathode <= "10011001";
                    when 5 =>
                        anode <= "11110111";
                        cathode <= "10010010";
                    when 6 =>
                        anode <= "11110111";
                        cathode <= "10000010";
                    when 7 =>
                        anode <= "11110111";
                        cathode <= "11111000";
                    when 8 =>
                        anode <= "11110111";
                        cathode <= "10000000";
                    when 9 =>
                        anode <= "11110111";
                        cathode <= "10010000";
                    when others =>
                        anode <= "11110111";
                        cathode <= "11111111";
                end case;
               
        end case;     
      
    end if;
end process;
process(count_a)
begin

    --start/stop 
    --at every rising edge, check the status of the push button
   if (timer='1' and timer'event) then
        if (push_button(0) = '1') then
            start_button <= 1;
        elsif (push_button(0) = '0') then
            start_button <= 0;
        end if;
        sig1_button <= start_button;
        if (sig1_button = 0 and start_button = 1) then
            enable <= not enable;
        end if;
    end if;
end process;

end Behavioral;



