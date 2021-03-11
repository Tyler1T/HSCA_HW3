module fullAdder(input logic A, B, Cin output logic S, Cout);
  wire toOr1, toOr2, aNext;
  halfAdder first(A, B, aNext, toOr1);
  halfAdder second(aNext, Cin, S, toOr2);
  assign Cout = toOr1 | toOr2
endmodule
