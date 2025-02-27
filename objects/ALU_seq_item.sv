package ALU_seq_item_pkg;

import uvm_pkg::*;
import ALU_types_pkg::*;
`include "uvm_macros.svh"
 
    class ALU_seq_item extends uvm_sequence_item;

        `uvm_object_utils(ALU_seq_item)
        rand bit rst;
        rand opcode_e opcode;
        rand logic signed [3:0] A,B;
        logic signed [4:0] C;
        function new(string name = "ALU_seq_item");
            super.new(name);
        endfunction

        constraint rst_cons {
            rst dist {
                0:= 97,
                1:= 3
            };
        }
    endclass : ALU_seq_item

endpackage : ALU_seq_item_pkg