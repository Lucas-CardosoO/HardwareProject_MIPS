module mux2entradas32bits_real (input logic controlador, input logic [31:0] entrada0, entrada1, output logic [31:0] saidaMux );

always @(controlador) begin
		if(controlador) begin
			saidaMux = entrada1;
		end
		else begin
			saidaMux = entrada0;
		end	
	end
endmodule: mux2entradas32bits_real
