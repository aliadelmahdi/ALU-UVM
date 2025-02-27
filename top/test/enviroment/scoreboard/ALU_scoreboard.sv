package ALU_scoreboard_pkg;
    import uvm_pkg::*;
    import ALU_seq_item_pkg::*;
    import ALU_types_pkg::*;
    `include "uvm_macros.svh"
    class ALU_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(ALU_scoreboard)
        uvm_analysis_export #(ALU_seq_item) sb_export;
        uvm_tlm_analysis_fifo #(ALU_seq_item) sb_alu;
        ALU_seq_item seq_item_sb;

        logic signed [4:0] C_ref;
        int error_count = 0, correct_count = 0;

        function new(string name = "ALU_scoreboard",uvm_component parent);
            super.new(name,parent);
        endfunction

        // Build Phase
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            sb_export = new("sb_export",this);
            sb_alu=new("sb_alu",this);
        endfunction

        // Connect Phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            sb_export.connect(sb_alu.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sb_alu.get(seq_item_sb);
                check_results(seq_item_sb);
            end
        endtask

        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase",$sformatf("At time %0t: Simulation Ends and Error count= %0d, Correct count = %0d",$time,error_count,correct_count),UVM_MEDIUM);
        endfunction

        function void check_results(ALU_seq_item seq_item_ch);
            golden_model(seq_item_ch);
            if (seq_item_ch.C != C_ref) begin
                error_count++;
                `uvm_error("run_phase","Comparison Error between the golden model and the DUT")
            end
            else
                correct_count++;
        endfunction

        function void golden_model(ALU_seq_item seq_item_chk);
            if(seq_item_chk.rst)
                C_ref = 0;
            else begin
                case(seq_item_chk.opcode) 
                    ADD: C_ref = seq_item_chk.A + seq_item_chk.B;
                    SUB: C_ref = seq_item_chk.A - seq_item_chk.B;
                    NOT_A: C_ref = ~seq_item_chk.A;
                    REDUCTIONOR_B: C_ref = |seq_item_chk.B;
                    default: C_ref = 5'bx;             
                endcase
            end
        endfunction

    endclass : ALU_scoreboard
endpackage : ALU_scoreboard_pkg