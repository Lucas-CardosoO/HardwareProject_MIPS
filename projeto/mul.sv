module mul(input logic Clock, load, input logic [31:0] multiplicador, multiplicando, output logic [63:0] resultado, resultado_atual, output logic [31:0] multiplicando_atual, multiplicador_atual, output logic [4:0] counter);

/*
assign multiplicador_atual = 31'b0;
assign multiplicando_atual = 31'b0;
assign resultado = 64'b0;
assign resultado_atual = 64'b0;
*/

always_ff@(posedge Clock) begin

	if(load == 1'b1) begin
		counter = 5'b0;
		resultado_atual = 64'b0;
		multiplicador_atual = multiplicador;
		multiplicando_atual = multiplicando;
	end
		
	if(multiplicador_atual[0] == 1) begin
		resultado_atual = resultado_atual + multiplicando_atual;
	end
	
	multiplicando_atual = multiplicando_atual << 1;
	multiplicador_atual = multiplicador_atual >> 1;	
		
	if (counter == 5'b11111) begin
		resultado <= resultado_atual;
		counter = 5'b0;
	end 
		counter = counter + 1;
end

endmodule: mul