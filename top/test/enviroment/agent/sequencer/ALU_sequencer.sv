package ALU_sequencer_pkg;

    import uvm_pkg::*;
    import ALU_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class ALU_sequencer extends uvm_sequencer #(ALU_seq_item);

        `uvm_component_utils(ALU_sequencer);

        function new(string name = "ALU_sequence", uvm_component parent);
            super.new(name,parent);
        endfunction

    endclass : ALU_sequencer

endpackage : ALU_sequencer_pkg