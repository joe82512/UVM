`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

typedef class A; //callback

class my_driver extends uvm_driver#(my_transaction);

    virtual my_if vif;

    `uvm_component_utils(my_driver)
    `uvm_register_cb(my_driver, A) //callback

    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_driver", "virtual interface must be set for vif!!!")
    endfunction

    extern task main_phase(uvm_phase phase);
    extern task drive_one_pkt(my_transaction tr);
endclass

task my_driver::main_phase(uvm_phase phase);
    vif.data <= 8'b0;
    vif.valid <= 1'b0;
    while(!vif.rst_n)
        @(posedge vif.clk);
    while(1) begin
        seq_item_port.get_next_item(req);

        `uvm_do_callbacks(my_driver, A, pre_tran(this, req)) //callback
        
        drive_one_pkt(req);
        seq_item_port.item_done();
    end
endtask

task my_driver::drive_one_pkt(my_transaction tr);
    byte unsigned     data_q[];
    int  data_size;
    
    data_size = tr.pack_bytes(data_q) / 8; 
    `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
    repeat(3) @(posedge vif.clk);
    for ( int i = 0; i < data_size; i++ ) begin
        @(posedge vif.clk);
        vif.valid <= 1'b1;
        vif.data <= data_q[i]; 
    end

    @(posedge vif.clk);
    vif.valid <= 1'b0;
    `uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask

class new_driver extends my_driver;
   `uvm_component_utils(new_driver)
   `uvm_set_super_type(new_driver, my_driver) //繼承
   function new(string name = "new_driver", uvm_component parent = null);
      super.new(name, parent);
   endfunction
   
   extern task main_phase(uvm_phase phase);
endclass

task new_driver::main_phase(uvm_phase phase);
    vif.data <= 8'b0;
    vif.valid <= 1'b0;
    while(!vif.rst_n)
        @(posedge vif.clk);
    while(1) begin
        seq_item_port.get_next_item(req);
        `uvm_info("new_driver", "this is new driver", UVM_MEDIUM)
        `uvm_do_callbacks(my_driver, A, pre_tran(this, req))
        drive_one_pkt(req);
        seq_item_port.item_done();
    end
endtask

`endif
