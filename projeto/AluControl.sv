module AluControl(input logic[5:0] funct,
input logic[1:0] ULAOp,
output logic[2:0] ULAOpSelector);

enum logic [5:0] {add = 6'b100000, andULA = 6'b100100, sub = 6'b100010/* continua */} man;

always_comb begin
	case(ULAOp)
		2'b00: begin //PC +4
			ULAOpSelector = 3'b001;
		end
		2'b10: begin //Tipo R
			case(funct)
				add: begin
					ULAOpSelector = 3'b001;
				end
				sub: begin
					ULAOpSelector = 3'b010;
				end
				andULA: begin
					ULAOpSelector = 3'b011;
				end
				default: begin
					ULAOpSelector = 3'b001;
				end
			endcase
		end
		default: begin
			ULAOpSelector = 3'b000;	
		end

	endcase
end


endmodule: AluControl