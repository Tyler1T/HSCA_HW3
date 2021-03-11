module halfAdder(input logic A, B, output logic S, Cout);
  wire n;
  assign Cout = A & B;
  assign n = A & B;
  assign S = (A | B) & ~n;
endmodule
