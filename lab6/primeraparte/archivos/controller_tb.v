`timescale 1ns/1ns

module controller_tb;
  reg clk;
  reg reset;
  reg [31:12] Instr;
  reg [3:0] ALUFlags;
  wire PCWrite;
  wire MemWrite;
  wire RegWrite;
  wire IRWrite;
  wire AdrSrc;
  wire [1:0] RegSrc;
  wire [1:0] ALUSrcA;
  wire [1:0] ALUSrcB;
  wire [1:0] ResultSrc;
  wire [1:0] ImmSrc;
  wire [1:0] ALUControl;
  
  reg [31:0] RAM [63:0]; // Para leer el memfile.dat
  reg [31:0] a;
  
  controller dut (
    .clk(clk),
    .reset(reset),
    .Instr(Instr),
    .ALUFlags(ALUFlags),
    .PCWrite(PCWrite),
    .MemWrite(MemWrite),
    .RegWrite(RegWrite),
    .IRWrite(IRWrite),
    .AdrSrc(AdrSrc),
    .RegSrc(RegSrc),
    .ALUSrcA(ALUSrcA),
    .ALUSrcB(ALUSrcB),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl)
  );
  
  always begin
    clk <= 0;
    #(5);
    clk <= 1;
    #(5);
  end
  
  initial begin
    $readmemh("memfile.dat", RAM);
    a = 0;
    ALUFlags = 4'b0000; // empieza sin activar ningun flag
    reset = 1;
    #5; reset = 0;
  end
  
  always @(posedge clk) begin
    if(~reset & IRWrite) begin
        if (RAM[a] == 0)
            $finish;
        Instr = RAM[a][31:12];
        if (Instr == 20'b11100010010100100011)
            ALUFlags = 4'b0110;
        a = a+1; // me sirve para recorrer las instrucciones en el memfile.dat
    end
  end

  initial begin
    $dumpfile("controller_tb.vcd");
    $dumpvars;
  end
endmodule