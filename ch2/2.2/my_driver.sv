`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

class my_driver extends uvm_driver;
    virtual my_if vif; //2.2.4 virtual interface in class

    /* factory 通常會搭配 objection raise+drop 達成 $finish 作用 */
    `uvm_component_utils(my_driver); //2.2.2: factory
    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("my_driver", "new is called", UVM_LOW); //UVM_LOW: log priority
    endfunction

    /* 綁定 top(testbench) 跟 driver 的 virtual interface : uvm_config_db<get> 靜態函數 */
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("my_driver", "build_phase is called", UVM_LOW);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif)) // get
            `uvm_fatal("my_driver", "virtual interface must be set for vif!!!") //fatal = msg error + $finish
    endfunction

    extern virtual task main_phase(uvm_phase phase);
endclass

task my_driver::main_phase(uvm_phase phase);
    /* objection 必須在第一個仿真耗時前 ex: @(posedge top_tb.clk); */
    phase.raise_objection(this); //2.2.3: objection
    `uvm_info("my_driver", "main_phase is called", UVM_LOW);
    vif.data <= 8'b0;   //top_tb.rxd <= 8'b0; 
    vif.valid <= 1'b0;  //top_tb.rx_dv <= 1'b0;
    
    while(!vif.rst_n)       //while(!top_tb.rst_n)
        @(posedge vif.clk); //    @(posedge top_tb.clk);
    
    for(int i = 0; i < 256; i++)begin
        @(posedge vif.clk);                 //@(posedge top_tb.clk);
        vif.data <= $urandom_range(0, 255); //top_tb.rxd <= $urandom_range(0, 255);
        vif.valid <= 1'b1;                  //top_tb.rx_dv <= 1'b1;
        `uvm_info("my_driver", "data is drived", UVM_LOW);
    end
    
    @(posedge vif.clk); //@(posedge top_tb.clk);
    vif.valid <= 1'b0;  //top_tb.rx_dv <= 1'b0;
    // $display("the full name of current component is: %s", get_full_name()); //drv
    phase.drop_objection(this); //2.2.3: objection
endtask

`endif