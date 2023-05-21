module cmosnand(y,a,b);
    input a;
    input b;
    output y;
    supply1 vdd;
    supply0 gnd;

    pmos p1(y,vdd,a);
    pmos p2(y,vdd,b);

    wire c1;

    nmos n1(y,c1,a);
    nmos n2(c1,gnd,b);

endmodule
