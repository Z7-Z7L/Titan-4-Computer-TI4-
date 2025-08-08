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

  // For GTKWave
  initial begin
    $dumpfile("alu_test.vcd");
    $dumpvars(0, ALU_tb);
  end

  initial begin
    opcode = 4'b0000;
    a = 4'b0000;
    b = 4'b0000;

    
  end
  
endmodule