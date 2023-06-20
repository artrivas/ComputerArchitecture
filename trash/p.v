module Seven_segment_LED_Display_Controller(
    input clk, 
    input reset, 
    input number,
    output reg [3:0] enable, 
    output reg [6:0] out
    );
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; 
    wire [1:0] LED_activating_counter; 
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
