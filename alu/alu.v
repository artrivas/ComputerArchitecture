module alu(a,b,ALUControl, Result, ALUFlags);
input [3:0] a,b;
input [2:0] ALUControl;
output reg [7:0] Result;
output wire [3:0] ALUFlags;
wire  neg,zero,carry,overflow;
wire [8:0] sum;

assign sum = a + (ALUControl[0] ? (~b+1): b ); //Motivos didactivos, se podria hacer de frente en Result = efajew;

always @(*)
begin
    case(ALUControl)
        2'b0?: Result  = sum;
        2'b10: Result = a&b;
        2'b11: Result = a | b;
    endcase
end

assign neg      = Result[7];
assign zero     = ~Result;
assign carry    = ~ALUControl[1] & sum[8];
assign overflow = (~(ALUControl[0] ^ a[3] ^ b[3])) & 
                  (a[3] ^ sum[3]) &
                  (~ALUControl[1]);

assign ALUFlags = {neg, zero, carry, overflow};

endmodule



