module fsm(
    input clk,reset,
    input wire up,down,
    output reg [6:0] number);

reg current_state,next_state;

reg [6:0] counter; // HOLDS THE COUNT

reg up_prev,down_prev,reset_prev;

parameter S0 = 1'b0;
parameter S1 = 1'b1;

//STORE VALUES
always @(posedge up, posedge down)
begin
    up_prev <= up;
    down_prev <= down;
end

always @(negedge clk,posedge reset)
begin
    if(reset)
    begin
        current_state <= S0;
        counter = -1;
    end
    else
        current_state <= next_state;
end

//INPUT LOGIC
//up -> negedge up
//down -> negedge down
//button released -> negedge clk
always @(negedge up, negedge down, current_state, negedge clk) //Depends on current_state and inputs
begin
    next_state = current_state;
    case (current_state)
        S0:begin
            if(~down && down_prev)
            begin
                next_state = S1;
            end
        end
        S1:begin
            if(~up && up_prev)
            begin
                next_state = S0;
            end
        end
    endcase
end

//OUTPUT LOGIC
always @(negedge clk)
begin
    case (current_state)
        S0:begin
            if(~down && down_prev)
            begin
                counter = (counter <= 0 ? 100:counter -1);
                number = counter;
            end
            else
            begin
                if(counter >= 100)
                    counter = -1;
                counter = counter + 1;
                number = counter;
            end
        end
        S1: begin
            if(~up && up_prev)
            begin
                counter = (counter >= 100 ? 0:counter +1);
                number = counter;
            end
            else
            begin
                if(counter <=1)
                begin
                    counter = 101;
                end
                    counter = counter -1;
                    number = counter;
            end
        end
    endcase
end
endmodule

