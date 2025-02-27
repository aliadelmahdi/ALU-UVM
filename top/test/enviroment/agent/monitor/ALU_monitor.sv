package ALU_monitor_pkg;

    import uvm_pkg::*;
    import ALU_seq_item_pkg::*;
    import ALU_types_pkg::*;

    `include "uvm_macros.svh"

    class ALU_monitor extends uvm_monitor;

        `uvm_component_utils (ALU_monitor)
        virtual ALU_if alu_if;
        ALU_seq_item response_seq_item;
        uvm_analysis_port #(ALU_seq_item) monitor_ap;

        function new(string name = "ALU_monitor",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            monitor_ap = new ("monitor_ap",this);
        endfunction

        // Run Phase
        task run_phase (uvm_phase phase);
            super.run_phase(phase);
            forever begin
                response_seq_item = ALU_seq_item::type_id::create("response_seq_item");
                @(negedge alu_if.clk);
                response_seq_item.rst = alu_if.rst;
                response_seq_item.opcode = alu_if.opcode;
                response_seq_item.A = alu_if.A;
                response_seq_item.B = alu_if.B;
                response_seq_item.C = alu_if.C;
                
                monitor_ap.write(response_seq_item);
                `uvm_info("run_phase", response_seq_item.sprint(), UVM_HIGH)
            end

        endtask
    endclass : ALU_monitor

endpackage : ALU_monitor_pkg