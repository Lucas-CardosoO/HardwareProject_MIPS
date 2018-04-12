module extensor16to32bits(input logic [15:0]entrada, output logic [31:0] saida);

always_comb begin
	saida [31:16] = 16'b0;
	saida [15:0] = entrada;
end
endmodule: extensor16to32bits