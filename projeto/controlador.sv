module controlador(input logic Clock, Reset, Overflow, input logic[5:0] OpCode, InstrArit,
output logic PCEsc, CtrMem, IREsc, RegWrite, RegDst, ULAFonteA,
output logic[1:0] ULAFonteB, MemParaReg,
output logic[2:0] FontePC,
output logic[1:0] RegACtrl,
output logic[1:0] RegBCtrl, ULASaidaCtrl, MDRCtrl,
output logic[1:0] ULAOp,
output[5:0] state,
output logic PCEscCond,
output logic PCEscCondBNE,
output logic IouD,
output logic resetRegA,
output logic [2:0] ShiftControl,
output logic CtrlMuxDeslocamento,
output logic [1:0] NumShiftCtrl,
output logic [1:0] WordouHWouByte,
output logic LoadMult,
output logic ExceptionSelector, LoadEPC);


enum logic [5:0] {
  BuscaMem = 6'd0,
  EsperaBusca = 6'd1,
  EscIR = 6'd2,
  Decode = 6'd3, 
  LWRegABLoad = 6'd4, 
  LWCalcOffset = 6'd5,
  LWReadMem = 6'd6,
  LWEspera1= 6'd7, 
  LWEspera2 = 6'd8,
  LWMDRLoad = 6'd9,
  LWFinish = 6'd10,
  SWRegABLoad = 6'd11,
  SWCalcOffset = 6'd12,
  SWEscritaMem = 6'd13,
  RRegABLoad = 6'd14,
  RULAOp = 6'd15,
  RRegLoad = 6'd16,
  BreakState = 6'd17,
  BEQLoadAB = 6'd18,
  BEQDesloc = 6'd19,
  BEQBegin = 6'd20,
  BEQSolution = 6'd21,
  BNELoadAB = 6'd22,
  BNEDesloc = 6'd23,
  BNEBegin = 6'd24,
  BNESolution = 6'd25,
  LUISoma = 6'd26,
  LUICarregaReg = 6'd27,
  RRegLoadABJr = 6'd28,
  RLoadPCJr = 6'd29,
  SLLLoadB = 6'd30,
  SLLLoadRegDesloc = 6'd31,
  SLLCalcDesloc = 6'd32,
  SLLRegEsc = 6'd33,
  SLLVLoadRegDesloc = 6'd34,
  SLLVCalcDesloc = 6'd35,
  SLLVRegEsc = 6'd36,
  SRLLoadB = 6'd37,
  SRLLoadRegDesloc = 6'd38,
  SRLCalcDesloc = 6'd39,
  SRLRegEsc = 6'd40,
  ADDIExec = 6'd41,
  ADDIFinish = 6'd42,
  LBURegABLoad = 6'd43,
  LBUCalcOffset = 6'd44,
  LBUReadMem = 6'd45,
  LBUEspera1= 6'd46, 
  LBUEspera2 = 6'd47,
  LBUMDRLoad = 6'd48,
  LBUFinish = 6'd49,
  LHURegABLoad = 6'd50,
  LHUCalcOffset = 6'd51,
  LHUReadMem = 6'd52,
  LHUEspera1= 6'd53, 
  LHUEspera2 = 6'd54,
  LHUMDRLoad = 6'd55,
  LHUFinish = 6'd56,
  SRALoadB = 6'd57,
  SRALoadRegDesloc = 6'd58,
  SRACalcDesloc = 6'd59,
  SRARegEsc = 6'd60,
  SRAVLoadRegDesloc = 6'd61,
  SRAVCalcDesloc = 6'd62,
  SRAVRegEsc = 6'd63
  
  
  
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
			PCEsc = 1'b1;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 2'b00;
			IouD = 1'b0; ;; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
	
			nextState <= EsperaBusca;
			
		end
		EsperaBusca: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= EscIR;
			
		end
		EscIR : begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b1;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= Decode;
		end
		
		Decode: begin
			case(OpCode)
				6'b000000: // Operacoes aritmeticas
					begin
						case(InstrArit)
				
							6'b001101:
								begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 2'b00;
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 2'b00;
									IouD = 1'b0;
									RegACtrl = 1'b0;
									RegBCtrl = 1'b0;
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShiftCtrl = 2'b00;
									CtrlMuxDeslocamento = 1'b0;
									WordouHWouByte = 2'b00;
									LoadMult = 1'b0;
									ExceptionSelector = 1'b0;
									LoadEPC = 1'b0;
									
