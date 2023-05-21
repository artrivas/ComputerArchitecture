module cmosnor(y,a,b);
    input a;
    input b;
    output y;
    supply1 vdd;
    supply0 gnd;
    wire c1;

    pmos p1(c1,vdd,a);
    pmos p2(y,c1,b);

    nmos n1(y,gnd,a);
    nmos n2(y,gnd,b);
endmodule
