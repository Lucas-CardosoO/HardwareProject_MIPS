module mul(input logic Clock, load, input logic [31:0] multiplicador, multiplicando, output logic [63:0] resultado, resultado_atual, output logic [31:0] multiplicando_atual, multiplicador_atual, output logic [4:0] counter);


always_ff@(posedge Clock) begin
	
	if(load == 1'b1) begin
		counter = 5'b0;
		resultado_atual = 64'b0;
		resultado = 64'b0;
	end

	
	else begin
		if(counter == 5'b0) begin
			multiplicando_atual = multiplicando;
			multiplicador_atual = multiplicador;
		end
		
		if(multiplicador[0] == 1) begin
			resultado_atual = resultado_atual + multiplicando;
			multiplicando_atual = multiplicando_atual << 1;
			multiplicador_atual = multiplicador_atual >> 1;
		end
		else begin
			multiplicando_atual = multiplicando_atual << 1;
			multiplicador_atual = multiplicador_atual >> 1;		
		end
		
		if (counter == 5'b11111) begin
			resultado <= resultado_atual;
			counter = 5'b0;
		end
		counter = counter + 1;
	end
end

endmodule: mul