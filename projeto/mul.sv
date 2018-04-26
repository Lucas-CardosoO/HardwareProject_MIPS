module mul(input logic Clock, load, input logic [31:0] multiplicador, multiplicando, output [63:0] resultado);

logic [4:0] counter;
logic [31:0] multiplicando_atual, multipicador_atual;
logic [63:0] resultado_atual;

always_ff@(posedge Clock) begin
	if (counter == 4'b1111) begin
			resultado <= resultado_atual;
	end
	else begin
		counter = counter+1;
		//operacoes de multiplicacao
	end
end

endmodule: mul