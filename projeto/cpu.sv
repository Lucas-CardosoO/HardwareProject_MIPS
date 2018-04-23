module cpu(input clock, reset,
  output logic [31:0] Alu, MemData, WriteDataMem, WriteDataReg, MDR, AluOut, PC,
  output logic [4:0] WriteRegister,
  output logic wr, RegWrite, IRWrite,
  output logic[5:0] Estado,
  output logic[31:0] extensorEShift,
  output logic[31:0] extensor32bits, Address,
  output logic [31:0]EntradaULA1, EntradaULA2,
  output logic [5:0] Instr31_26,
  output logic[4:0] Instr25_21,
  output logic[4:0] Instr20_16,
  output logic[15:0] Instr15_0,
  output logic CtrlMuxDeslocamento,
  output logic [1:0] NumShiftCtrl,
  output logic [4:0] NumShiftEntrada,
  output logic [31:0] EntradaRegDeslocamento
  );
	
	
	logic OverflowULA;
	logic NegativoULA;
	logic IgualULA;
	logic MaiorULA;
	logic MenorULA;
	logic[31:0] pcJump;
	logic PCEscCondBNE;
	logic IouD;
	logic [1:0]ULAOp, FontePC; 
	logic [31:0]EntradaPC;
	logic [31:0] ReadData1, ReadData2;
	logic [31:0] SaidaA;
	logic PCEsc;
	logic ULAFonteA;
	logic RegDst;
	logic RegACtrl, RegBCtrl, ULASaidaCtrl, MDRCtrl;
	logic[1:0] ULAFonteB;
	logic MemParaReg;
	logic PCEscCond;
	logic ZeroULA;
	logic[2:0] ULAOpSelector;
	logic[4:0] NumShift;
	logic[2:0] ShiftControl;
	logic resetRegA;
	
	Registrador PCreg(.Clk(clock),
	.Reset(reset),
	.Load(PCEsc || (PCEscCond && ZeroULA) || (PCEscCondBNE && !ZeroULA)),
	.Entrada(EntradaPC),
	.Saida(PC));

	Registrador MDRreg(.Clk(clock),
	.Reset(reset),
	.Load(MDRCtrl),
	.Entrada(MemData),
	.Saida(MDR));
	
	Registrador ULASaida(.Clk(clock),
	.Reset(reset),
	.Load(ULASaidaCtrl),
	.Entrada(Alu),
	.Saida(AluOut));
	
	Registrador A(.Clk(clock),
	.Reset(reset || resetRegA),
	.Load(RegACtrl),
	.Entrada(ReadData1),
	.Saida(SaidaA));
	
	Registrador B(.Clk(clock),
	.Reset(reset),
	.Load(RegBCtrl),
	.Entrada(ReadData2),
	.Saida(WriteDataMem));
	
	
	AluControl AluControl(.funct(Instr15_0[5:0]),
	.ULAOp(ULAOp),
	.ULAOpSelector(ULAOpSelector));

	ula32 ULA(.A(EntradaULA1),
	.B(EntradaULA2),
	.Seletor(ULAOpSelector),
	.S(Alu),
	.Overflow(OverflowULA),
	.Negativo(NegativoULA),
	.z(ZeroULA),
	.Igual(IgualULA),
	.Maior(MaiorULA),
	.Menor(MenorULA));

	Instr_Reg inst_reg(.Clk(clock), 
	.Reset(reset), 
	.Load_ir(IRWrite), 
	.Entrada(MemData), 
	.Instr31_26(Instr31_26),
	.Instr25_21(Instr25_21),
	.Instr20_16(Instr20_16),
	.Instr15_0(Instr15_0));

	Memoria Memory(.Address(Address),
	.Clock(clock),
	.Wr(wr),
	.DataIn(WriteDataMem),
	.DataOut(MemData));
	
	controlador ctrl(.Clock(clock),
	.OpCode(Instr31_26),
	.Reset(reset),
	.PCEsc(PCEsc),
	.CtrMem(wr),
	.IREsc(IRWrite),
	.ULAOp(ULAOp),
	.MemParaReg(MemParaReg),
	.RegWrite(RegWrite),
	.RegDst(RegDst),
	.ULAFonteA(ULAFonteA),
	.ULAFonteB(ULAFonteB),
	.state(Estado),
	.IouD(IouD),
	.RegACtrl(RegACtrl),
	.RegBCtrl(RegBCtrl),
	.ULASaidaCtrl(ULASaidaCtrl),
	.InstrArit(Instr15_0[5:0]),
	.PCEscCond(PCEscCond),
	.MDRCtrl(MDRCtrl),
	.FontePC(FontePC),
	.PCEscCondBNE(PCEscCondBNE),
	.NumShiftCtrl(NumShiftCtrl),
	.resetRegA(resetRegA),
	.ShiftControl(ShiftControl),
	.CtrlMuxDeslocamento(CtrlMuxDeslocamento));
	
	mux2entradas32bits RegisterWriteSelection(.controlador(RegDst), 
	.entrada0(Instr20_16),
	.entrada1(Instr15_0[15:11]),
	.saidaMux(WriteRegister));
	
	mux2entradas32bits_real IouDMux(.controlador(IouD),
	.entrada0(PC),
	.entrada1(AluOut),
	.saidaMux(Address));
	
	mux2entradas32bits_real EntradaULA1Selection(.controlador(ULAFonteA),
	.entrada0(PC),
	.entrada1(SaidaA),
	.saidaMux(EntradaULA1));	
	
	mux4entradas32bits EntradaULA2Selection(.controlador(ULAFonteB), 
	.entrada0(WriteDataMem),
	.entrada1(32'd4),
	.entrada2(extensor32bits),
	.entrada3(extensorEShift),
	.saidaMux(EntradaULA2));
	
	mux2entradas32bits_real DadoASerEscritoSelection(.controlador(MemParaReg),
	.entrada0(AluOut),
	.entrada1(MDR),
	.saidaMux(WriteDataReg));
	
	mux4entradas32bits FontePCSelection(.controlador(FontePC),  
	.entrada0(Alu),
	.entrada1(AluOut),
	.entrada2(pcJump),
	.entrada3(32'd666),
	.saidaMux(EntradaPC));

	mux2entradas32bits_real dadoASerDeslocado(.controlador(CtrlMuxDeslocamento),
	.entrada0(extensor32bits),
	.entrada1(SaidaB),
	.saidaMux(EntradaRegDeslocamento));
	
	mux4entradas5bits NumShiftSelection(.controlador(NumShiftCtrl),
	.entrada0(5'b00100), 
	.entrada1(Instr15_0[10:6]),
	.entrada2(5'd9), // SaidaA,
	.entrada3(5'd9),
	.saidaMux(NumShiftEntrada));

	extensor16to32bits extenssor(.entrada(Instr15_0),
	.saida(extensor32bits));
	
	//shiftLeft2bits shifter(.entrada(extensor32bits), .saida(extensorEShift), .contrl(NumShift));
	
	shiftLeft2bits26 shifterJ(.entrada({ Instr25_21, Instr20_16, Instr15_0 }), .entradaPC(PC), .saida(pcJump));


	Banco_reg BancoDeRegistradores(.Clk(clock),
	.Reset(reset),
	.RegWrite(RegWrite),
	.ReadReg1(Instr25_21),
	.ReadReg2(Instr20_16),
	.WriteReg(WriteRegister),
	.WriteData(WriteDataReg),
	.ReadData1(ReadData1),
	.ReadData2(ReadData2));
	
	
	RegDesloc Deslocamento(.Clk(clock),
		 	.Reset(reset),
			.Shift(ShiftControl),
			.N(NumShiftEntrada),
			.Entrada(EntradaRegDeslocamento),
			.Saida(extensorEShift));

endmodule: cpu


