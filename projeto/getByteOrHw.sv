module getByteOrHw(input logic [1:0] WordouHWouByte, input logic [31:0] MDR, output logic [31:0] flavio);


always_comb begin
	if (WordouHWouByte == 2'b00) begin
		flavio = MDR;
	end
	else if (WordouHWouByte == 2'b01) begin
		flavio =  {16'b0 , MDR[31:16]};
	end
	else if (WordouHWouByte == 2'b10)begin
		flavio =  {24'b0 , MDR[31:24]};
	end
	else begin
		flavio = MDR;
	end
end

endmodule: getByteOrHw