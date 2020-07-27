----------------------------------------------------------------------------------
-- Company: UNIVERSITY OF REGINA
-- Engineer: ALIGWEKWE CHIAMAKA
-- 
-- Create Date: 11/29/2019 02:21:45 PM
-- Design Name: CLOCK DESIGN
-- Module Name: clockdesign - Behavioral
-- Project Name: ENEL384
-- Target Devices: XC7A100T_0
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
    Port ( CLK : in STD_LOGIC;
           switch_led: out STD_LOGIC_VECTOR (1 downto 0); 
           switch : in STD_LOGIC_VECTOR ( 1 downto 0);
           cathode : out STD_LOGIC_VECTOR (7 downto 0);
           anode : out STD_LOGIC_VECTOR (7 downto 0));
end clockdesign;

architecture Behavioral of clockdesign is
signal disp_0: integer range 0 to 9:= 0;
signal disp_1 : integer range 0 to 9 := 0;
signal disp_2: integer range 0 to 9 := 0;
signal disp_3 : integer range 0 to 5 := 0;
signal disp_4: integer range 0 to 9 := 0;
signal disp_5 : integer range 0 to 5 := 0;
signal disp_6: integer range 0 to 9 := 0;
signal disp_7: integer range 0 to 2 := 0;
signal count_a, count_b, count_c, count_d, count_e, count_f, count_g, count_h  : integer := 0;
signal count_2: integer range 0 to 50000 :=0;
signal count_1: integer range 0 to 799999 :=0;
signal value_display: STD_LOGIC_VECTOR (2 downto 0);
signal digit : integer range 0 to 9 :=0;
signal value : STD_LOGIC_VECTOR( 7 downto 0) := (others => '1');



begin process(CLK,disp_0, disp_1, disp_2, disp_3, disp_4, disp_5, disp_6, disp_7)
begin
if ( CLK'event and CLK ='1') then
        switch_led <= switch; 
		  count_2 <= count_2 + 1;
		  count_1 <= count_1 + 1;	   
	    if (count_2 = 50000) then
         value_display <= value_display+1;
            end if;
           if (switch(0) = '1' AND switch(1) = '0' ) then 
         if (count_1 = 799999) then
            disp_0 <= disp_0 + 1;
            end if;           
           if ( disp_0 = 9) then
            disp_1 <= disp_1 + 1;
             disp_0 <= 0;
            if ((disp_1 = 9) AND ( disp_0 = 9)) then
             disp_2 <= disp_2 + 1;
                disp_1 <= 0;
            if ((disp_2 = 9) AND (disp_1 = 9) AND (disp_0 = 9)) then
                 disp_3 <= disp_3 + 1;
                  disp_2 <= 0;
             if ((disp_3 = 5) AND ( disp_2 = 9 ))then
                disp_4 <= disp_4 + 1;
                disp_3 <= 0;
                if (disp_4 = 9) then
                  disp_5 <= disp_5 + 1;
                     disp_4 <= 0;
                if ((disp_5 = 5) AND ( disp_4 = 9)) then
                     disp_6 <= disp_6 + 1;
                             disp_5 <= 0;
                    if (disp_6 = 9) then
                       disp_7 <= disp_7 + 1;
                          disp_6 <= 0;
                if ((disp_7 = 2) AND ( disp_6 = 4)) then
                      disp_7 <= 0;
                 
                end if;
               end if;
              end if;
             end if;
            end if;
           end if;
          end if;
           
   elsif (switch(0) = '0' AND switch(1) = '0' ) then
        disp_0 <=  disp_0;
        disp_1 <= disp_1;
        disp_2 <= disp_2;
        disp_3 <= disp_3;
        disp_4 <= disp_4;
        disp_5 <= disp_5;
        disp_6 <= disp_6;
        disp_7 <= disp_7;
        end if;
   elsif (switch(0) = '0' AND switch(1) = '1' ) then
        disp_0 <= 0;
        disp_1 <= 0;
        disp_2 <= 0;
        disp_3 <= 0;
        disp_4 <= 0;
        disp_5 <= 0;
        disp_6 <= 0;
        disp_7 <= 0;
    end if;
end if;   
end process;

process(value_display, disp_0, disp_1, disp_2, disp_3, disp_4, disp_5, disp_6, disp_7)
begin
    
    case value_display is
        when "000" => digit <= disp_0;
        when "001" => digit <= disp_1;
        when "010" => digit <= disp_2;
        when "011" => digit <= disp_3;
 	    when "100" => digit <= disp_4;
        when "101" => digit <= disp_5;
        when "110" => digit <= disp_6;
        when "111" => digit <= disp_7;
        when others => digit <= 0;
     end case;

 end process;
 
process(value_display)
begin
 
     case value_display is
        when "000" => anode <= "11111110";
        when "001" => anode <= "11111101";
        when "010" => anode <= "11111011";
        when "011" => anode <= "11110111";
        when "100" => anode <= "11101111";
        when "101" => anode <= "11011111";
        when "110" => anode <= "10111111";
        when "111" => anode <= "01111111";
         when others => anode <= "11111111";  
     end case;


 end process;
 
process(value)
begin 
     case digit is
        when 0 => value <= "11000000";
        when 1 => value <= "11111001";
        when 2 => value <= "10100100";
        when 3 => value <= "10110000";
        when 4 => value <= "10011001";
        when 5 => value <= "10010010";
        when 6 => value <= "10000010";
        when 7 => value <= "11111000";
        when 8 => value <= "10000000";
        when 9 => value <= "10011000";
         when others => value <= "11111111";
     end case;

end process;
cathode <= value; 
end Behavioral;
