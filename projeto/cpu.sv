module cpu(input clock, reset,
  output logic [31:0] Alu, MemData, WriteDataReg, AluOut, PC,
  output logic [4:0] WriteRegister,
  output logic wr, RegWrite, IRWrite, IouD,
  output logic [6:0] Estado,
  output logic [31:0]EntradaULA1, EntradaULA2,
  output logic [31:0] Reg_Desloc,
  output logic [63:0] resultado_mult,
  output logic [31:0] MDR, EPC,
  output logic [31:0] WriteDataMem, Address, EntradaRegDeslocamento,
  output logic [4:0] contador_mult,
  output logic [31:0] ReadData1, ReadData2
  );
   logic [1:0] EscritaSelection;
   logic [5:0] Instr31_26;
   logic [4:0] Instr25_21;
   logic [4:0] Instr20_16;
   logic [15:0] Instr15_0;
  logic [2:0] MemParaReg;
   logic[31:0] ExceptionAddress;
	// multiplicador:
	logic [63:0] resultadoMultTeste, resultado_atualMultTest;	
    logic[31:0] SaidaB, SaidaA, extensor32bits ; // COLOCAR DE VOLTA COMO OUTPUT -- TIRADO PRA DEBUGAR O MULTIPLICADOR
	logic [31:0] flavio;
	logic [1:0] WordouHWouByte;
	
	logic CtrlMuxDeslocamento;
	logic [1:0] NumShiftCtrl;
	logic [4:0] NumShiftEntrada;

	logic[4:0] NumShift;
    //logic [31:0] SaidaA;
	
	logic LoadMult, ExceptionSelector,OverflowULA;
	logic NegativoULA;
	logic IgualULA;
		
	logic[31:0] pcJump;
	logic PCEscCondBNE;
	logic [2:0]ULAOp;
	logic [2:0] FontePC; 
	logic [31:0]EntradaPC;
	logic [31:0]  mult_low, mult_high;
	// logic [31:0] SaidaA;
	logic PCEsc;
	logic ULAFonteA;
	logic [1:0] RegDst;
	logic RegACtrl, RegBCtrl, ULASaidaCtrl, MDRCtrl;
	logic[1:0] ULAFonteB;
	logic PCEscCond;
	logic ZeroULA;
	logic[2:0] ULAOpSelector;
	//logic[4:0] NumShift;
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
	
	
	Registrador EPCReg(.Clk(clock),
	.Reset(reset),
	.Load(LoadEPC),
	.Entrada(PC-4),
	.Saida(EPC)); // instru��o rte : EPC -> PC: tro
	
	Registrador HighMult(.Clk(clock),
	.Reset(reset),
	.Load(1'b1),
	.Entrada(resultado_mult[63:32]),
	.Saida(mult_high));
	
	Registrador LowMult(.Clk(clock),
	.Reset(reset),
	.Load(1'b1),
	.Entrada(resultado_mult[31:0]),
	.Saida(mult_low));
	
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
	.Saida(SaidaB));
	
	
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
	.Maior(MenorULA), // CUIDADO A FRENTE! 
	.Menor(MaiorULA));

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
	.CtrlMuxDeslocamento(CtrlMuxDeslocamento),
	.WordouHWouByte(WordouHWouByte),
	.LoadMult(LoadMult),
	.LoadEPC(LoadEPC),
	.ExceptionSelector(ExceptionSelector),
	.Overflow(OverflowULA),
	.contador_mult(contador_mult),
	.EscritaSelection(EscritaSelection)
);
	
	mux4entradas32bits RegisterWriteSelection(.controlador(RegDst),  // MUX AUMENTADO DE 2X1 P 4X1
	.entrada0(Instr20_16),
	.entrada1(Instr15_0[15:11]),
	.entrada2(32'd31),
	.entrada3(32'd666),
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
	.entrada0(SaidaB),
	.entrada1(32'd4),
	.entrada2(extensor32bits),
	.entrada3(Reg_Desloc),
	.saidaMux(EntradaULA2));
	
	mux8entradas32bits DadoASerEscritoSelection(.controlador(MemParaReg),
	.entrada0(AluOut),
	.entrada1(flavio),
	.entrada2(Reg_Desloc),
	.entrada3({31'b0, MenorULA}),
	.entrada4(mult_high),
	.entrada5(mult_low),
	.entrada6(32'd666),
	.entrada7(32'd666),
	.saidaMux(WriteDataReg));
	
	mux4entradas32bits EscritaMemSelection(.controlador(EscritaSelection),
	.entrada0(SaidaB),
	.entrada1({MemData[31:8], SaidaB[7:0]}),
	.entrada2({MemData[31:16], SaidaB[15:0]}),
	.entrada3(32'd666),
	.saidaMux(WriteDataMem));
	
	mux8entradas32bits FontePCSelection(.controlador(FontePC),  
	.entrada0(Alu),
	.entrada1(AluOut),
	.entrada2(pcJump),
	.entrada3(ExceptionAddress),
	.entrada4(EPC),
	.entrada5(flavio),
	.entrada6(EPC),
	.entrada7(32'd0),
	.saidaMux(EntradaPC));
	
	mux2entradas32bits_real ExceptionMUX(.controlador(ExceptionSelector),
	.entrada0(32'd254), // OPCODE inexistente
	.entrada1(32'd255), //Overflow arit
	.saidaMux(ExceptionAddress));

	mux2entradas32bits_real dadoASerDeslocado(.controlador(CtrlMuxDeslocamento),
	.entrada0(extensor32bits),
	.entrada1(SaidaB),
	.saidaMux(EntradaRegDeslocamento));
	
	mux4entradas5bits NumShiftSelection(.controlador(NumShiftCtrl),
	.entrada0(5'b0010), 
	.entrada1(Instr15_0[10:6]),
	.entrada2(SaidaA[4:0]),
	.entrada3(5'd9),
	.saidaMux(NumShiftEntrada));

	extensor16to32bits extenssor(.entrada(Instr15_0),
	.saida(extensor32bits));
	
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
			.Saida(Reg_Desloc));
	
	getByteOrHw CortadorDePalavras(.WordouHWouByte(WordouHWouByte),
				.MDR(MDR),
				.flavio(flavio));
				
				
	mul Multiplicador(.Clock(clock),
					  .load(LoadMult),
					  .multiplicador(SaidaA),
					  .multiplicando(SaidaB),
					  .resultado(resultado_mult),
					  .counter(contador_mult));
	

endmodule: cpu


