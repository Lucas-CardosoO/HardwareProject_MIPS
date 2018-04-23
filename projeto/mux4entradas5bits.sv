module mux4entradas5bits (input logic [1:0] controlador, input logic [4:0] entrada0, entrada1, entrada2, entrada3, output logic [4:0] saidaMux );
always_comb begin
		case(controlador)
		2'b00:begin
			saidaMux <= entrada0;
		end
		2'b01:begin
			saidaMux <= entrada1;
		end
		2'b10:begin
			saidaMux <= entrada2;
		end
		2'b11:begin
			saidaMux <= entrada3;
		end 

		endcase
end
endmodule: mux4entradas5bits
