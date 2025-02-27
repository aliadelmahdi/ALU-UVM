module tb_top;

    import uvm_pkg::*;
    import ALU_env_pkg::*;
    import ALU_test_pkg::*;

    bit clk;

    // Clock Generation
    initial begin
        clk = 0;
        forever #1 clk = ~ clk;
    end

    ALU_env env_instance;
    ALU_test test;
    // Instantiate the interface
    ALU_if alu_if (clk);
    ALU DUT (alu_if);
    // Configure the UVM database and the test
    initial begin
        uvm_config_db #(virtual ALU_if)::set (null,"*","alu_if",alu_if);
        run_test("ALU_test");
    end
endmodule : tb_top