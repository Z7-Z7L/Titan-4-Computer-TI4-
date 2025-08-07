// ALU
module ALU(o, flags, opcode,a,b);
  output reg [3:0] o;  
  output [7:0] flags;

  input [3:0] opcode, a,b;

  always @(*) begin
    case(opcode)
      4'b0001: o = a + b; // ADD
      4'b0010: o = a - b; // SUB
      4'b0011: o = a & b; // AND 
      4'b0100: o = a | b; // ORR
      4'b0101: o = ~(a | b); // NOR
      4'b0110: o = a ^ b; // XOR
      4'b0111: o = a >> 1; // RSH
      4'b1000: o = a << 1; // LSH
      4'b1001: o = b; // LDI
      4'b1010: o = a + b; // ADI, after the command set reg a value to `o`
      // 4'b1101: ; // CMP
      default: o = 4'b0000;
    endcase
  end

endmodule
