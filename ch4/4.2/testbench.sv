/*
    UVM 1.2
    Mentor Questa 2021.3
    
    Run Options:    -voptargs=+acc=npr                          [defualt]
                    -voptargs=+acc=npr +UVM_TESTNAME=my_case0   [run_test(); no input]
    
    Show output file after run:     driver.log                  [base_test.connect_phase()]
*/

// Code your testbench here
// or browse Examples

`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "my_transaction.sv"

// `include "C_put.sv" //A.port包C.port,先產C
// `include "A_put.sv"
// `include "B_put.sv"
// `include "D_put.sv" //D.ex包B.ex,先產B

// `include "A_get.sv"
// `include "B_get.sv"

// `include "A_block_transport.sv"
// `include "B_block_transport.sv"

`include "A_nonblock_transport.sv"
`include "B_nonblock_transport.sv"

`include "my_env.sv"
`include "base_test.sv"
`include "my_case0.sv"

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

    

endmodule
