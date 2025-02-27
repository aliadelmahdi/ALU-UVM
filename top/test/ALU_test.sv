package ALU_test_pkg;

    import  uvm_pkg::*,
            ALU_env_pkg::*,
            ALU_config_pkg::*,
            ALU_driver_pkg::*,
            ALU_main_sequence_pkg::*,
            ALU_reset_sequence_pkg::*,
            ALU_seq_item_pkg::*;
    `include "uvm_macros.svh"
    class ALU_test extends uvm_test;

        `uvm_component_utils(ALU_test)
        ALU_env alu_env;
        ALU_config alu_cnfg;
        virtual ALU_if alu_if;
        ALU_main_sequence alu_main_seq;
        ALU_reset_sequence alu_reset_seq;

        function new(string name = "ALU_test", uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            alu_env = ALU_env::type_id::create("env",this);
            alu_cnfg = ALU_config::type_id::create("ALU_config",this);
            alu_main_seq = ALU_main_sequence::type_id::create("main_seq",this);
            alu_reset_seq = ALU_reset_sequence::type_id::create("reset_seq",this);

            if(!uvm_config_db #(virtual ALU_if)::get(this,"","alu_if",alu_cnfg.alu_if))  
                `uvm_fatal("build_phase" , " test - Unable to get the virtual interface of the ALU form the configuration database");

            uvm_config_db # (ALU_config)::set (this , "*" , "CFG",alu_cnfg );
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);

            // Reset sequence
            `uvm_info("run_phase","stimulus Generation started",UVM_LOW)
            alu_reset_seq.start(alu_env.alu_agent.alu_seqr);
            `uvm_info("run_phase","Reset Deasserted",UVM_LOW)
            
            // Main Sequence
            `uvm_info("run_phase", "Stimulus Generation Started",UVM_LOW)
            alu_main_seq.start(alu_env.alu_agent.alu_seqr);
            `uvm_info("run_phase", "Stimulus Generation Ended",UVM_LOW) 

            phase.drop_objection(this);
        endtask
    endclass : ALU_test
endpackage : ALU_test_pkg