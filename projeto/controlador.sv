module controlador(input logic Clock, Reset, Overflow, input logic [4:0]contador_mult, input logic[5:0] OpCode, InstrArit,
output logic PCEsc, CtrMem, IREsc, RegWrite, ULAFonteA,
output logic[1:0] ULAFonteB, RegDst,
output logic[2:0] FontePC, MemParaReg,
output logic[1:0] RegACtrl,
output logic[1:0] RegBCtrl, ULASaidaCtrl, MDRCtrl,
output logic[2:0] ULAOp,
output[6:0] state,
output logic PCEscCond,
output logic PCEscCondBNE,
output logic IouD,
output logic resetRegA,
output logic [2:0] ShiftControl,
output logic CtrlMuxDeslocamento,
output logic [1:0] NumShiftCtrl,
output logic [1:0] WordouHWouByte,
output logic LoadMult,
output logic ExceptionSelector, LoadEPC,
output logic [1:0] EscritaSelection
);

enum logic [6:0] {
  BuscaMem = 7'd0,
  EsperaBusca = 7'd1,
  EscIR = 7'd2,
  Decode = 7'd3, 
  LWRegABLoad = 7'd4, 
  LWCalcOffset = 7'd5,
  LWReadMem = 7'd6,
  LWEspera1= 7'd7, 
  LWEspera2 = 7'd8,
  LWMDRLoad = 7'd9,
  LWFinish = 7'd10,
  SWRegABLoad = 7'd11,
  SWCalcOffset = 7'd12,
  SWEscritaMem = 7'd13,
  RRegABLoad = 7'd14,
  RULAOp = 7'd15,
  RRegLoad = 7'd16,
  BreakState = 7'd17,
  BEQLoadAB = 7'd18,
  BEQDesloc = 7'd19,
  BEQBegin = 7'd20,
  BEQSolution = 7'd21,
  BNELoadAB = 7'd22,
  BNEDesloc = 7'd23,
  BNEBegin = 7'd24,
  //BNESolution = 7'd25,
  LUISoma = 7'd26,
  LUICarregaReg = 7'd27,
  RRegLoadABJr = 7'd28,
  RLoadPCJr = 7'd29,
  SLLLoadB = 7'd30,
  SLLLoadRegDesloc = 7'd31,
  SLLCalcDesloc = 7'd32,
  SLLRegEsc = 7'd33,
  SLLVLoadRegDesloc = 7'd34,
  SLLVCalcDesloc = 7'd35,
  SLLVRegEsc = 7'd36,
  SRLLoadB = 7'd37,
  SRLLoadRegDesloc = 7'd38,
  SRLCalcDesloc = 7'd39,
  SRLRegEsc = 7'd40,
  ADDIExec = 7'd41,
  ADDIFinish = 7'd42,
  LBURegABLoad = 7'd43,
  LBUCalcOffset = 7'd44,
  LBUReadMem = 7'd45,
  LBUEspera1= 7'd46, 
  LBUEspera2 = 7'd47,
  LBUMDRLoad = 7'd48,
  LBUFinish = 7'd49,
  LHURegABLoad = 7'd50,
  LHUCalcOffset = 7'd51,
  LHUReadMem = 7'd52,
  LHUEspera1= 7'd53, 
  LHUEspera2 = 7'd54,
  LHUMDRLoad = 7'd55,
  LHUFinish = 7'd56,
  SRALoadB = 7'd57,
  SRALoadRegDesloc = 7'd58,
  SRACalcDesloc = 7'd59,
  SRARegEsc = 7'd60,
  SRAVLoadRegDesloc = 7'd61,
  SRAVCalcDesloc = 7'd62,
  SRAVRegEsc = 7'd63,
  ADDIUExec = 7'd64,
  ADDIUFinish = 7'd65,
  SXORIExec = 7'd66,
  SXORIFinish = 7'd67,
  ANDIExec = 7'd68,
  ANDIFinish = 7'd69,
  MULT = 7'd70,
  MULTLoop = 7'd71,
  SLT = 7'd74,
  SLTI = 7'd75,
  SBCalcAddress = 7'd76,
  SBLeituraWord = 7'd77,
  SBEspera1 = 7'd78,
  SBEspera2 = 7'd79,
  SBEscritaMem = 7'd80,
  SBEstabilizarMem1 = 7'd81,
  SBEstabilizarMem2 = 7'd82,
  SHCalcAddress = 7'd83,
  SHLeituraWord = 7'd84,
  SHEspera1 = 7'd85,
  SHEspera2 = 7'd86,
  SHEscritaMem = 7'd87,
  SHEstabilizarMem1 = 7'd88,
  SHEstabilizarMem2 = 7'd89,  
  JALArmazenarPC = 7'd90, 
  
  
  TratamentoExcecaoEspera1 = 7'd95,
  TratamentoExcecaoEspera2 = 7'd96,
  TratamentoExcecaoMDRLoad = 7'd97,
  TratamentoExcecaoFinish = 7'd98
  
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
			ULAOp = 3'b00;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
	
