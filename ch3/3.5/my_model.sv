`ifndef MY_MODEL__SV
`define MY_MODEL__SV

class my_model extends uvm_component;
   
    uvm_blocking_get_port #(my_transaction)  port;
    uvm_analysis_port #(my_transaction)  ap;
    int drv_pre_num;

    extern function new(string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern virtual  task main_phase(uvm_phase phase);

    `uvm_component_utils(my_model);
endclass 

function my_model::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction 

function void my_model::build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("port", this);
    ap = new("ap", this);

    // model 與 driver 不在同一路徑上 : 拉到 env
    `uvm_info("my_model", $sformatf("before get, the pre_num is %0d", drv_pre_num), UVM_LOW) 
    void'(
        uvm_config_db#(int)::get(
            this.m_parent, //env
            "in_agt.drv",
            "pre_num",
            drv_pre_num
        )
    );
    `uvm_info("my_model", $sformatf("after get, the pre_num is %0d", drv_pre_num), UVM_LOW)

endfunction

task my_model::main_phase(uvm_phase phase);
    my_transaction tr;
    my_transaction new_tr;
    super.main_phase(phase);
    while(1) begin
        port.get(tr);
        new_tr = new("new_tr");
        new_tr.copy(tr); //2.3.7 uvm_field
        `uvm_info("my_model", "get one transaction, copy and print it:", UVM_LOW);
        new_tr.print(); //2.3.7 uvm_field
        ap.write(new_tr); // uvm_analysis_port <write>, 廣播
    end
endtask

`endif
