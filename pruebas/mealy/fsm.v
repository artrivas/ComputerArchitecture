module fsm(clk, reset, x,y);
input clk,reset,x;
output reg y;
reg [1:0] current,next;
parameter S0 = 0; //a
parameter S1 = 1; //b
parameter S2 = 2; //c
parameter S3 = 3; //d
always @(posedge clk, posedge reset)
begin
    if(reset)
        current <= S0;
    else
        current <= next;
end

always @(current,x)
begin
    next = current;
    case (current)
        S0: begin
            if(x == 0) begin
                y = 1;
                next = S2; 
            end
            else if(x == 1) begin
                y = 0;
                next = S1;
            end
        end
        S1: begin
            if(x == 0) begin
                y = 0;
                next = S2; 
            end
            else if(x == 1) begin
                y = 1;
                next = S3;
            end
        end
        S2: begin
            if(x == 0) begin
                y = 0;
                next = S1; 
            end
            else if(x == 1) begin
                y = 1;
                next = S3;
            end
        end
        S3: begin
            if(x == 0) begin
                y = 1;
                next = S0; 
            end
            else if(x == 1) begin
                y = 0;
                next = S2;
            end
        end
    endcase
end

endmodule
