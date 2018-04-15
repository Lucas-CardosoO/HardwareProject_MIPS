module cpu(input clock, reset, 
  output logic IouD,
  output logic [1:0]ULAOp, FontePC, //Mudou de 3 pra 2 bits
  output logic [31:0]PC, AluSaida,
  output logic [31:0]MemData, EntradaULA1, EntradaULA2, EntradaPC,
  output logic [31:0]Alu, extensor32bits, Address, dadoPreMux,
  output logic[5:0] Instr31_26,
  output logic[4:0] Instr25_21,
  output logic[4:0] Instr20_16,
  output logic[15:0] Instr15_0,
  output logic[5:0] Estado,
  output logic [4:0] RegDestinoSaida,
  output logic [31:0] ReadData1, ReadData2, DadoASerEscrito,
  output logic [31:0] SaidaA,
  output logic [31:0] SaidaB,
  output logic Load_ir,
  output logic PCEsc,
  output logic CtrMem,
  output logic RegWrite,
  output logic ULAFonteA,
  output logic RegDst,
  output logic RegACtrl, RegBCtrl, ULASaidaCtrl, MDRCtrl,
  output logic[1:0] ULAFonteB,
  output logic MemParaReg,
  output logic PCEscCond,
  output logic ZeroULA,
  output logic[31:0] extensorEShift,
  output logic[2:0] ULAOpSelector)
  ;
	
	/* controlador
	logic Load_ir;
	logic PCEsc;
	logic CtrMem;
	logic RegWrite;
	logic ULAFonteA;
	logic RegDst;
	logic[1:0] ULAFonteB;
	logic MemParaReg;
	*/
	
	// lixo da ula
	logic OverflowULA;
	logic NegativoULA;
	logic IgualULA;
	logic MaiorULA;
	logic MenorULA;
	
	// Saidas Mux
	// logic [4:0] RegDestinoSaida; // Instr20_16 ou Instr15_0[4:0]
	// logic [4:0] EntradaULA1;
	// logic [4:0] EntradaULA2;
	// logic [31:0] DadoASerEscrito;
	
	// Saida Banco de Registradores
	//logic [31:0] ReadData1;
	//logic [31:0] ReadData2;
	
	// Fios Memoria
	// logic [31:0]Address;
	
	//Extensor
	// logic [31:0] extensor32bits;
	
	//Fios registradores A e B
	// logic [31:0] SaidaA;
	// logic [31:0] SaidaB;	
	
	

	Registrador PCreg(.Clk(clock),
	.Reset(reset),
	.Load(PCEsc || (PCEscCond && ZeroULA)),
	.Entrada(EntradaPC),
	.Saida(PC));

	Registrador MDR(.Clk(clock),
	.Reset(reset),
	.Load(MDRCtrl),
	.Entrada(MemData),
	.Saida(dadoPreMux));
	
	Registrador ULASaida(.Clk(clock),
	.Reset(reset),
	.Load(ULASaidaCtrl),
	.Entrada(Alu),
	.Saida(AluSaida));
	
	Registrador A(.Clk(clock),
	.Reset(reset),
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
	.Maior(MaiorULA),
	.Menor(MenorULA));




	Instr_Reg inst_reg(.Clk(clock), 
	.Reset(reset), 
	.Load_ir(Load_ir), 
	.Entrada(MemData), 
	.Instr31_26(Instr31_26),
	.Instr25_21(Instr25_21),
	.Instr20_16(Instr20_16),
	.Instr15_0(Instr15_0));




	Memoria Memory(.Address(Address),
	.Clock(clock),
	.Wr(CtrMem),
	.DataIn(SaidaB),
	.DataOut(MemData));
	
	
	
	controlador ctrl(.Clock(clock),
	.OpCode(Instr31_26),
	.Reset(reset),
	.PCEsc(PCEsc),
	.CtrMem(CtrMem),
	.IREsc(Load_ir),
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
	.FontePC(FontePC));
	
	
	
	
	mux2entradas32bits RegisterWriteSelection(.controlador(RegDst), // mudar nome do modulo do registrador para mux2entradas ->5<- bits
	.entrada0(Instr20_16),
	.entrada1(Instr15_0[15:11]),
	.saidaMux(RegDestinoSaida));
	
	mux2entradas32bits_real IouDMux(.controlador(IouD), // mudar nome do modulo do registrador para mux2entradas ->5<- bits
	.entrada0(PC),
	.entrada1(AluSaida),
	.saidaMux(Address));
	
	mux2entradas32bits_real EntradaULA1Selection(.controlador(ULAFonteA), // mudar nome do modulo do registrador para mux2entradas ->5<- bits
	.entrada0(PC),
	.entrada1(SaidaA),
	.saidaMux(EntradaULA1));	
	
	mux4entradas32bits EntradaULA2Selection(.controlador(ULAFonteB), 
	.entrada0(SaidaB),
	.entrada1(32'd4),
	.entrada2(extensor32bits),
	.entrada3(extensorEShift),
	.saidaMux(EntradaULA2));
	
	mux2entradas32bits_real DadoASerEscritoSelection(.controlador(MemParaReg),
	.entrada0(AluSaida),
	.entrada1(dadoPreMux),
	.saidaMux(DadoASerEscrito));
	
	mux4entradas32bits FontePCSelection(.controlador(FontePC),  
	.entrada0(Alu),
	.entrada1(AluSaida),
	.entrada2({ PC[31:28], { Instr25_21, Instr20_16, Instr15_0, } << 2, 2'b00 }),
	.entrada3(32'd666),
	.saidaMux(EntradaPC));



	extensor16to32bits extenssor(.entrada(Instr15_0),
	.saida(extensor32bits));
	
	shiftLeft2bits shifter(.entrada(extensor32bits), .saida(extensorEShift));


	Banco_reg BancoDeRegistradores(.Clk(clock),
	.Reset(reset),
	.RegWrite(RegWrite),
	.ReadReg1(Instr25_21),
	.ReadReg2(Instr20_16),
	.WriteReg(RegDestinoSaida),
	.WriteData(DadoASerEscrito), // saida do mux ( 0 - Alu, caso op arith, ou 1 - caso acesso a memoria, caso lw)
	.ReadData1(ReadData1),
	.ReadData2(ReadData2));
	


endmodule: cpu


