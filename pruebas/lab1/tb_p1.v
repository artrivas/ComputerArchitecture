module tb_mux_2to1;
reg a;
reg b;
reg c; //selector
wire y;
mux_2to1 mux(y,a,b,c);
initial begin
    a = 0; b = 0; c = 0;
    #1
    a = 0; b = 0; c = 1;
    #1
    a = 0; b = 1; c = 0;
    #1
    a = 0; b = 1; c = 1;
    #1
    a = 1; b = 0; c = 0;
    #1
    a = 1; b = 0; c = 1;
    #1
    a = 1; b = 1; c = 0;
    #1
    a = 1; b = 1; c = 1;
    #1
    $finish;
end
initial begin
    $monitor("%2d:\ta = %b\t b = %b \t selector = %b\t y = %b\n",$time,a,b,c,y);
end
initial begin
    $dumpfile("p1.vcd");
    $dumpvars;
end
endmodule
