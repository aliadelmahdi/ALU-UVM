package ALU_driver_pkg;

    import uvm_pkg::*;
    import ALU_config_pkg::*;
    import ALU_main_sequence_pkg::*;
    import ALU_reset_sequence_pkg::*;
    import ALU_seq_item_pkg::*;
    import ALU_types_pkg::*;

    `include "uvm_macros.svh"

    class ALU_driver extends uvm_driver #(ALU_seq_item);
        `uvm_component_utils(ALU_driver)
        virtual ALU_if alu_if;
        ALU_seq_item stimulus_seq_item;

        function new(string name = "ALU_driver", uvm_component parent);
            super.new(name,parent);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                stimulus_seq_item = ALU_seq_item::type_id::create("stimulus_seq_item");
                seq_item_port.get_next_item(stimulus_seq_item);

                alu_if.rst = stimulus_seq_item.rst;
                alu_if.opcode =opcode_e'(stimulus_seq_item.opcode);
                alu_if.A = stimulus_seq_item.A;
                alu_if.B = stimulus_seq_item.B;
                alu_if.C = stimulus_seq_item.C;

                @(negedge alu_if.clk)
                seq_item_port.item_done();
                `uvm_info("run_phase",stimulus_seq_item.sprint(),UVM_HIGH)
            end
        endtask
    endclass : ALU_driver

endpackage : ALU_driver_pkg