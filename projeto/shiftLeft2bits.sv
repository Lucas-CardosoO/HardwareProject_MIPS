module shiftLeft2bits(input logic[31:0] entrada, output logic [31:0] saida, input[4:0] contrl);

always_comb begin
	case(contrl)
		5'b10000: begin
			saida = entrada << 16;
		end 
	
		default: begin
			saida = entrada << 2;
		end
	endcase
end

endmodule: shiftLeft2bits