module CU (
  input  logic [15:0] instruction, // from IR: instruction register
  input  logic [7:0]  flags, // from FR: flag register
  output logic [3:0]  opcode,
  output logic [3:0]  operand0,
  output logic [3:0]  operand1,
  output logic [3:0]  operand2,
  output logic        reg_write,
  output logic [3:0]  alu_op,
  output logic        mem_read,
  output logic        mem_write,
  output logic        pc_inc,
  output logic        pc_load, // for jumps
  output logic [4:0]  pc_target, // target address for jmp / brh
  output logic        hlt
);

  localparam FLAG_Z  = 0; // 4'b0100 // Zero
  localparam FLAG_C  = 1; // 4'b0101 // Carry
  localparam FLAG_N  = 2; // 4'b0110 // Negative
  localparam FLAG_V  = 3; // 4'b0111 // Overflow
  localparam FLAG_EQ = 4; // 4'b1000 // Equal
  localparam FLAG_NE = 5; // 4'b1001 // Not Equal
  localparam FLAG_GT = 6; // 4'b1010 // Greater Than
  localparam FLAG_LT = 7; // 4'b1011 // Less Than

  // Decode instruction
  assign opcode = instruction[15:12];
  assign operand0 = instruction[11:8];
  assign operand1 = instruction[7:4];
  assign operand2 = instruction[3:0];
  
  always_comb begin
    reg_write = 0;
    alu_op    = 4'b0;
    mem_read  = 0;
    mem_write = 0;
    pc_inc    = 1;
    pc_load   = 0;
    pc_target = 5'b0;
    hlt       = 0;
    
    case (opcode)
      4'b0000: begin // HLT
        pc_inc = 0;
        hlt = 1;
      end
      4'b0001: begin // ADD
        alu_op = 4'b0001;
        reg_write = 1;
      end
      4'b0010: begin // SUB
        alu_op = 4'b0010;
        reg_write = 1;
      end
      4'b0011: begin // AND
        alu_op = 4'b0011;
        reg_write = 1;
      end
      4'b0100: begin // ORR
        alu_op = 4'b0100;
        reg_write = 1;
      end
      4'b0101: begin // NOR
        alu_op = 4'b0101;
        reg_write = 1;
      end
      4'b0110: begin // XOR
        alu_op = 4'b0110;
        reg_write = 1;
      end
      4'b0111: begin // RSH
        alu_op = 4'b0111;
        reg_write = 1;
      end
      4'b1000: begin // LSH
        alu_op = 4'b1000;
        reg_write = 1;
      end
      4'b1001: begin // LDI
        alu_op = 4'b1001;
        reg_write = 1;
      end
      4'b1010: begin // ADI
        alu_op = 4'b1010;
        reg_write = 1;
      end
      4'b1011: begin // JMP
        pc_inc = 0;
        pc_load = 1;
        pc_target = instruction [4:0];
      end
      4'b1100: begin // BRH
        pc_inc = 1;
        pc_load = 0; // Default no branch
        pc_target = 5'b0; // default

        unique case (operand0)
          4'b0000: if (flags[FLAG_Z]) pc_load = 1;
          4'b0001: if (flags[FLAG_C]) pc_load = 1;
          4'b0010: if (flags[FLAG_N]) pc_load = 1;
          4'b0011: if (flags[FLAG_V]) pc_load = 1;
          4'b0100: if (flags[FLAG_EQ]) pc_load = 1;
          4'b0101: if (flags[FLAG_NE]) pc_load = 1;
          4'b0110: if (flags[FLAG_GT]) pc_load = 1;
          4'b0111: if (flags[FLAG_LT]) pc_load = 1;
        endcase

        if (pc_load) begin
          pc_inc = 0;
          pc_target = instruction [4:0];
        end
      end
      4'b1101: begin // CMP
        alu_op = 4'b1101;
        reg_write = 0;
      end
      4'b1110: begin // LOD
        mem_read = 1;
        reg_write = 1;
      end
      4'b1111: begin // STR
        mem_write = 1;
      end
    endcase

  end

endmodule