									nextState <= BreakState;
								end
							6'b000000: // NOP ou sll
								begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 2'b00;
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 2'b00;
									IouD = 1'b0;
									RegACtrl = 1'b0;
									RegBCtrl = 1'b0;
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShiftCtrl = 2'b00;
									CtrlMuxDeslocamento = 1'b0;
									WordouHWouByte = 2'b00;
									LoadMult = 1'b0;
									ExceptionSelector = 1'b0;
									LoadEPC = 1'b0;
									
									nextState <= SLLLoadB;
								end
								
							6'h2:
								begin //srl
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 2'b00;
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 2'b00;
									IouD = 1'b0;
									RegACtrl = 1'b0;
									RegBCtrl = 1'b0;
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShiftCtrl = 2'b00;
									CtrlMuxDeslocamento = 1'b0;
									WordouHWouByte = 2'b00;
									LoadMult = 1'b0;
									ExceptionSelector = 1'b0;
									LoadEPC = 1'b0;
									
									nextState <= SRLLoadB;
								end
							6'h7: // SRAV
								begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 2'b00;
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 2'b00;
									IouD = 1'b0;
									RegACtrl = 1'b1; //carrega registrador A do banco de registradores
									RegBCtrl = 1'b1; //carrega registrador B do banco de registradores
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShiftCtrl = 2'b00;
									CtrlMuxDeslocamento = 1'b0;
									WordouHWouByte = 2'b00;
									LoadMult = 1'b0;
									ExceptionSelector = 1'b0;
									LoadEPC = 1'b0;
									
									nextState <= SRAVLoadRegDesloc;
								end
								
							6'b001000:
								begin //jr
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 2'b00;
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 2'b00;
									IouD = 1'b0;
									RegACtrl = 1'b0;
									RegBCtrl = 1'b0;
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShiftCtrl = 2'b00;
									CtrlMuxDeslocamento = 1'b0;
									WordouHWouByte = 2'b00;
									LoadMult = 1'b0;
									ExceptionSelector = 1'b0;
									LoadEPC = 1'b0;
									
									nextState <= RRegLoadABJr;
								end
								
							6'h4:
								begin // sllv
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 2'b00;
									RegWrite = 1'b0;
									RegDst = 1'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 2'b00;
									IouD = 1'b0;
									RegACtrl = 1'b1; //carrega registrador A do banco de registradores
									RegBCtrl = 1'b1; //carrega registrador B do banco de registradores
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShiftCtrl = 2'b00;
									CtrlMuxDeslocamento = 1'b0;
									WordouHWouByte = 2'b00;
									LoadMult = 1'b0;
									ExceptionSelector = 1'b0;
									LoadEPC = 1'b0;
									
									nextState <= SLLVLoadRegDesloc;
								end
								
							6'h3: //sra
								begin 
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 2'b11;
									RegWrite = 1'b0;
									RegDst = 1'b1;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 2'b00;
									IouD = 1'b0;
									RegACtrl = 1'b0;
									RegBCtrl = 1'b0;
									ULASaidaCtrl = 1'b0;
									MDRCtrl = 1'b0;
									PCEscCond = 1'b0;
									PCEscCondBNE = 1'b0;
									resetRegA = 1'b0;
									ShiftControl = 3'b000;
									NumShiftCtrl = 2'b00;
									CtrlMuxDeslocamento = 1'b0;
									WordouHWouByte = 2'b00;
									LoadMult = 1'b0;
									ExceptionSelector = 1'b0;
									LoadEPC = 1'b0;
									
									nextState <= SRALoadB;
								end
								
						
							default: begin 
								FontePC = 3'b000;
								PCEsc = 1'b0;
								CtrMem = 1'b0; // *
								IREsc = 1'b0;
								ULAOp = 2'b11;
								RegWrite = 1'b0;
								RegDst = 1'b1;
								ULAFonteA = 1'b0;
								ULAFonteB = 2'b00;
								MemParaReg = 2'b00;
								IouD = 1'b0;
								RegACtrl = 1'b0;
								RegBCtrl = 1'b0;
								ULASaidaCtrl = 1'b0;
								MDRCtrl = 1'b0;
								PCEscCond = 1'b0;
								PCEscCondBNE = 1'b0;
								resetRegA = 1'b0;
								ShiftControl = 3'b000;
								NumShiftCtrl = 2'b00;
								CtrlMuxDeslocamento = 1'b0;
								WordouHWouByte = 2'b00;
								LoadMult = 1'b0;
								ExceptionSelector = 1'b0;
								LoadEPC = 1'b0;
								
