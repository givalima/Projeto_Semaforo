ENTITY semaforo IS
PORT ( 		clock_24MHz		    :IN BIT;
				r1,r2,o1,o2,g1,g2  :OUT BIT;
				teste :OUT BIT;
				enable,pisc		    :IN BIT
				
		);
END semaforo;


ARCHITECTURE teste OF semaforo IS 
SIGNAL clock_1Hz :BIT;

BEGIN 
teste <= '1';

divisor: PROCESS(clock_24MHz)

	VARIABLE k: INTEGER RANGE 0 TO 24000000;
		BEGIN
			IF (enable = '1') THEN
			IF (clock_24MHz = '1' AND clock_24MHz'EVENT) THEN
					IF k > 12000000 THEN
							clock_1Hz <= '1';
							k := k + 1;
							IF k = 24000000 THEN
							k := 0;
							END IF;
					ELSE
							k := k + 1;
							clock_1Hz <= '0';
					END IF;
			END IF;
		END IF;

		END PROCESS divisor;
		

contador: PROCESS(clock_1Hz)
VARIABLE count: INTEGER RANGE 0 to 60; 

	BEGIN
	  IF (clock_1Hz = '1' AND clock_1Hz' EVENT) THEN
	  
		
 IF (count < 60) THEN
									count := count + 1;
ELSIF (count > 59) THEN
									count := 0;
END IF;
  
		IF (count = 0 ) THEN  --0
			r1 <= '0';
			g1 <= '1';
			o1 <= '0';
			r2 <= '1';
			g2 <= '0';
			o2 <= '0';
		ELSIF (count = 24) THEN --24
			r1 <= '0';
			g1 <= '0';
			o1 <= '1';
			r2 <= '1';
			g2 <= '0';
			o2 <= '0';
		
		ELSIF (count = 29 ) THEN -- 29
			r1 <= '1';
			g1 <= '0';
			o1 <= '0';
			r2 <= '0';
			g2 <= '1';
			o2 <= '0';

		ELSIF (count = 54 ) THEN -- 54
			r1 <= '1';
			g1 <= '0';
			o1 <= '0';
			r2 <= '0';
			g2 <= '0';
			o2 <= '1';			
		END IF;
	
 END IF;


 END PROCESS contador;

 
 



END teste;
 
 