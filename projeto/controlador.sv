module controlador(input logic Clock, Reset, input logic[5:0] OpCode, InstrArit,
output logic PCEsc, CtrMem, IREsc, RegWrite, RegDst, ULAFonteA, MemParaReg,
output logic[1:0] ULAFonteB, FontePC,
output logic[1:0] RegACtrl,
output logic[1:0] RegBCtrl, ULASaidaCtrl, MDRCtrl,
output logic[1:0] ULAOp,
output[5:0] state,
output logic PCEscCond,
output logic PCEscCondBNE,
output logic IouD,
output logic resetRegA,
output logic [2:0] ShiftControl,
output logic [4:0] NumShift);


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
  RRegLoad = 6'd17,
  BreakState = 6'd18,
  BEQLoadAB = 6'd20,
  BEQSolution = 6'd21,
  BNELoadAB = 6'd22,
  BNESolution = 6'd23,
  LUISoma = 6'd24,
  LUICarregaReg = 6'd25,
  RRegLoadABJr = 6'd26,
  RLoadPCJr = 6'd27,
  BEQDesloc = 6'd28,
  BEQBegin = 6'd29,
  BNEDesloc = 6'd30,
  BNEBegin = 6'd31
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
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
	
			nextState <= EsperaBusca1ELoadPc;
			
		end
		EsperaBusca1ELoadPc: begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
			
			nextState <= EsperaBusca2;
			
		end
		EsperaBusca2 : begin
			FontePC = 2'b00;
			PCEsc = 1'b1;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
			
			nextState <= EscreverRegI ;
		end
		
		EscreverRegI : begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
			
			nextState <= Decode ;
		end
		
		Decode: begin
			case(OpCode)
				6'b000000: // Operacoes aritmeticas
					begin
						case(InstrArit)
						
							6'b001101:
								begin
									FontePC = 2'b00;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 2'b00;
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
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShift = 5'b00000;
									
									nextState <= BreakState;
								end
							6'b000000:
								begin
									FontePC = 2'b00;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 2'b00;
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
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShift = 5'b00000;
									
									nextState <= BuscaMem;
								end
								
							6'b001000:
								begin //jr
									FontePC = 2'b00;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 2'b00;
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 1'b0;
									IouD = 1'b0;
									RegACtrl = 1'b0;
									RegBCtrl = 1'b0;
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShift = 5'b00000;
									
									nextState <= RRegLoadABJr;
								end
							
							default: begin
								FontePC = 2'b00;
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
								PCEscCond = 1'b0;
								PCEscCondBNE = 1'b0;
								resetRegA = 1'b0;
								ShiftControl = 3'b000;
								NumShift = 5'b00000;
								
								nextState <= RRegABLoad;
							end
						endcase
					end
				6'b000010: //Jump
					begin
						FontePC = 2'b10;
						PCEsc = 1'b1;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b00;
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
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShift = 5'b00000;
						
						nextState <= BuscaMem ;
					end
				6'b100011: // lw
					begin 
						FontePC = 2'b00;
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
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShift = 5'b00000;
						
						nextState <= LWRegABLoad ;
					end
				6'b101011: // sw
					begin
						FontePC = 2'b00;
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
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShift = 5'b00000;
						
						nextState <= SWRegABLoad;
					end
					
				6'b000100: // beq load registrador de deslocamento
					begin
						FontePC = 2'b00;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;	
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b001;
						NumShift = 5'b00000;
						
						nextState = BEQDesloc;
					end
					
				6'b000101: // bne load registrador de deslocamento
					begin
						FontePC = 2'b00;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;	
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b001;
						NumShift = 5'b00000;
						
						nextState = BNEDesloc;
					end
					
				6'b001111: // lui
					begin
						FontePC = 2'b00;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b1;
						ULAFonteB = 2'b11;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;	
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b1;
						ShiftControl = 3'b001;
						NumShift = 5'b00000;
						
						nextState = LUISoma;                                                                                                        
					end
				default:
					begin
						FontePC = 2'b00;
						PCEsc =1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b11;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg = 1'b0;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b1;
						ShiftControl = 3'b010;
						NumShift = 5'b10000;
						
						nextState = BuscaMem;  
					end
			endcase
		end
		
		LUISoma: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShift = 5'b10000;
					
			nextState = LUICarregaReg;    
	
		end
		
		LUICarregaReg: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
					
			nextState = BuscaMem; 
		end
		
		LWRegABLoad :begin	
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = LWCalcOffset ;
		end
		
		
		LWCalcOffset :begin	
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = LWReadMem ;
		end
		
		LWReadMem : begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState <= LWEspera1 ;
			
		end
		
		LWEspera1 : begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState <= LWEspera2;
			
		end
		
		LWEspera2 : begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState <= LWMDRLoad ;
			
		end
		
		LWMDRLoad :begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState <= LWFinish ;
		end
		
		LWFinish :begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState <= BuscaMem;
		end
				
		SWRegABLoad :begin	
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = SWCalcOffset ;
		end
		
		SWCalcOffset :begin	
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = SWEscritaMem ;
		end
		
		SWEscritaMem :begin	
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = BuscaMem;
		end
		
		
		RRegABLoad: begin
			FontePC = 2'b00;
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
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = RULAOp;
		end
		
		RULAOp: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b0;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = RRegLoad;
		end
		
		RRegLoad: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = BuscaMem;
		end
		
		BreakState: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = BreakState;
		end
		
		BEQDesloc: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = BEQBegin;
		end
		
		BEQBegin: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
				
			nextState = BEQLoadAB;
		end
		
		BEQLoadAB: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 1'b0;
			IouD = 1'b0; //
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
	
			nextState <= BEQSolution;
		end
		
		BEQSolution: begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b01;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0; ;; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b1;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
	
			nextState <= BuscaMem;
		end
		
		BNEDesloc: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState = BNEBegin;
		end
		
		BNEBegin: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 1'b0;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
						
			nextState = BNELoadAB;
		end
		
		BNELoadAB: begin
			FontePC = 2'b00;
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
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
	
			nextState <= BNESolution;
		end
		
		BNESolution: begin
			FontePC = 2'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b01;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0; ;; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b1;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShift = 5'b00000;
	
			nextState <= BuscaMem;
		end
		
		RRegLoadABJr: begin
			FontePC = 2'b0;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0; //
			RegACtrl = 1'b1;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b1;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
	
			nextState <= RLoadPCJr;
	
		end
		
		RLoadPCJr: begin
			FontePC = 2'b0;
			PCEsc = 1'b1;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 1'b0;
			IouD = 1'b0; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b1;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
	
			nextState <= BuscaMem;
	
		end
		
		default: begin
			FontePC = 2'b00;
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
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShift = 5'b00010;
			
			nextState <= BuscaMem;
		end
	endcase
end


endmodule: controlador