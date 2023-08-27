LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MUX5 IS
PORT(
	X0,X1,X2,X3,X4: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	A,B,C,D,E: IN STD_LOGIC;
	W: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END MUX5;

ARCHITECTURE A OF MUX5 IS
SIGNAL SEL:STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
	SEL<=A&B&C&D&E;
	PROCESS
	BEGIN
	IF(SEL="01111") THEN
		W<=X0;
	ELSIF(SEL="10111") THEN
		W<=X1;
	ELSIF(SEL="11011") THEN
		W<=X2;
	ELSIF(SEL="11101") THEN
		W<=X3;
	ELSIF(SEL="11110") THEN 
		W<=X4;
	ELSE
		NULL;
	END IF;
	END PROCESS;
END A;

