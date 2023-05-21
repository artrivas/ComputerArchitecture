module ThunderBird(clk,reset,Left,Right,La,Lb,Lc,Ra,Rb,Rc);
input clk,reset;
input wire Left,Right;
output reg La,Lb,Lc,Ra,Rb,Rc;
reg [2:0] current_state,next_state;
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;

endmodule