			nextState <= EsperaBusca;
			
		end
		EsperaBusca: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= EscIR;
			
		end
		EscIR : begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b1;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= Decode;
		end
		
		Decode: begin
			case(OpCode)
				6'b000000: // Operacoes aritmeticas
					begin
						case(InstrArit)
				
							6'b001101: // break
								begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 3'b000;
									RegWrite = 1'b0;
									RegDst = 2'b0;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= BreakState;
								end
							6'b000000: // NOP ou sll
								begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 3'b000;
									RegWrite = 1'b0;
									RegDst = 2'b0;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= SLLLoadB;
								end
								
							6'h2:
								begin //srl
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 3'b000;
									RegWrite = 1'b0;
									RegDst = 2'b0;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= SRLLoadB;
								end
							6'h7: // SRAV
								begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 3'b000;
									RegWrite = 1'b0;
									RegDst = 2'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= SRAVLoadRegDesloc;
								end
								
							6'b001000:
								begin //jr
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 3'b000;
									RegWrite = 1'b0;
									RegDst = 2'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= RRegLoadABJr;
								end
								
							6'h4:
								begin // sllv
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 3'b000;
									RegWrite = 1'b0;
									RegDst = 2'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= SLLVLoadRegDesloc;
								end
							6'h2a:
								begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0;
									IREsc = 1'b0;
									ULAOp = 3'b000;
									RegWrite = 1'b0;
									RegDst = 2'b0;
									ULAFonteA = 1'b1;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= SLT;
								end
								
							6'h3: //sra
								begin 
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 3'b011;
									RegWrite = 1'b0;
									RegDst = 2'b1;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= SRALoadB;
								end
								6'h18: //MUL
									begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 3'b011;
									RegWrite = 1'b0;
									RegDst = 2'b1;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b00;
									IouD = 1'b0;
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
									EscritaSelection = 2'b00;
									
									
									nextState <= MULT;
									end
								6'h10: //MFHI
									begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 3'b011;
									RegWrite = 1'b1;
									RegDst = 2'b1;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b100;
									IouD = 1'b0;
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
									EscritaSelection = 2'b00;
									
									nextState <= BuscaMem;
									end
								6'h12: //MHLO
									begin
									FontePC = 3'b000;
									PCEsc = 1'b0;
									CtrMem = 1'b0; // *
									IREsc = 1'b0;
									ULAOp = 3'b011;
									RegWrite = 1'b1;
									RegDst = 2'b1;
									ULAFonteA = 1'b0;
									ULAFonteB = 2'b00;
									MemParaReg = 3'b101;
									IouD = 1'b0;
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
									EscritaSelection = 2'b00;
									
