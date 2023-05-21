module mux_2to1(y,a,b,selector);
input a;
input b;
input selector;
output y;

wire w1;
wire w2;
wire w3;
not inverted_selector(w1,selector);

and first_and(w2,a,w1);
and second_and(w3,b,selector);
or final(y,w2,w3);

endmodule
