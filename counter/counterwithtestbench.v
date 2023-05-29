module counter(clk,reset,up,down,salida);
input clk,reset,up,down;
output wire [6:0] salida;
reg [6:0] number;
reg [2:0] current_state,next_state;
parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;
parameter S5 = 3'b101;
parameter S6 = 3'b110;

always @(posedge clk, posedge reset)begin
    if(reset) begin
        current_state <= S0;
    end
    else
        current_state <= next_state;
end

always @(current_state,up, down)
begin
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
        S3: begin
            if(~down) begin
                next_state = S4;
            end
            else if(up) begin
                next_state = S1;
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


always @(posedge clk)
begin
    case(current_state)
        S0:begin
            number <= 0;
        end
        S1: begin
            if(~up)begin
                number <= (number+1 > 100 ? 0: number + 1);
            end
        end
        S2: begin
            if(~up) begin
                number <= (number+1 > 100 ? 0: number + 1);
            end
        end
        S3: begin
            if(~down) begin
                number <= (number-1 > 100 ? 100:number -1);
            end
        end
        S4: begin
            if(~down) begin
                number <= (number-1 > 100 ? 100:number -1);
            end
        end
        S5:begin
            if(~up) begin
                number <= (number+1 > 100 ? 0: number + 1);
            end
        end
        S6:begin
            if(~down) begin
                number <= (number- 1> 100 ? 100:number -1);
            end
        end
    endcase
end

assign salida = number;

endmodule


module test_bench;
reg up,down,clk,reset;
wire [6:0] number;
counter instancia(clk,reset,up,down,number);
initial begin
    clk = 0; reset = 1;up = 0; down = 0; 
    #1 clk = 1; reset = 1; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 1; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 1; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;
    #1 clk = 1; reset = 0; up = 0; down = 0;
    #1 clk = 0; reset = 0; up = 0; down = 0;



    $finish;
end

initial begin
$dumpfile("ala.vcd"); 
$dumpvars;
end

endmodule
