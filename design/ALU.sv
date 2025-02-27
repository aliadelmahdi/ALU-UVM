module ALU(ALU_if.DUT alu_if );
 
    logic rst;                        // Asynchronous Reset signal
    logic clk;                        // Clock signal
    logic [1:0] opcode;               // 2-bit operation code to select ALU operation
    logic signed [3:0] A, B;          // 4-bit signed inputs A and B for ALU operations
    logic signed [4:0] C;             // 5-bit signed output C from ALU operations

    // Define operation codes using local parameters
    localparam ADD = 2'b00;           // Code for addition operation
    localparam SUB = 2'b01;           // Code for subtraction operation
    localparam NOT_A = 2'b10;         // Code for logical NOT operation on A
    localparam REDUCTIONOR_B = 2'b11; // Code for bitwise reduction OR on B

    assign clk = alu_if.clk;
    assign rst = alu_if.rst;
    assign opcode = alu_if.opcode;
    assign A = alu_if.A;
    assign B = alu_if.B;

    assign alu_if.C = C;

    reg signed [4:0] alu_out;       

    // Combinational logic block to perform ALU operations based on opcode
    always @(*) begin
        case(opcode) 
            ADD: alu_out = A + B;                      // Perform addition
            SUB: alu_out = A - B;                      // Perform subtraction
            NOT_A: alu_out = ~A;                       // Perform logical NOT on A
            REDUCTIONOR_B: alu_out = |B;               // Perform bitwise reduction OR on B
            default: alu_out = 5'bx;                   // Default case to avoid latch inference
        endcase
    end

    // Sequential logic block to update output C on clock edge or reset
    always @(posedge clk or posedge rst) begin     
        if (rst) 
            C <= 5'b0;                                // Reset output C to zero on reset signal
        else
            C <= alu_out;                             // Update output C with ALU result
    end


    // Reset Assertion
    reset_assert: assert property (@(posedge clk) disable iff(!rst) (rst |=> C == 5'b0));

    // Cover all ALU operations
    cover_add: cover property (@(posedge clk) (opcode == ADD)); 
    cover_sub: cover property (@(posedge clk) (opcode == SUB)); 
    cover_notA: cover property (@(posedge clk) (opcode == NOT_A)); 
    cover_redorB: cover property (@(posedge clk) (opcode == REDUCTIONOR_B)); 

    // Cover scenarios when ALU is active
    cover_nonzero_A: cover property (@(posedge clk) (A != 4'b0000));
    cover_nonzero_B: cover property (@(posedge clk) (B != 4'b0000));

    // Cover Reset Behavior
    cover_reset: cover property (@(posedge clk) (rst) |=> (C == 5'b0));

    // Cover all possible input values for A and B
    cover_all_A_values: cover property (@(posedge clk) $onehot(A));
    cover_all_B_values: cover property (@(posedge clk) $onehot(B));


endmodule : ALU
