module mux8entradas32bits (input logic [2:0] controlador, input logic [31:0] entrada0, entrada1, entrada2, entrada3, entrada4, entrada5, entrada6, entrada7, output logic [31:0] saidaMux );
always_comb begin
		case(controlador)
		3'b00:begin
			saidaMux <= entrada0;
		end
		3'b001:begin
			saidaMux <= entrada1;
		end
		3'b010:begin
			saidaMux <= entrada2;
		end
		3'b011:begin
			saidaMux <= entrada3;
		end 
		3'b100:begin
			saidaMux <= entrada4;
		end
		3'b101:begin
			saidaMux <= entrada5;
		end
		3'b110:begin
			saidaMux <= entrada6;
		end
		3'b111:begin
			saidaMux <= entrada7;
		end 

		endcase
end
endmodule: mux8entradas32bits
