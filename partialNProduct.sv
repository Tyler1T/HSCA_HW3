module partialNProduct(output logic P, input logic A, B);
  assign P = !(A & B);
endmodule
