import ALU_types_pkg::*;
interface ALU_if (clk);

    input bit clk;

    logic rst;                       // Asynchronous Reset signal
    opcode_e opcode;                 // 2-bit operation code to select ALU operation
    logic signed [3:0] A, B;         // 4-bit signed inputs A and B for ALU operations
    logic signed [4:0] C;            // 5-bit signed output C from ALU operations

    // DUT modport
    modport DUT (
        input rst,clk,opcode,
        output A,B,C
    );  

endinterface : ALU_if