									nextState <= BuscaMem;
									end
								
						
							default: begin 
								FontePC = 3'b000;
								PCEsc = 1'b0;
								CtrMem = 1'b0; // *
								IREsc = 1'b0;
								ULAOp = 3'b011;
								RegWrite = 1'b0;
								RegDst = 2'b1;
								ULAFonteA = 1'b0;
								ULAFonteB = 2'b00;
								MemParaReg = 3'b00;
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
								EscritaSelection = 2'b00;
								
								
								nextState <= RRegABLoad;
							end
						endcase
					end
					
				6'h10: // rte
					begin 
						FontePC = 3'b101;
						PCEsc = 1'b1;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b111;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
						IouD = 1'b0;
						RegACtrl = 1'b1;
						RegBCtrl = 1'b1;
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
						EscritaSelection = 2'b00;
						
						nextState <= BuscaMem;
					
					end
					
				6'h3: // jal
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b111;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
						IouD = 1'b0;
						RegACtrl = 1'b1;
						RegBCtrl = 1'b1;
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
						EscritaSelection = 2'b00;
						
						nextState <= JALArmazenarPC;
					end
				6'h28: // sb
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b1;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
						IouD = 1'b0;
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
						EscritaSelection = 2'b00;
						
						nextState <= SBCalcAddress;
					
				end
				
				6'h29: // sh
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						PCEsc = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b1;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
						IouD = 1'b0;
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
						EscritaSelection = 2'b00;
						
						nextState <= SHCalcAddress;
					
				end
				
				
				6'ha: begin // slti
						FontePC = 3'b000;
						PCEsc = 1'b0;
						IREsc = 1'b0;
						CtrMem = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b1;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
						IouD = 1'b0;
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
						EscritaSelection = 2'b00;
						
						nextState <= SLTI;
				end
					
				6'b001000:  //ADDI
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
									
						nextState <= ADDIExec;
					end
					
				6'b001001:  //ADDIU
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
									
						nextState <= ADDIUExec;
					end
				
				6'b000010: //Jump
					begin
						FontePC = 3'b010;
						PCEsc = 1'b1;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
						
						nextState <= BuscaMem ;
					end
				6'b100011: // lw
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 3'b011;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
						
						nextState <= LWRegABLoad ;
					end
				6'b101011: // sw
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 3'b011;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
						
						nextState <= SWRegABLoad;
					end
					
				6'b000100: // beq load registrador de deslocamento
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg =3'b00;
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
						EscritaSelection = 2'b00;
						
						
						nextState = BEQDesloc;
					end
					
				6'b000101: // bne load registrador de deslocamento
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg = 3'b00;
						IouD = 1'b0;
						RegACtrl = 1'b1;
						RegBCtrl = 1'b1;
						ULASaidaCtrl = 1'b1;
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
						EscritaSelection = 2'b00;
						
						
						nextState = BNEDesloc;
					end
					
				6'b001111: // lui
					begin
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 3'b000;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b1;
						ULAFonteB = 2'b11;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
						
						nextState = LUISoma;                                                                                                        
					end
					
				6'b100100: //lbu
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 3'b011;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
						
						nextState <= LBURegABLoad ;
					end
					
				6'b100101: //lhu
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0; // *
						IREsc = 1'b0;
						ULAOp = 3'b011;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
						
						nextState <= LHURegABLoad ;
					end
			
				6'he://sxori
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b100;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
									
						nextState <= SXORIExec;
					end
				6'hc:
					begin 
						FontePC = 3'b000;
						PCEsc = 1'b0;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b011;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b00;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
									
						nextState <= ANDIExec;
					end
					
				default:
					begin
						FontePC = 3'b011;
						PCEsc =1'b1;
						CtrMem = 1'b0;
						IREsc = 1'b0;
						ULAOp = 3'b011;
						RegWrite = 1'b0;
						RegDst = 2'b0;
						ULAFonteA = 1'b0;
						ULAFonteB = 2'b11;
						MemParaReg = 3'b00;
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
						EscritaSelection = 2'b00;
						
												
						nextState = TratamentoExcecaoEspera1;  
					end
			endcase
		end
		
