package ALU_types_pkg;
    typedef enum bit [1:0] {
        ADD = 2'b00,                    
        SUB = 2'b01,                    
        NOT_A = 2'b10,                  
        REDUCTIONOR_B = 2'b11
    } opcode_e; 
endpackage : ALU_types_pkg
