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
		IF (S2='0' AND S1='0' AND SO='0')THEN --ִ�мӷ�����
			NULL;
		ELSIF (S2='0' AND S1='0' AND S0='1') THEN --CMP
			AA <= '0'&X;
			BB <= '0'&Y;
			TEMP <= AA-BB;
			--BCDOUT <= TEMP(7 DOWNTO 0);
			SF <= TEMP(7);
			CF <= TEMP(8);
			
			--���������ͬ�ţ������;
			--����Ϊ��ţ���������������ͬ���������
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
			
			--�����ø���������������������
			IF(AA(7) ='1') THEN --����+1�����
				OVF <= '0';
			ELSE
				IF(TEMP(7) = '1') THEN --����+���� ��� Ϊ �� ���
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
			
			IF(AA(7)='0') THEN --���������ͬ�ţ������
				OVF <= '0';
			ELSE --����Ϊ��ţ���������������ͬ���������
				IF(TEMP(7) = '0') THEN 
					OVF <= '1';
				ELSE
					OVF <= '0';
				END IF;
			END IF;
		ELSIF(S2='1' AND S1='1' AND S0='1') THEN --Y ֱ�����Rd
			BCDOUT <= Y;
		
		END IF;	
	END PROCESS;
END A;