		JALArmazenarPC: begin
			FontePC = 3'b010;
			PCEsc = 1'b1;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b10;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b000;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; 
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState = BuscaMem;
		end
		
		SHCalcAddress: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b011;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; 
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState = SHLeituraWord;
		end
		
		SHLeituraWord: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b011;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; 
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState <= SHEspera1;
		end
		
		SHEspera1: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
			IouD = 1'b1;
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
			EscritaSelection = 2'b00;
		
			nextState <= SHEscritaMem;
		end
		
		SHEscritaMem: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b1;
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
			IouD = 1'b1;
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
			EscritaSelection = 2'b10;
			
			nextState <= SHEstabilizarMem1;
		end
		
		SHEstabilizarMem1: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
		
			nextState <= SHEstabilizarMem2;
		end
		
		SHEstabilizarMem2: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
		
			nextState <= BuscaMem;
		end
		
		SBCalcAddress: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b011;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; 
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState = SBLeituraWord;
		end
		
		SBLeituraWord: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b011;
			IouD = 1'b1;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; 
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState <= SBEspera1;
		end
		
		SBEspera1: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
		
			nextState <= SBEscritaMem;
		end

		SBEscritaMem: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b1;
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
			IouD = 1'b1;
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
			EscritaSelection = 2'b01;
			
			nextState <= SBEstabilizarMem1;
		end
		
		SBEstabilizarMem1: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
		
			nextState <= SBEstabilizarMem2;
		end
		
		SBEstabilizarMem2: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
		
			nextState <= BuscaMem;
		end
		
		TratamentoExcecaoEspera1: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			WordouHWouByte = 2'b10;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState <= TratamentoExcecaoEspera2;
		end
		
		TratamentoExcecaoEspera2: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			WordouHWouByte = 2'b10;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState <= TratamentoExcecaoMDRLoad;
		end
		
		TratamentoExcecaoMDRLoad: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b0;
			MDRCtrl = 1'b1;
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b000;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b0;
			WordouHWouByte = 2'b10;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState <= TratamentoExcecaoFinish;
		end
		
		TratamentoExcecaoFinish: begin 
			FontePC = 3'b101;
			PCEsc = 1'b1;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b11;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			WordouHWouByte = 2'b10;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState <= BuscaMem;
		end
		
		
		
		
		SLTI: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b011;
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
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState = BuscaMem;
		end
		
		MULT: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; 
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b1;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState <= MULTLoop;			
		end
		
		SLT: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b0;
			MemParaReg = 3'b011;
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
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			nextState = BuscaMem;
		end
		