								nextState <= RRegABLoad;
							end
						endcase
					end
					
				6'b001000:  //ADDI
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b1;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
									
						nextState <= ADDIExec;
					end
				
				6'b000010: //Jump
					begin
						FontePC = 3'b010;
						PCEsc = 1'b1;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState <= BuscaMem ;
					end
				6'b100011: // lw
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b11;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState <= LWRegABLoad ;
					end
				6'b101011: // sw
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b11;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState <= SWRegABLoad;
					end
					
				6'b000100: // beq load registrador de deslocamento
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg =2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;	
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b001;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState = BEQDesloc;
					end
					
				6'b000101: // bne load registrador de deslocamento
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;	
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b001;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState = BNEDesloc;
					end
					
				6'b001111: // lui
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b00;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b1;
						ULAFonteB = 2'b11;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;	
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b1;
						ShiftControl = 3'b001;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState = LUISoma;                                                                                                        
					end
					
					6'b100100: //lbu
						begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b11;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState <= LBURegABLoad ;
					end
					
					6'b100101: //lhu
						begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 2'b11;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b0;
						ShiftControl = 3'b000;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b0;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b0;
						
						nextState <= LHURegABLoad ;
					end
			
					
				default:
					begin
						FontePC = 3'b011;
						PCEsc =1'b1;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 2'b11;
						RegWrite = 1'b0;
						RegDst = 1'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg = 2'b00;
						IouD = 1'b0;
						RegACtrl = 1'b0;
						RegBCtrl = 1'b0;
						ULASaidaCtrl = 1'b0;
						MDRCtrl = 1'b0;
						PCEscCond = 1'b0;
						PCEscCondBNE = 1'b0;
						resetRegA = 1'b1;
						ShiftControl = 3'b010;
						NumShiftCtrl = 2'b00;
						CtrlMuxDeslocamento = 1'b0;
						WordouHWouByte = 2'b00;
						LoadMult = 1'b1;
						ExceptionSelector = 1'b0;
						LoadEPC = 1'b1;
						
						nextState = BuscaMem;  
					end
			endcase
		end
		
		ADDIExec: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; // load do registrador
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = ADDIFinish;  
		end
		
		ADDIFinish: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; // load do registrador
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; // seleciona a sa�da do resgitrador B para ser o n�mero a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = BuscaMem; 
		end
		
		
		SLLVLoadRegDesloc: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; // load do registrador
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; // seleciona a sa�da do resgitrador B para ser o n�mero a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SLLVCalcDesloc; 
		end
		
		SLLVCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010; // deslocamento LOGICO a esquerda N vezes
			NumShiftCtrl = 2'b10; // seleciona a entrada N do regdesloc
			// *********** pode causar overflow !!! ainda n�o tratado!
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SLLVRegEsc; 
		end
		
		SLLVRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1; // habilita a escrita no banco de regs.
			RegDst = 1'b1; // registrador a ser escrito ser� intr[15:11]
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b10; // seleciona o que vai ser escrito para o que est� saindo do registrador deslocamento
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0; // reset tem que ser 0
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = BuscaMem; 
		end
		
		SRAVLoadRegDesloc: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; // load do registrador
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; // seleciona a sa�da do resgitrador B para ser o n�mero a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRAVCalcDesloc; 
		end
		
		SRAVCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b100; // deslocamento ARIT a direita N vezes
			NumShiftCtrl = 2'b10; // seleciona a entrada N do regdesloc
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRAVRegEsc; 
		end
		
		SRAVRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1; // habilita a escrita no banco de regs.
			RegDst = 1'b1; // registrador a ser escrito ser� intr[15:11]
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b10; // seleciona o que vai ser escrito para o que est� saindo do registrador deslocamento
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0; // reset tem que ser 0
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = BuscaMem; 
		end
		
		SRLLoadB: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRLLoadRegDesloc; 
		end
		
		SRLLoadRegDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b001;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRLCalcDesloc; 
		end
		
		
		SRLCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b011;
			NumShiftCtrl = 2'b01;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRLRegEsc; 
		end
		
		SRLRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b10;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = BuscaMem; 
		end	
		
		SRALoadB: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRALoadRegDesloc; 
		end
		
		SRALoadRegDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b001;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRACalcDesloc; 
		end
		
		
		SRACalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b100;
			NumShiftCtrl = 2'b01;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SRARegEsc; 
		end
		
		SRARegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b10;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = BuscaMem; 
		end	
		
		
		
