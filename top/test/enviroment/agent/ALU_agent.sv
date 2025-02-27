package ALU_agent_pkg;
    import uvm_pkg::*,
    ALU_seq_item_pkg::*,
    ALU_driver_pkg::*,
    ALU_main_sequence_pkg::*,
    ALU_reset_sequence_pkg::*,
    ALU_sequencer_pkg::*,
    ALU_monitor_pkg::*,
    ALU_config_pkg::*;
    `include "uvm_macros.svh"
 
    class ALU_agent extends uvm_agent;

        `uvm_component_utils(ALU_agent)
        ALU_sequencer alu_seqr;
        ALU_driver alu_drv;
        ALU_monitor alu_mon;
        ALU_config alu_cnfg;
        uvm_analysis_port #(ALU_seq_item) agent_ap;

        function new(string name = "ALU_agent", uvm_component parent);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            if(!uvm_config_db #(ALU_config)::get(this,"","CFG",alu_cnfg)) 
                `uvm_fatal ("build_phase","Unable to get configuration object from the database")
            
            alu_drv = ALU_driver::type_id::create("drv",this);
            alu_seqr = ALU_sequencer::type_id::create("alu_seqr",this);
            alu_mon = ALU_monitor::type_id::create("mon",this);
            agent_ap = new("agent_ap",this);
        endfunction

        function void connect_phase(uvm_phase phase);

            alu_drv.alu_if = alu_cnfg.alu_if;
            alu_mon.alu_if = alu_cnfg.alu_if;

            alu_drv.seq_item_port.connect(alu_seqr.seq_item_export);
            alu_mon.monitor_ap.connect(agent_ap);
        endfunction

    endclass : ALU_agent

endpackage : ALU_agent_pkg