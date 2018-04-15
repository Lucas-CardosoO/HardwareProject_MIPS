module shiftLeft2bits26(input logic[25:0] entrada, input logic[31:0]entradaPC, output logic [31:0] saida);

always_comb begin
	saida[27:0] = entrada << 2;
	saida[31:28] = entradaPC[31:28];
	//saida[1:0] = 2'b00;
end

endmodule: shiftLeft2bits26