module zvalue_tb;
reg a;
reg b;
wire y;
zvalue zvalue_tb(y,a,b);
initial begin
    a = 0;
    b = 0;
    #1 a= 0;
    b= 1;
    #1 a = 1;
    b = 0;
    #1 a=1;
    b = 1;
    #1 $finish;
end
initial begin
    $monitor("%2d:\ta = %b\t b = %b \t y = %b\n",$time,a,b,y);
end
endmodule
