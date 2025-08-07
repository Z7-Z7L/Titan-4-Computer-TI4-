module ALU_tb();
  // Inputs
  reg [3:0] opcode, a,b;

  // Outputs
  wire [3:0] o;
  wire [7:0] flags;

  ALU _alu (
    .o(o),
    .flags(flags),
    .opcode(opcode),
    .a(a),
    .b(b)
  );

  initial begin
    opcode = 4'b0000;
    a = 4'b0000;
    b = 4'b0000;

    // Monitor changes
    $monitor("opcode = %b, a = %d, b = %d | o = %d (bin: %b), flags = %b", 
             opcode, a, b, o, o, flags);
    
    // ADD Test
    opcode = 4'b0001;
    a = 4'b0001;
    b = 4'b0001;
    #10;

    // SUB Test
    opcode = 4'b0010;
    a = 4'b0010;
    b = 4'b0001;
    #10;

    // AND Test
    opcode = 4'b0011;
    a = 4'b1010;
    b = 4'b0110;
    #10;

    // ORR Test
    opcode = 4'b0100;
    a = 4'b1010;
    b = 4'b0110;
    #10;

    // NOR Test
    opcode = 4'b0101;
    a = 4'b1010;
    b = 4'b0110;
    #10;

    // XOR Test
    opcode = 4'b0110;
    a = 4'b1010;
    b = 4'b0110;
    #10;

    // RSH Test
    opcode = 4'b0111;
    a = 4'b0010;
    #10;

    // LSH Test
    opcode = 4'b1000;
    a = 4'b0010;

    #10;

  end
  
endmodule