		SLLLoadB: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SLLLoadRegDesloc; 
		end
		
		
		SLLLoadRegDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b001;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SLLCalcDesloc; 
		end
		
		
		SLLCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b01;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = SLLRegEsc; 
		end
		
		SLLRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b10;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = BuscaMem; 
		end
		
		
		
		LUISoma: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b1;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = LUICarregaReg;    
	
		end
		
		LUICarregaReg: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
					
			nextState = BuscaMem; 
		end
		
		LBURegABLoad: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg =2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = LBUCalcOffset ;
		end
		
		LBUCalcOffset: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = LBUReadMem;
		end
		
		LBUReadMem: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LBUEspera1 ;
		end
		
		LBUEspera1: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LBUEspera2;
		end
			
		LBUEspera2: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LBUMDRLoad ;
		end
		
		LBUMDRLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b1;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LBUFinish ;
		end
		
		LBUFinish: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b01;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b10;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= BuscaMem;
		end
		
		LHURegABLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg =2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = LHUCalcOffset ;
		end
		
		LHUCalcOffset: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = LHUReadMem;
		end
		
		LHUReadMem: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LHUEspera1 ;
		end
		
		LHUEspera1: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LHUEspera2;
		end
			
		LHUEspera2: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LHUMDRLoad ;
		end
		
		LHUMDRLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b1;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LHUFinish ;
		end
		
		LHUFinish: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b01;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b01;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= BuscaMem;
		end
		
		
		LWRegABLoad :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg =2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = LWCalcOffset ;
		end
		
		
		LWCalcOffset :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = LWReadMem ;
		end
		
		LWReadMem : begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LWEspera1 ;
			
		end
		
		LWEspera1 : begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LWEspera2;
			
		end
		
		LWEspera2 : begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LWMDRLoad ;
			
		end
		
		LWMDRLoad :begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b1;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= LWFinish ;
		end
		
		LWFinish :begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b1;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b01;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= BuscaMem;
		end
				
		SWRegABLoad :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = SWCalcOffset ;
		end
		
		SWCalcOffset :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = SWEscritaMem ;
		end
		
		SWEscritaMem :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b1;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 2'b00;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = BuscaMem;
		end
		
		
		RRegABLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b1;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = RULAOp;
		end
		
		RULAOp: begin
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b0;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			if(Overflow &&(InstrArit == 6'h20 || InstrArit == 6'h22)) 
			begin
				FontePC = 3'b11;
				ExceptionSelector = 1'b1;
				LoadEPC = 1'b1;
				PCEsc = 1'b1;
				nextState = BuscaMem;
			end
			else begin
				FontePC = 3'b00;
				ExceptionSelector = 1'b0;
				LoadEPC = 1'b0;
				PCEsc = 1'b0;
				nextState = RRegLoad;
			end
		end
		
		RRegLoad: begin
			FontePC =3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b10;
			RegWrite = 1'b1;
			RegDst = 1'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = BuscaMem;
		end
		
		BreakState: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			WordouHWouByte = 2'b00;
			nextState = BreakState;
		end
		
		BEQDesloc: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = BEQBegin;
		end
		
		BEQBegin: begin
			FontePC =3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
				
			nextState = BEQLoadAB;
		end
		
		BEQLoadAB: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 2'b00;
			IouD = 1'b0; //
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
	
			nextState <= BEQSolution;
		end
		
		BEQSolution: begin
			FontePC = 3'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b01;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0; ;; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b1;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
	
			nextState <= BuscaMem;
		end
		
		BNEDesloc: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState = BNEBegin;
		end
		
		BNEBegin: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
						
			nextState = BNELoadAB;
		end
		
		BNELoadAB: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b00;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 2'b00;
			IouD = 1'b0; ;; //
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
	
			nextState <= BNESolution;
		end
		
		BNESolution: begin
			FontePC =3'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b01;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0; ;; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b1;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
	
			nextState <= BuscaMem;
		end
		
		RRegLoadABJr: begin
			FontePC = 3'b0;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0; //
			RegACtrl = 1'b1;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b1;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			nextState <= RLoadPCJr;
	
		end
		
		RLoadPCJr: begin
			FontePC = 3'b0;
			PCEsc = 1'b1;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0; //
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b1;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
	
			nextState <= BuscaMem;
	
		end
		
		default: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b11;
			RegWrite = 1'b0;
			RegDst = 1'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 2'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b010;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			
			nextState <= BuscaMem;
		end
	endcase
end


endmodule: controlador