module stimulus();

  logic [4:0] Y;
  logic [7:0] X;
  logic [11:0] Z;

  logic [4:0] num2;
  logic [7:0] num1;
  logic [11:0] answer;
  logic clk;

  //for five vector numbers we need 3 bits
  logic [2:0] vectornum, errors;

  //the testvector file should be 27 bits wide
  logic [26:0] testVector[5:0];


  // Instantiate DUT
  CSAM dut(Z, X, Y);

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
      {num1, num2, answer} = testVector[vectornum];
    end

  always @(negedge clk)
    begin
    if(Z !== answer) begin
      $display("Error: inputs for test X = %b Y = %b", X, Y);
      $display("  outputs = %b (%b expected)", Z, answer);
      $display("");
      errors = errors + 1;
    end

    vectornum = vectornum + 1;
    if(vectornum === 16) begin
      $display("%d tests completed with %d errors", vectornum, errors);
    end
  end
endmodule
