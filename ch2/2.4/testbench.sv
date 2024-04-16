// Code your testbench here
// or browse Examples

`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "my_transaction.sv"
`include "my_sequencer.sv"
`include "my_driver.sv"
`include "my_monitor.sv"
`include "my_agent.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_sequence.sv"
`include "my_env.sv"

module top_tb;

    reg clk;
    reg rst_n;
    reg[7:0] rxd;
    reg rx_dv;
    wire[7:0] txd;
    wire tx_en;

    /* 2.2.4 : interface */
    my_if input_if(clk, rst_n);
    my_if output_if(clk, rst_n);

    dut my_dut(
        .clk(clk),
        .rst_n(rst_n),
        .rxd(input_if.data),    //.rxd(rxd),
        .rx_dv(input_if.valid), //.rx_dv(rx_dv),
        .txd(output_if.data),   //.txd(txd),
        .tx_en(output_if.valid) //.tx_en(tx_en)
    );

    /* 2.2.2+2.2.3 : factory + objection */
    initial begin
        // run_test("my_driver"); //自動建立 "uvm_test_top"
        run_test("my_env"); //2.3.2 引入env->driver
    end

    /* 2.2.4 : interface */
    initial begin
        // === 2.3.4 引入agent, 包含driver與monitor ===
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.in_agt.drv", "vif", input_if);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.in_agt.mon", "vif", input_if);
        uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.out_agt.mon", "vif", output_if);
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

    

endmodule
