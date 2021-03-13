module stimulus();

  logic [4:0] Y;
  logic [7:0] X;
  logic [11:0] Z;
  logic clk;

  // Instantiate DUT
  CSAM dut(A, B, A_eq_B, A_lt_B, A_gt_B);

  always
    begin
      #5 clk = 0;
      #5 clk = 1;
    end

  initial
    begin
      $readmemb("testvector.tv", testVector);
      vectornum = 0; errors = 0;
    end

  always @(posedge clk)
    begin
      #1;
      {A, B, AGTBE, AEQBE, ALTBE} = testVector[vectornum];
    end

  always @(negedge clk)
    begin
    if(A_eq_B !== AEQBE) begin
      $display("Error: inputs for EQ test A = %b B = %b", A, B);
      $display("  outputs = %b (%b expected)", A_eq_B, AEQBE);
      $display("");
      errors = errors + 1;
    end

    if(A_lt_B !== ALTBE) begin
      $display("Error: inputs for LT test A = %b B = %b", A, B);
      $display("  outputs = %b (%b expected)", A_lt_B, ALTBE);
      $display("");
      errors = errors + 1;
    end

    if(A_gt_B !== AGTBE) begin
      $display("Error: inputs for GT test A = %b B = %b", A, B);
      $display("  outputs = %b (%b expected)", A_gt_B, AGTBE);
      $display("");
      errors = errors + 1;
    end

    vectornum = vectornum + 1;
    if(vectornum === 16) begin
      $display("%d tests completed with %d errors", vectornum, errors);
    end
  end
endmodule
