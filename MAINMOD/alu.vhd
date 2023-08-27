LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY ALU IS
PORT(
	X: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	Y: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	S2,S1,S0: IN STD_LOGIC;
	BCDOUT:	OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	CF,ZF,SF,OVF: OUT STD_LOGIC
	);
END ALU;

ARCHITECTURE A OF ALU IS
SIGNAL AA,BB,TEMP: STD_LOGIC_VECTOR(8 DOWNTO 0); 
SIGNAL TEMP1: STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN 
	PROCESS
	BEGIN
		TEMP <="000000000";
		IF (S2='0' AND S1='0' AND SO='0')THEN --执行加法操作
			NULL;
		ELSIF (S2='0' AND S1='0' AND S0='1') THEN --CMP
			AA <= '0'&X;
			BB <= '0'&Y;
			TEMP <= AA-BB;
			--BCDOUT <= TEMP(7 DOWNTO 0);
			SF <= TEMP(7);
			CF <= TEMP(8);
			
			--两数相减，同号，则不溢出;
			--两数为异号，结果与减数符号相同，则溢出。
			IF (AA(7) = BB(7)) THEN
				OVF <= '0';
			ELSE
				IF(TEMP(7) = BB(7)) THEN 
					OVF <= '1';
				ELSE 
					OVF <= '0';		
				END IF;
			END IF;
		ELSIF (S2='0' AND S1='1' AND S0='0') THEN --INC
			AA <= '0'&Y;
			TEMP <= AA+1;
			BCDOUT <= TEMP(7 DOWNTO 0);
			
			SF <= TEMP(7);
			
			IF(TEMP(7 DOWNTO 0)="00000000") THEN 
				ZF <='1';
			ELSE 
				ZF <='0';
			END IF;
			
			--正正得负则溢出，负负得正则溢出
			IF(AA(7) ='1') THEN --负数+1不溢出
				OVF <= '0';
			ELSE
				IF(TEMP(7) = '1') THEN --正数+正数 结果 为 负 溢出
					OVF <= '1';
				ELSE
					OVF <= '0';
				END IF;
			END IF;
		ELSIF (S2='0' AND S1='1' AND S0='1') THEN --DEC
			AA <= '0'&Y;
			TEMP <= AA-1;
			BCDOUT <= TEMP(7 DOWNTO 0);
			
			IF(TEMP(7 DOWNTO 0)="00000000") THEN 
				ZF <='1';
			ELSE 
				ZF <='0';
			END IF;
			
			SF <= TEMP(7);
			
			IF(AA(7)='0') THEN --两数相减，同号，则不溢出
				OVF <= '0';
			ELSE --两数为异号，结果与减数符号相同，则溢出。
				IF(TEMP(7) = '0') THEN 
					OVF <= '1';
				ELSE
					OVF <= '0';
				END IF;
			END IF;
		ELSIF(S2='1' AND S1='1' AND S0='1') THEN --Y 直接输出Rd
			BCDOUT <= Y;
		
		END IF;	
	END PROCESS;
END A;
