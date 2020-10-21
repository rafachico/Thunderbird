LIBRARY ieee;--chama as bibliotecas
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
entity Thunderbird is
GENERIC (SEG: INTEGER := 24999999);--variavel para fazer a divisao do clock em 0,5 seg
Port(
SW : IN bit_vector(9 DOWNTO 0);-- define as chaves de entrada
LEDR : BUFFER bit_vector(9 DOWNTO 7);-- define os leds de saida
LEDG : BUFFER bit_vector(2 DOWNTO 0);--define os leds de saida
CLOCK_50 : in std_logic);--define o clock de 50 MHz
end Thunderbird;

architecture rtl of Thunderbird IS
SIGNAL temp: INTEGER RANGE 0 TO SEG; --define temp indo de 0 a SEG
Begin
	abc: process(SW,CLOCK_50)-- process sensivel em SW e cloCK_50
		Begin
		IF rising_edge(CLOCK_50) THEN -- borda de subida do clock
			IF(temp /= SEG) THEN -- se temp diferente de seg
				temp <= temp + 1;-- adiciona 1 a temp
			ELSE
			temp <= 0;--senao reseta temp e segue
			IF SW(1 DOWNTO 0)= "01" THEN -- se SW ( 1 a 0 ) for 01 entao
				LEDG(2 DOWNTO 0) <= "000";-- apaga todos os leds
				LEDR(9 DOWNTO 7) <= "000";
					CASE LEDG(2 DOWNTO 0) IS-- analiza a posiçao dos leds e altera pra nova posição
						WHEN "000" => LEDG(2 DOWNTO 0) <= "100";
						WHEN "100" => LEDG(2 DOWNTO 0) <= "110";
						WHEN "110" => LEDG(2 DOWNTO 0) <= "111";
						WHEN "111" => LEDG(2 DOWNTO 0) <= "000";
						WHEN others => LEDG(2 DOWNTO 0) <= "000";
					END CASE;
			ELSIF(SW(1 DOWNTO 0)= "10") THEN
				LEDR(9 DOWNTO 7) <= "000";
				LEDG(2 DOWNTO 0) <= "000";
					CASE LEDR(9 DOWNTO 7) IS
						WHEN "000" => LEDR(9 DOWNTO 7) <= "001";
						WHEN "001" => LEDR(9 DOWNTO 7) <= "011";
						WHEN "011" => LEDR(9 DOWNTO 7) <= "111";
						WHEN "111" => LEDR(9 DOWNTO 7) <= "000";
						WHEN others => LEDR(9 DOWNTO 7) <= "000";
					END CASE;
			ELSIF(SW(1 DOWNTO 0)= "11") THEN
				LEDR(9 DOWNTO 7) <= "000";
				LEDG(2 DOWNTO 0) <= "000";
					CASE LEDR(9 DOWNTO 7) IS
						WHEN "000" => LEDR(9 DOWNTO 7) <= "001";
										  LEDG(2 DOWNTO 0) <= "100";
						WHEN "001" => LEDR(9 DOWNTO 7) <= "011";
										  LEDG(2 DOWNTO 0) <= "110";						
						WHEN "011" => LEDR(9 DOWNTO 7) <= "111";
										  LEDG(2 DOWNTO 0) <= "111";						
						WHEN "111" => LEDR(9 DOWNTO 7) <= "000";
										  LEDG(2 DOWNTO 0) <= "000";						
						WHEN others => LEDR(9 DOWNTO 7) <= "000";
										   LEDG(2 DOWNTO 0) <= "000";						
					END CASE;
			 ELSIF(SW(1 DOWNTO 0)= "00") THEN
				LEDR(9 DOWNTO 7) <= "000";
				LEDG(2 DOWNTO 0) <= "000";
			END IF;
			END IF;
			END IF;
			END process abc;
			end rtl;

