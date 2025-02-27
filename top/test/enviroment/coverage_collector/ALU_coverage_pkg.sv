package ALU_coverage_pkg;
    import uvm_pkg::*;
    import ALU_driver_pkg::*,
           ALU_main_sequence_pkg::*,
           ALU_reset_sequence_pkg::*,
           ALU_seq_item_pkg::*,
           ALU_config_pkg::*,
           ALU_sequencer_pkg::*,
           ALU_monitor_pkg::*,
           ALU_config_pkg::*;
    `include "uvm_macros.svh"

    class ALU_coverage extends uvm_component;
        `uvm_component_utils(ALU_coverage)

        // Analysis Export for receiving transactions from monitors
        uvm_analysis_export #(ALU_seq_item) cov_export;

        uvm_tlm_analysis_fifo #(ALU_seq_item) cov_alu;

        ALU_seq_item seq_item_cov;

        // Covergroup definitions
        covergroup opcode_cov;
            option.per_instance = 1; // Each instance is independent.
            coverpoint seq_item_cov.opcode {
                bins add    = {2'b00};
                bins sub    = {2'b01};
                bins not_a  = {2'b10};
                bins red_or = {2'b11};
            }
        endgroup

        covergroup operand_range_cov;
            option.per_instance = 1; // Each instance is independent.
            coverpoint seq_item_cov.A {
                bins negative = {[-8:-1]};
                bins zero     = {0};
                bins positive = {[1:7]};
                bins edge_low = {-8};
                bins edge_high= {7};
            }
            coverpoint seq_item_cov.B {
                bins negative = {[-8:-1]};
                bins zero     = {0};
                bins positive = {[1:7]};
                bins edge_low = {-8};
                bins edge_high= {7};
            }
        endgroup

        // Constructor
        function new (string name = "ALU_coverage", uvm_component parent);
            super.new(name, parent);
            opcode_cov = new();
            operand_range_cov = new();
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            cov_export = new("cov_export", this);
            cov_alu = new("cov_alu", this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            cov_export.connect(cov_alu.analysis_export);
        endfunction

        // Run Phase
        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                // Get the next transaction from the analysis FIFO.
                cov_alu.get(seq_item_cov);
                opcode_cov.sample();
                operand_range_cov.sample();
            end
        endtask
    endclass : ALU_coverage

endpackage : ALU_coverage_pkg
