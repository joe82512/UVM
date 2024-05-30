/*
    UVM 1.2
    Mentor Questa 2021.3
    
    Run Options:    -voptargs=+acc=npr                          [defualt]
                    -voptargs=+acc=npr +UVM_TESTNAME=my_case0   [run_test(); no input]
    
    Show output file after run:     driver.log                  [base_test.connect_phase()]
*/

// Code your testbench here
// or browse Examples

`timescale 1ns/1ns //5.1.3修改
`include "uvm_macros.svh"

import uvm_pkg::*;

// bus folder
`include "bus_if.sv"
`include "bus_transaction.sv"
`include "bus_sequencer.sv"
`include "bus_driver.sv"
`include "bus_monitor.sv"
`include "bus_agent.sv"
`include "my_adapter.sv"

// ip folder
`include "my_if.sv"
`include "my_transaction.sv"
`include "my_sequencer.sv"
`include "my_driver.sv"
`include "my_monitor.sv"
`include "my_agent.sv"
`include "reg_model.sv"
`include "my_model.sv"      //add reg_model
`include "my_scoreboard.sv"
`include "my_env.sv"        //add reg_model
// `include "my_vsqr.sv"       //add reg_model

// chip folder
`include "arbitor.sv"
`include "chip_dut.sv"
`include "chip_reg_model.sv"
`include "chip_env.sv"
`include "base_test.sv"     //add reg_model & adapter
`include "my_case0.sv"      // bus_seq 改成 reg_model的seq

module top_tb;

    reg clk;
    reg rst_n;
    reg[7:0] rxd;
    reg rx_dv;
    wire[7:0] txd;
    wire tx_en;

    // my_if input_if(clk, rst_n);
    // my_if output_if(clk, rst_n);
    my_if input_if_A(clk, rst_n);
    my_if output_if_A(clk, rst_n);
    my_if output_if_B(clk, rst_n);
    my_if output_if_C(clk, rst_n);

    bus_if b_if(clk, rst_n);

    // dut my_dut(
    //     .clk          (clk               ),
    //     .rst_n        (rst_n             ),
    //     .bus_cmd_valid(b_if.bus_cmd_valid), 
    //     .bus_op       (b_if.bus_op       ), 
    //     .bus_addr     (b_if.bus_addr     ), 
    //     .bus_wr_data  (b_if.bus_wr_data  ), 
    //     .bus_rd_data  (b_if.bus_rd_data  ), 
    //     .rxd          (input_if.data     ),
    //     .rx_dv        (input_if.valid    ),
    //     .txd          (output_if.data    ),
    //     .tx_en        (output_if.valid   )
    // );

    chip_dut my_dut(
        .clk(clk),
        .rst_n(rst_n),
        .bus_cmd_valid(b_if.bus_cmd_valid), 
        .bus_op       (b_if.bus_op       ), 
        .bus_addr     (b_if.bus_addr     ), 
        .bus_wr_data  (b_if.bus_wr_data  ), 
        .bus_rd_data  (b_if.bus_rd_data  ), 
        .rxd(input_if_A.data),
        .rx_dv(input_if_A.valid),
        .txd(output_if_C.data),
        .tx_en(output_if_C.valid)
    );
    assign output_if_A.data = my_dut.data0;
    assign output_if_A.valid = my_dut.dv0;
    assign output_if_B.data = my_dut.data1;
    assign output_if_B.valid = my_dut.dv1;

    initial begin
        run_test("my_case0");
    end

    initial begin
        clk = 0;
        forever begin
            #100 clk = ~clk;
        end
    end

    initial begin
        rst_n = 1'b0;
        #1000;
        rst_n = 1'b1;
    end

    initial begin
        // uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.drv", "vif", input_if);
        // uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.mon", "vif", input_if);
        // uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.o_agt.mon", "vif", output_if);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_A.i_agt.drv", "vif", input_if_A);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_A.i_agt.mon", "vif", input_if_A);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_A.o_agt.mon", "vif", output_if_A);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_B.o_agt.mon", "vif", output_if_B);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.env_C.o_agt.mon", "vif", output_if_C);
        // bus
        uvm_config_db#(virtual bus_if)::set(null, "uvm_test_top.env.bus_agt.drv", "vif", b_if);
        uvm_config_db#(virtual bus_if)::set(null, "uvm_test_top.env.bus_agt.mon", "vif", b_if);
    end
    

endmodule
