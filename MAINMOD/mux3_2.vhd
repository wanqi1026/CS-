LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MUX3_2 IS
PORT(
	ALUOUT,RSOUT,AOUT: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	ALU_B,RS_B,ADDR_B: IN STD_LOGIC;
	DBUS: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END MUX3_2;

ARCHITECTURE A OF MUX3_2 IS
BEGIN
	PROCESS
	BEGIN
		IF(ALU_B='0') THEN
			DBUS<=ALUOUT;
		ELSE
			IF(RS_B='0') THEN
				DBUS<=RSOUT;
			ELSIF(RS_B='1' AND ADDR_B='0') THEN
				DBUS<=AOUT;
			ELSIF(RS_B='1' AND ADDR_B='1') THEN
				DBUS<="00000000";
			END IF;
		END IF;
	END PROCESS;
END A;

