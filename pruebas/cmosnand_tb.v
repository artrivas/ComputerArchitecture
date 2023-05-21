module cmosnand_tb;
    reg a;
    reg b;
    wire y;
    cmosnand cmos_nand (y,a,b);
    initial begin
        a = 0;
        b = 0;
        #1 a = 0;
        b = 1;
        #1 a = 1;
        b = 0;
        #1 a = 1;
        b = 1;
        #1 $finish;
    end
    initial begin
        $monitor("%2d:\ta = %b\tb = %b\ty = %b",$time,a,b,y);
    end
endmodule
