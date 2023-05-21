module mux_2to1_b(y,a,b,c);
input a;
input b;
input c;
output y;
assign y = (a&~c) | (b&c);
endmodule
