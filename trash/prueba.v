module dff(
input D,
input clk,
input reset,
output reg Q
);
always @ (posedge(clk), posedge(reset))
begin
if (reset == 1)
Q <= 1'b0;
else
Q <= D;
end
endmodule

module clk_divider(
input clk,
input reset,
output clk_en
);
wire [27:0] din;
wire [27:0] clkdiv;
dff dff_inst0 (
.clk(clk),
.reset(reset),
.D(din[0]),
.Q(clkdiv[0])
);
genvar i;
generate
for (i = 1; i < 27; i=i+1)
begin : dff_gen_label
dff dff_inst (
.clk(clkdiv[i-1]),
.reset(reset),
.D(din[i]),
.Q(clkdiv[i])
);
end
endgenerate
assign din = ~clkdiv;
assign clk_en = clkdiv[26];
endmodule




module counter(clk,reset,up,down,salida,increasevalue,out,enable);
input [3:0] increasevalue;
input clk,reset,up,down;
output reg [3:0] enable;
output reg [6:0] out;
output wire [6:0] salida;
wire clk_en;
reg [6:0] number;

reg [3:0] LED_BCD;
reg [19:0] refresh_counter; 
wire [1:0] LED_activating_counter; 


reg [2:0] current_state,next_state;
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;

clk_divider clk_enable(clk,reset,clk_en);
always @(posedge clk_en, posedge reset)begin
    if(reset) begin
        current_state <= S0;
    end
    else
        current_state <= next_state;
end

always @(current_state, up, down)
begin
    next_state = current_state;
    case(current_state)
        S0: begin
            if(up)begin
                next_state = S1;
            end
            else if(down) begin
                next_state = S3;
            end
        end
        S1: begin
            if(~up)begin
                next_state = S2;
            end
            else if(down) begin
                next_state = S3;
            end
        end
        S2: begin
            if(up) begin
                next_state = S1;
            end
            else if(down)begin
                next_state = S3;
            end
            else
                next_state = S5;
        end
        S3: begin
            if(~down) begin
                next_state = S4;
            end
            else if(up) begin
                next_state = S1;
            end
        end
        S4: begin
            if(down) begin
                next_state = S3;
            end
            else if(up) begin
                next_state = S1;
            end
            else
                next_state = S6;
        end
        S5:begin
            if(up) begin
                next_state = S1;
            end
            else if(down) begin
                next_state = S3;
            end
            else
                next_state = S2;
        end
        S6:
            if(up)begin
                next_state = S1;
            end
            else if(down)begin
                next_state = S3;
            end
            else
                next_state = S4;

        default: next_state = S0;
    endcase
end


always @(posedge clk_en)
begin
    case(current_state)
        S0:begin
            number <= 0;
        end
        S1: begin
            if(~up)begin
                number <= (number+increasevalue > 100 ? 0: number + increasevalue);
            end
        end
        S2: begin
            if(~up) begin
                number <= (number+increasevalue > 100 ? 0: number + increasevalue);
            end
        end
        S3: begin
            if(~down) begin
                number <= (number-increasevalue > 100 ? 100:number -increasevalue);
            end
        end
        S4: begin
            if(~down) begin
                number <= (number-increasevalue > 100 ? 100:number -increasevalue);
            end
        end
        S5:begin
            if(~up) begin
                number <= (number+increasevalue > 100 ? 0: number + increasevalue);
            end
        end
        S6:begin
            if(~down) begin
                number <= (number- increasevalue> 100 ? 100:number -increasevalue);
            end
        end
    endcase
end

assign salida = number;

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
        2'b10: begin
            enable = 4'b1101; 
            LED_BCD = ((number % 4096)%256)/16;
        end
        2'b11: begin
            enable = 4'b1110; 
            LED_BCD = ((number % 4096)%256)%16;
        end
        endcase
    end
    always @(*)
    begin
        case(LED_BCD)
            4'b0000 : out<=7'b0000001;    //Display 0
            4'b0001 : out<=7'b1001111;    //Display 1
            4'b0010 : out<=7'b0010010;    //Display 2
            4'b0011 : out<=7'b0000110;    //Display 3
            4'b0100 : out<=7'b1001100;    //Display 4
            4'b0101 : out<=7'b0100100;    //Display 5
            4'b0110 : out<=7'b0100000;    //Display 6
            4'b0111 : out<=7'b0001111;    //Display 7
            4'b1000 : out<=7'b0000000;    //Display 8
            4'b1001 : out<=7'b0001100;    //Display 9
            4'b1010 : out<=7'b0001000;    //Display A
            4'b1011 : out<=7'b1100000;    //Display b
            4'b1100 : out<=7'b0110001;    //Display C
            4'b1101 : out<=7'b1000010;    //Display d
            4'b1110 : out<=7'b0110000;    //Display E
            4'b1111 : out<=7'b0111000;    //Display F
        endcase
    end

endmodule

