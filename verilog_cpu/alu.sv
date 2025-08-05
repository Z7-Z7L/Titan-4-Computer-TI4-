// ALU
module ALU(o, flag, opcode,a,b);
  output [3:0] o;  
  output [7:0] flag;

  input [3:0] opcode, a,b;

  case(opcode)
    4'b0001; // ADD
    4'b0010; // SUB
    4'b0011; // AND 
    4'b0100; // ORR
    4'b0101; // NOR
    4'b0110; // XOR
    4'b0111; // RSH
    4'b1000; // LSH
    4'b1001; // LDI
    4'b1010; // ADI
    4'b1101; // CMP



  endcase;

endmodule
