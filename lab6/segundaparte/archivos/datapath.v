module datapath (
	clk,
	reset,
	Adr,
	WriteData,
	ReadData,
	Instr,
	ALUFlags,
	PCWrite,
	RegWrite,
	IRWrite,
	AdrSrc,
	RegSrc,
	ALUSrcA,
	ALUSrcB,
	ResultSrc,
	ImmSrc,
	ALUControl
);
	input wire clk;
	input wire reset;
	output wire [31:0] Adr;
	output wire [31:0] WriteData;
	input wire [31:0] ReadData;
	output wire [31:0] Instr;
	output wire [3:0] ALUFlags;
	input wire PCWrite;
	input wire RegWrite;
	input wire IRWrite;
	input wire AdrSrc;
	input wire [1:0] RegSrc;
	input wire [1:0] ALUSrcA;
	input wire [1:0] ALUSrcB;
	input wire [1:0] ResultSrc;
	input wire [1:0] ImmSrc;
	input wire [1:0] ALUControl;
	wire [31:0] PCNext;
	wire [31:0] PC;
	wire [31:0] ExtImm;
	wire [31:0] SrcA;
	wire [31:0] SrcB;
	wire [31:0] Result;
	wire [31:0] Data;
	wire [31:0] RD1;
	wire [31:0] RD2;
	wire [31:0] A;
	wire [31:0] ALUResult;
	wire [31:0] ALUOut;
	wire [3:0] RA1;
	wire [3:0] RA2;

	parameter reg15 = 4'b1111;
	parameter const4 = 4;
	

	flopenr #(32) PCreg(
		.clk(clk),
		.reset(reset),
		.en(PCWrite),
		.d(Result),
		.q(PC)
	);

	mux2 #(32) ADRmux(
		.d0(PC),
		.d1(Result),
		.s(AdrSrc),
		.y(Adr)
	);

	flopenr #(32) REGinstr(
		.clk(clk),
		.reset(reset),
		.en(IRWrite),
		.d(ReadData),
		.q(Instr)
	);
	flopr #(32) REGdata(
		.clk(clk),
		.reset(reset),
		.d(ReadData),
		.q(Data)
	);
	
	mux2 #(4) RA1mux(
		.d0(Instr[19:16]),
		.d1(reg15),
		.s(RegSrc[0]),
		.y(RA1)
	);
	mux2 #(4) RA2mux(
		.d0(Instr[3:0]),
		.d1(Instr[15:12]),
		.s(RegSrc[1]),
		.y(RA2)
	);
	extend BloqueExtend(
		.Instr(Instr[23:0]),
		.ImmSrc(ImmSrc),
		.ExtImm(ExtImm)
	);
	regfile RegisterFile(
		.clk(clk),
		.we3(RegWrite),
		.ra1(RA1),
		.ra2(RA2),
		.wa3(Instr[15:12]),
		.wd3(Result),
		.r15(Result),
		.rd1(RD1),
		.rd2(RD2)
	);
	flopr #(32) RegisterA1(
		.clk(clk),
		.reset(reset),
		.d(RD1),
		.q(A)
	);
	flopr #(32) RegisterA0(
		.clk(clk),
		.reset(reset),
		.d(RD2),
		.q(WriteData)
	);
	mux3 #(32) SrcAmux(
		.d0(A),
		.d1(PC),
		.d2(ALUOut),
		.s(ALUSrcA),
		.y(SrcA)
	);
	mux3 #(32) SrcBmux(
		.d0(WriteData),
		.d1(ExtImm),
		.d2(const4),
		.s(ALUSrcB),
		.y(SrcB)
	);
	alu BloqueAlu(
		.SrcA(SrcA),
		.SrcB(SrcB),
		.ALUControl(ALUControl),
		.ALUResult(ALUResult),
		.ALUFlags(ALUFlags)
	);
	flopr #(32) ALUOUTreg(
		.clk(clk),
		.reset(reset),
		.d(ALUResult),
		.q(ALUOut)
	);
	mux3 #(32) ResultMux(
		.d0(ALUOut),
		.d1(Data),
		.d2(ALUResult),
		.s(ResultSrc),
		.y(Result)
	);
endmodule