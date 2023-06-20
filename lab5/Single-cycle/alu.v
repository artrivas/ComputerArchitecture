module alu(a,b,ALUControl,ALUFlags,Result);
//Input and outputs
input [31:0] a,b;
input [1:0] ALUControl;
output wire [3:0] ALUFlags;
output reg [31:0] Result; //Resultado de 8 bits, 1 bit para el signo y los 4 bits para la suma de los numeros

//Wire and reg
wire  neg,zero,carry,overflow;
wire [32:0] sum; //Un bit adicional para el overflow

assign sum = a + (ALUControl[0] ? (~b+1): b ); 

always @(*)
begin
    case(ALUControl)
        2'b00: Result  = sum;
        2'b01: Result  = sum;
        2'b10: Result = a&b;
        2'b11: Result = a | b;
    endcase
end

assign neg      = Result[31];
assign zero     = Result == 0;
assign carry    = ~ALUControl[1] & sum[32];
assign overflow = ~ALUControl[1] & ~(a[31] ^ b[31] ^ ALUControl[0]) & (a[31] ^ sum[31]);

assign ALUFlags = {neg, zero, carry, overflow};

endmodule
