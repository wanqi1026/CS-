LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY F1 IS
PORT(
     UA5,UA4,UA3,UA2,UA1,UA0:IN STD_LOGIC;
     D:OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
    );
END F1;

ARCHITECTURE A OF F1 IS
BEGIN
   D(5)<=UA5;
   D(4)<=UA4;
   D(3)<=UA3;
   D(2)<=UA2;
   D(1)<=UA1;
   D(0)<=UA0;
END A;

