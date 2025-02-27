package ALU_env_pkg; 
    import  uvm_pkg::*,
            ALU_driver_pkg::*,
            ALU_scoreboard_pkg::*,
            ALU_main_sequence_pkg::*,
            ALU_reset_sequence_pkg::*,
            ALU_seq_item_pkg::*,
            ALU_sequencer_pkg::*,
            ALU_monitor_pkg::*,
            ALU_config_pkg::*,
            ALU_agent_pkg::*,
            ALU_coverage_pkg::*;
    `include "uvm_macros.svh"

    class ALU_env extends uvm_env;
        `uvm_component_utils(ALU_env)

        ALU_agent alu_agent;
        ALU_scoreboard alu_sb;
        ALU_coverage alu_cov;

        function new (string name = "ALU_env", uvm_component parent);
            super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase );
        super.build_phase (phase);
            alu_agent = ALU_agent ::type_id ::create("alu_agent",this);
            alu_sb= ALU_scoreboard ::type_id ::create("sb",this);
            alu_cov= ALU_coverage ::type_id ::create("cov",this);
        endfunction

        function void connect_phase (uvm_phase phase );
            alu_agent.agent_ap.connect(alu_sb.sb_export);
            alu_agent.agent_ap.connect(alu_cov.cov_export);
        endfunction
    endclass : ALU_env
endpackage : ALU_env_pkg