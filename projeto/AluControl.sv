module AluControl(input logic[5:0] funct,
input logic[2:0] ULAOp,
output logic[2:0] ULAOpSelector);

enum logic [5:0] {addu = 6'h21, andULA = 6'h24, subu = 6'h23, xorULA = 6'h26, add = 6'h20, sub = 6'h22 /* continua */} man;

always_comb begin
	case(ULAOp)
		3'b000: begin //PC +4
			ULAOpSelector = 3'b001;
		end
		3'b010: begin //Tipo R
			case(funct)
				addu: begin
					ULAOpSelector = 3'b001;
				end
				subu: begin
					ULAOpSelector = 3'b010;
				end
				andULA: begin
					ULAOpSelector = 3'b011;
				end
				xorULA: begin
					ULAOpSelector = 3'b110;
				end
				add: begin 
					ULAOpSelector = 3'b001;
				end
				sub: begin
					ULAOpSelector = 3'b010;
				end
				default: begin
					ULAOpSelector = 3'b001;
				end
			endcase
		end
		3'b001: begin
			ULAOpSelector = 3'b010; //Subtra�l�o pra o beq
		end
		3'b100: begin // sxori
			ULAOpSelector = 3'b110;
		end
		
		3'b011: begin //andi
			ULAOpSelector = 3'b011;
		end
		
		default: begin
			ULAOpSelector = 3'b000;	
		end

	endcase
end


endmodule: AluControl