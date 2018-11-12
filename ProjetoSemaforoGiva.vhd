library IEEE;
use IEEE.std_logic_1164.all; -- Biblioteca Padrão

entity ProjetoSemaforoGiva is port -- Declaração do início da Entidade
(
	clk, rst : IN std_logic; -- As entradas são o clock e o reset
	sem1, sem2 : OUT std_logic_vector (2 downto 0) -- As saídas são os semáforos que são vetores lógicos de 3 posições para representar as cores
);

end ProjetoSemaforoGiva; -- Fim da Entidade

architecture logica of ProjetoSemaforoGiva is
		type estados is (start, est1, est2, est3, est4); -- Declara um tipo "estados" que pode assumir 5 valores (classe)
		signal atual:estados; -- declara "atual" que tem tipo estados (objeto)
		signal s1,s2:std_logic_vector (1 downto 0); -- vetores de estados
	begin  -- inicia a logica (arquitetura declarada)
		process(clk, rst)
		begin 
			if rst = '1' then
				atual	<= start;
			elsif clk'event and clk='1' then
				case atual is
															-- Transição entre os estados dos 2 semáforos do cruzamento
					when start =>
						atual <= est1;
					when est1 =>
						atual <= est2;
					when est2 =>
						atual <= est3;
					when est3 =>
						atual <= est4;
					when est4 => 
						atual <= est1;
				end case;
			end if;
		end process;
		
	-- Processo de saída

	saida:Process(atual)
	begin 
		case atual is 
										--As cores dos sinais foram declaradas como: "00" = vermelho, "01" = amarelo, "10" = verde
			when start =>
			
			when est1 =>
				s1 <= "00"; 
				s2 <= "10";
			when est2 =>
				s1 <= "00";
				s2 <= "01";
			when est3 =>
				s1 <= "10";
				s2 <= "00";
			when est4 =>
				s1 <= "01";
				s2 <= "00";
				
		end case;
	end Process saida;
	
	semaforo1:Process(s1)
	begin
		case s1 is
			
			when "00" =>
				sem1 <= "100";
			when "01" =>
				sem1 <= "010";
			when "10" =>
				sem1 <= "001";
			when "11" =>
				
		end case;
	end process semaforo1;
	
	semaforo2:Process(s2)
	begin
		case s2 is
			
			when "00" =>
				sem2 <= "100";
			when "01" =>
				sem2 <= "010";
			when "10" =>
				sem2 <= "001";
			when "11" =>
			
		end case;
	end process semaforo2;
	
	
	end logica;
	

