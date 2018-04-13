module controlador(input logic Clock, Reset, input logic[5:0]OpCode, InstrArit,
output logic PCEsc, CtrMem, IREsc, RegWrite, RegDst, ULAFonteA, MemParaReg,
output logic[1:0] ULAFonteB,
output logic[1:0] ULAOp,//Mudou de 3 pra 2 bits
output[3:0] state,
output logic IouD);

enum logic [3:0] {BuscaMem = 4'b0000,
  Espera1 = 4'b0001,
  AtuPC = 4'b0010,
  EscreverRegI = 4'b0011, 
  Decode = 4'b0100, 
  ExecArit = 4'b0101,
  MemAcessLW = 4'b0110,
  EsperaLW1 = 4'b0111, 
  EsperaLW2 = 4'b1000,
  GuardarRegLW = 4'b1001,
  MemAcessSW = 4'b1010,
  CarregaPC = 4'b1011,
  CarregarMDR = 4'b1100
   /* continua */} nextState;

always_ff@(posedge Clock) begin
	if (!Reset) begin
		state <= nextState;
	end
	else begin
		state <= BuscaMem;
	end
end

always_comb begin
	case(state)
		BuscaMem: begin
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= Espera1;
			
		end
		Espera1: begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= AtuPC;
			
		end
		AtuPC: begin
			PCEsc = 1'b1; // *
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= CarregaPC;
		end
		
		CarregaPC: begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= EscreverRegI;
		end

		EscreverRegI: begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           // lucas e saulo, pau no vosso cu                             
			PCEsc = 1'b0;                                                                                                          
			CtrMem = 1'b0;
			IREsc = 1'b1;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= Decode;
		end
		Decode: begin
			case(OpCode)
				6'b000000: // Operacoes aritmeticas
					begin
						PCEsc = 1'b0;		                                                                                                   
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b10;
						RegDst = 1'b0;
						RegWrite = 1'b0;
						ULAFonteA = 1'b1;
						ULAFonteB = 2'b00;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						
						nextState <= ExecArit;
					end
				6'b100011: // lw
					begin 
						PCEsc = 1'b0;                                                                                                          
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0; //*
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						
						nextState <= MemAcessLW;
					end
				6'b101011: // sw
					begin
						PCEsc = 1'b0;                                                                                                          
						CtrMem = 1'b0;
						IREsc = 1'b1;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						
						nextState <= MemAcessSW;
					end
					// continua nos proximos capitulos... ou nAO
				default: begin
					PCEsc = 1'b0;                                                                                                          
					CtrMem = 1'b0;
					IREsc = 1'b1;
					ULAOp = 2'b11;
					RegWrite = 1'b0;
					RegDst = 1'b0;
					ULAFonteA = 1'b0;
					ULAFonteB = 2'b00;
					MemParaReg = 1'b0;
					IouD = 1'b0;
					
					nextState = BuscaMem;                                                                                                        
					end
			endcase
		end
		
		ExecArit: begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			RegDst = 1'b1;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState = BuscaMem;
		end
		
		MemAcessLW:begin	
			PCEsc = 1'b0;
			CtrMem = 1'b0; //*
			IREsc = 1'b0;
			ULAOp = 2'b00;  //*
			RegWrite = 1'b0;
			ULAFonteA = 1'b1; //*
			ULAFonteB = 2'b10; //*
			RegDst = 1'b0;
			MemParaReg = 1'b0;
			IouD = 1'b1; //*
			
			nextState = EsperaLW1;
		end
		
		MemAcessSW:begin	
			PCEsc = 1'b0;
			CtrMem = 1'b1;
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			RegDst = 1'b0;
			MemParaReg = 1'b0;
			IouD = 1'b1;
			
			nextState = BuscaMem;
		end
		
		EsperaLW1: begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b10;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= EsperaLW2;
			
		end
		
		EsperaLW2: begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b10;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= GuardarRegLW;
			
		end
		
		GuardarRegLW:begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= CarregarMDR;
		end
		
		CarregarMDR:begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b1;
			IouD = 1'b0;
			
			nextState <= BuscaMem;
		end
		
		default: begin
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			RegDst = 1'b0;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			
			nextState <= BuscaMem;
		end
	endcase
end


endmodule: controlador