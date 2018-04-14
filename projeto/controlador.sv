module controlador(input logic Clock, Reset, input logic[5:0]OpCode, InstrArit,
output logic PCEsc, CtrMem, IREsc, RegWrite, RegDst, ULAFonteA, MemParaReg,
output logic[1:0] ULAFonteB, FontePC,
output logic[1:0] RegACtrl,
output logic[1:0] RegBCtrl, ULASaidaCtrl, MDRCtrl,
output logic[1:0] ULAOp,//Mudou de 3 pra 2 bits
output[5:0] state,
output logic IouD);


enum logic [5:0] {BuscaMem = 6'd0,
  EsperaBusca1ELoadPc = 6'd1,
  EsperaBusca2 = 6'd2,
  EscreverRegI = 6'd3,
  Decode = 6'd4, 
  LWRegABLoad = 6'd5, 
  LWCalcOffset = 6'd6,
  LWReadMem = 6'd7,
  LWEspera1= 6'd8, 
  LWEspera2 = 6'd9,
  LWMDRLoad = 6'd10,
  LWFinish = 6'd11,
  SWRegABLoad = 6'd12,
  SWCalcOffset = 6'd13,
  SWEscritaMem = 6'd14,
  RRegABLoad = 6'd15,
  RULAOp = 6'd16,
  RRegLoad = 6'd17
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
		BuscaMem : begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 1'b0;
			IouD = 1'b0; ;; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
	
			nextState <= EsperaBusca1ELoadPc;
			
		end
		EsperaBusca1ELoadPc: begin
			FontePC = 2'b01;
			PCEsc = 1'b1;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= EsperaBusca2;
			
		end
		EsperaBusca2 : begin
			FontePC = 2'b01;
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
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= EscreverRegI ;
		end
		
		EscreverRegI : begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b1;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= Decode ;
		end
		
		Decode: begin
			case(OpCode)
				6'b000000: // Operacoes aritmeticas
					begin
						FontePC = 2'b01;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b11;
						RegWrite = 1'b0;
						RegDst = 1'b1;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						
						nextState <= RRegABLoad;
					end
				6'b100011: // lw
					begin 
						FontePC = 2'b01;
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
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						
						nextState <= LWRegABLoad ;
					end
				6'b101011: // sw
					begin
						FontePC = 2'b01;
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
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						
						nextState <= SWRegABLoad;
					end
					// continua nos proximos capitulos... ou nAO
				default: begin
					FontePC = 2'b01;
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
					RegACtrl = 1'b0;
					RegBCtrl = 1'b0;
					ULASaidaCtrl = 1'b0;
					MDRCtrl = 1'b0;	
					
					nextState = BuscaMem;                                                                                                        
					end
			endcase
		end
		
		LWRegABLoad :begin	
			FontePC = 2'b01;
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
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState = LWCalcOffset ;
		end
		
		
		LWCalcOffset :begin	
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			
			nextState = LWReadMem ;
		end
		
		LWReadMem : begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= LWEspera1 ;
			
		end
		
		LWEspera1 : begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= LWEspera2;
			
		end
		
		LWEspera2 : begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= LWMDRLoad ;
			
		end
		
		LWMDRLoad :begin
			FontePC = 2'b01;
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
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b1;
			
			
			nextState <= LWFinish ;
		end
		
		LWFinish :begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b1;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= BuscaMem;
		end
				
		SWRegABLoad :begin	
			FontePC = 2'b01;
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
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState = SWCalcOffset ;
		end
		
		SWCalcOffset :begin	
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			
			nextState = SWEscritaMem ;
		end
		
		SWEscritaMem :begin	
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b1;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 1'b0;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			
			nextState = BuscaMem ;
		end
		
		
		RRegABLoad: begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b1;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			nextState = RULAOp;
		end
		
		RULAOp: begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			nextState = RRegLoad;
		end
		
		RRegLoad: begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			nextState = BuscaMem;
		end
		
		default: begin
			FontePC = 2'b01;
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
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			
			nextState <= BuscaMem;
		end
	endcase
end


endmodule: controlador