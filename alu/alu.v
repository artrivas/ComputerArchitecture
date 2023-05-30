module alu(a,b,ALUControl,ALUFlags, out,enable,clk,reset, Result);
//Input and outputs
input [4:0] a,b;
input [1:0] ALUControl;
output wire [3:0] ALUFlags;
output reg[7:0] out;
output reg[3:0] enable;
output reg [8:0] Result; //Resultado de 8 bits, 1 bit para el signo y los 4 bits para la suma de los numeros

//Wire and reg
wire  neg,zero,carry,overflow;
wire [9:0] sum; //Un bit adicional para el overflow

//BCD output
input clk, reset;
reg [19:0] refresh_counter;
wire [1:0] LED_activating_counter;
reg [4:0] LED_BCD;

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

assign neg      = Result[8];
assign zero     = Result == 0;
assign carry    = ~ALUControl[1] & sum[9];
assign overflow = ~ALUControl[1] & ~(a[4] ^ b[4] ^ ALUControl[0]) & (a[4] ^ sum[8]);

assign ALUFlags = {neg, zero, carry, overflow};

always @(posedge clk or posedge reset)
begin 
    if(reset==1)
        refresh_counter <= 0;
    else
        refresh_counter <= refresh_counter + 1;
end 
assign LED_activating_counter = refresh_counter[19:18];

always @(*)
begin
    case(LED_activating_counter)
    2'b00: begin //First digit
        enable = 4'b0111; 
        LED_BCD[4] = Result[8];
        LED_BCD[3:0] = Result[7:4];
          end
    2'b01: begin //Second digit
        enable = 4'b1011; 
        LED_BCD[3:0] = Result[3:0];
        LED_BCD[4] = 0;
          end
    2'b10: begin //a
        enable = 4'b1101; 
        LED_BCD = a;
            end
    2'b11: begin //b
        enable = 4'b1110; 
        LED_BCD = b;
        end
    endcase
end

always @(*)
begin
    out[7] <= LED_BCD[4];
    case(LED_BCD[3:0])
        4'b0000 : out[6:0] <=7'b0000001;    //Display 0
        4'b0001 : out[6:0] <=7'b1001111;    //Display 1
        4'b0010 : out[6:0]<=7'b0010010;    //Display 2
        4'b0011 : out[6:0]<=7'b0000110;    //Display 3
        4'b0100 : out[6:0]<=7'b1001100;    //Display 4
        4'b0101 : out[6:0]<=7'b0100100;    //Display 5
        4'b0110 : out[6:0]<=7'b0100000;    //Display 6
        4'b0111 : out[6:0]<=7'b0001111;    //Display 7
        4'b1000 : out[6:0]<=7'b0000000;    //Display 8
        4'b1001 : out[6:0]<=7'b0001100;    //Display 9
        4'b1010 : out[6:0]<=7'b0001000;    //Display A
        4'b1011 : out[6:0]<=7'b1100000;    //Display b
        4'b1100 : out[6:0]<=7'b0110001;    //Display C
        4'b1101 : out[6:0]<=7'b1000010;    //Display d
        4'b1110 : out[6:0]<=7'b0110000;    //Display E
        4'b1111 : out[6:0]<=7'b0111000;    //Display F
        default: out = 8'b00000001; // "0"
    endcase
end


endmodule
