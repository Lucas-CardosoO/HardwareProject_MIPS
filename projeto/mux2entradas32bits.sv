module mux2entradas32bits (input logic controlador, input logic [4:0] entrada0, entrada1, output logic [4:0] saidaMux );

always_comb begin
	case(controlador)
		1'b0: begin
			saidaMux = entrada0;
		end
		1'b1: begin
			saidaMux = entrada1;
		end
	endcase
end

endmodule: mux2entradas32bits
