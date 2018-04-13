module extensor16to32bits(input logic [15:0]entrada, output logic [31:0] saida);

always_comb begin
	if (entrada[15] == 0) begin 
		saida = {16'b0, entrada};
	end
	else begin
		saida = {16'b1, entrada};
	end
end
endmodule: extensor16to32bits