		MULTLoop: begin 
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; 
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001; 
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1; 
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
			if(contador_mult == 5'b11111) begin
				nextState = BuscaMem;
			end
			else begin 
				nextState = MULTLoop;
			end
		end
		
		
		
		ADDIExec: begin
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			if(Overflow) begin
				PCEsc = 1'b0;
				ExceptionSelector = 1'b0;
				LoadEPC = 1'b0;
				FontePC = 3'b100;
				nextState = BuscaMem;
			end	
			else begin
				PCEsc = 1'b0;
				ExceptionSelector = 1'b0;
				LoadEPC = 1'b0;
				FontePC = 3'b000;
				
				nextState = ADDIFinish; 
			end
				
			
			 
		end
		
		ADDIFinish: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			CtrlMuxDeslocamento = 1'b1; // seleciona a saída do resgitrador B para ser o número a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end
		
		ADDIUExec: begin
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			PCEsc = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			FontePC = 3'b000;
			EscritaSelection = 2'b00;
			
			
			nextState = ADDIUFinish; 
		end
		
		ADDIUFinish: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
			MDRCtrl = 1'b0;	
			PCEscCond = 1'b0;
			PCEscCondBNE = 1'b0;
			resetRegA = 1'b0;
			ShiftControl = 3'b001;
			NumShiftCtrl = 2'b00;
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end
		
		SXORIExec: begin
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b100;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			PCEsc = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			FontePC = 3'b000;
			EscritaSelection = 2'b00;
			
			
			nextState = SXORIFinish; 
		end
		
		SXORIFinish: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			CtrlMuxDeslocamento = 1'b1; // seleciona a saída do resgitrador B para ser o número a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end

		ANDIExec: begin
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			PCEsc = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			FontePC = 3'b000;
			EscritaSelection = 2'b00;
			
			
			nextState = ANDIFinish; 
		end
		
		ANDIFinish: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			CtrlMuxDeslocamento = 1'b1; // seleciona a saída do resgitrador B para ser o número a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end
		
		
		SLLVLoadRegDesloc: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			CtrlMuxDeslocamento = 1'b1; // seleciona a saída do resgitrador B para ser o número a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
					
			nextState = SLLVCalcDesloc; 
		end
		
		SLLVCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			// *********** pode causar overflow !!! ainda não tratado!
			CtrlMuxDeslocamento = 1'b1;
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
					
			nextState = SLLVRegEsc; 
		end
		
		SLLVRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1; // habilita a escrita no banco de regs.
			RegDst = 2'b1; // registrador a ser escrito será intr[15:11]
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b10; // seleciona o que vai ser escrito para o que está saindo do registrador deslocamento
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
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end
		
		SRAVLoadRegDesloc: begin
			FontePC = 2'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			CtrlMuxDeslocamento = 1'b1; // seleciona a saída do resgitrador B para ser o número a ser deslocado
			WordouHWouByte = 2'b00;
			LoadMult = 1'b0;
			ExceptionSelector = 1'b0;
			LoadEPC = 1'b0;
			EscritaSelection = 2'b00;
			
					
			nextState = SRAVCalcDesloc; 
		end
		
		SRAVCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
								
			nextState = SRAVRegEsc; 
		end
		
		SRAVRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1; // habilita a escrita no banco de regs.
			RegDst = 2'b1; // registrador a ser escrito será intr[15:11]
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b10; // seleciona o que vai ser escrito para o que está saindo do registrador deslocamento
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
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end
		
		SRLLoadB: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SRLLoadRegDesloc; 
		end
		
		SRLLoadRegDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SRLCalcDesloc; 
		end
		
		
		SRLCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SRLRegEsc; 
		end
		
		SRLRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b10;
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
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end	
		
		SRALoadB: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SRALoadRegDesloc; 
		end
		
		SRALoadRegDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SRACalcDesloc; 
		end
		
		
		SRACalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SRARegEsc; 
		end
		
		SRARegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b10;
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
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end	
		
		
		
		SLLLoadB: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SLLLoadRegDesloc; 
		end
		
		
		SLLLoadRegDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SLLCalcDesloc; 
		end
		
		
		SLLCalcDesloc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = SLLRegEsc; 
		end
		
		SLLRegEsc: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b10;
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
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end
		
		
		
		LUISoma: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = LUICarregaReg;    
	
		end
		
		LUICarregaReg: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
					
			nextState = BuscaMem; 
		end
		
		LBURegABLoad: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg =3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = LBUCalcOffset ;
		end
		
		LBUCalcOffset: begin
			FontePC = 3'b000;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = LBUReadMem;
		end
		
		LBUReadMem: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LBUEspera1 ;
		end
		
		LBUEspera1: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LBUEspera2;
		end
			
		LBUEspera2: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 2'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LBUMDRLoad ;
		end
		
		LBUMDRLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LBUFinish ;
		end
		
		LBUFinish: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b01;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= BuscaMem;
		end
		
		LHURegABLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg =3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = LHUCalcOffset ;
		end
		
		LHUCalcOffset: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = LHUReadMem;
		end
		
		LHUReadMem: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LHUEspera1 ;
		end
		
		LHUEspera1: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LHUEspera2;
		end
			
		LHUEspera2: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LHUMDRLoad ;
		end
		
		LHUMDRLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LHUFinish ;
		end
		
		LHUFinish: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b01;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= BuscaMem;
		end
		
		
		LWRegABLoad :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg =3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = LWCalcOffset ;
		end
		
		
		LWCalcOffset :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = LWReadMem ;
		end
		
		LWReadMem : begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			nextState <= LWEspera1 ;
			
		end
		
		LWEspera1 : begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LWEspera2;
			
		end
		
		LWEspera2 : begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LWMDRLoad ;
			
		end
		
		LWMDRLoad :begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= LWFinish ;
		end
		
		LWFinish :begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b1;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b01;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= BuscaMem;
		end
				
		SWRegABLoad :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = SWCalcOffset ;
		end
		
		SWCalcOffset :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = SWEscritaMem ;
		end
		
		SWEscritaMem :begin	
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b1;
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b10;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = BuscaMem;
		end
		
		
		RRegABLoad: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b1;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = RULAOp;
		end
		
		RULAOp: begin
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b010;
			RegWrite = 1'b0;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			if(Overflow &&(InstrArit == 6'h20 || InstrArit == 6'h22)) begin
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
			ULAOp = 3'b010;
			RegWrite = 1'b1;
			RegDst = 2'b1;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = BuscaMem;
		end
		
		BreakState: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			WordouHWouByte = 2'b00;
			nextState = BreakState;
		end
		
		BEQDesloc: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = BEQBegin;
		end
		
		BEQBegin: begin
			FontePC =3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
				
			nextState = BEQLoadAB;
		end
		
		BEQLoadAB: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b01;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
	
			nextState <= BEQSolution;
		end
		
		BEQSolution: begin
			FontePC = 3'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 3'b001;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
	
			nextState <= BuscaMem;
		end
		
		BNEDesloc: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState = BNEBegin;
		end
		
		BNEBegin: begin
			FontePC = 3'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0;
			IREsc = 1'b0;
			ULAOp = 3'b000;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b11;
			MemParaReg = 3'b00;
			IouD = 1'b0;
			RegACtrl = 1'b0;
			RegBCtrl = 1'b0;
			ULASaidaCtrl = 1'b1;
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
			EscritaSelection = 2'b00;
			
						
			nextState = BNELoadAB;
		end
		
		BNELoadAB: begin
			FontePC = 3'b001;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 3'b001;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
			IouD = 1'b0;
			RegACtrl = 1'b1;
			RegBCtrl = 1'b1;
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
			EscritaSelection = 2'b00;
			
	
			nextState <= BuscaMem;
		end
		
	/*	BNESolution: begin
			FontePC =3'b01;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 3'b001;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
				
			nextState <= BuscaMem;
		end
		*/
		RRegLoadABJr: begin
			FontePC = 3'b0;
			PCEsc = 1'b0;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 3'b111;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			nextState <= RLoadPCJr;
	
		end
		
		RLoadPCJr: begin
			FontePC = 3'b0;
			PCEsc = 1'b1;
			CtrMem = 1'b0; //
			IREsc = 1'b0;
			ULAOp = 3'b111;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b1;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
	
			nextState <= BuscaMem;
	
		end
		
		default: begin
			FontePC = 3'b00;
			PCEsc = 1'b0;
			CtrMem = 1'b0; // *
			IREsc = 1'b0;
			ULAOp = 3'b011;
			RegWrite = 1'b0;
			RegDst = 2'b0;
			ULAFonteA = 1'b0;
			ULAFonteB = 2'b00;
			MemParaReg = 3'b00;
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
			EscritaSelection = 2'b00;
			
			
			nextState <= BuscaMem;
		end
	endcase
end


endmodule: controlador