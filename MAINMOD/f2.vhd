LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY F2 IS
PORT(
	D:IN STD_LOGIC_VECTOR(5 DOWNTO 0);
     UA5,UA4,UA3,UA2,UA1,UA0:OUT STD_LOGIC
    );
END F2;

ARCHITECTURE A OF F2 IS
BEGIN
   UA5<=D(5);
   UA4<=D(4);
   UA3<=D(3);
   UA2<=D(2);
   UA1<=D(1);
   UA0<=D(0);
END A;

