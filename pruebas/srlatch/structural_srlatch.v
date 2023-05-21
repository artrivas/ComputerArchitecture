module srlatch_structural(Q, Qn, S, R);
input S,R;
output Q,Qn;

nor n1(Q,R,Qn);
nor n2(Qn,S,Q);

endmodule

module test_bench;
reg s,r;
wire Q,Qn;
srlatch_structural gate(Q,Qn,s,r);
initial begin
   s = 0; r = 0;
   #1
   s = 0; r = 1;
   #1
   s = 1; r = 0;
   #1
   s = 1; r = 1;
   #1
   $finish;
end
initial begin
    $monitor("%2d:\ts = %b\tr=%b\tQ = %b\tQn = %b",$time,s,r,Q,Qn);
end
endmodule

