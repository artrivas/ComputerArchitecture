module zvalue(y,a,b);
input a;
input b;
output y;

supply1 vdd;
supply0 gnd;

wire c1;

wire c2;

pmos p1(c1,vdd,a);
pmos p2(y,c1,b);

nmos n1(c2,gnd,a);
nmos n2(y,c2,b);

endmodule
