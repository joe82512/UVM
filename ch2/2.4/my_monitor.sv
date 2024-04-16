`ifndef MY_MONITOR__SV
`define MY_MONITOR__SV

class my_monitor extends uvm_monitor;

    virtual my_if vif;

    uvm_analysis_port #(my_transaction)  ap; //2.3.5 ref model

    `uvm_component_utils(my_monitor); //component
    
    function new(string name = "my_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_fatal("my_monitor", "virtual interface must be set for vif!!!");
        ap = new("ap", this); //2.3.5 ref model
    endfunction

    extern task main_phase(uvm_phase phase);
    extern task collect_one_pkt(my_transaction tr);
endclass

task my_monitor::main_phase(uvm_phase phase);
    my_transaction tr;
    while(1) begin
        tr = new("tr");
        collect_one_pkt(tr);
        ap.write(tr); //uvm_analysis_port <write>, 廣播
    end
endtask

task my_monitor::collect_one_pkt(my_transaction tr);

    /* 2.3.7 : uvm_field 內建 print.copy.compare */
    byte unsigned data_q[$];
    byte unsigned data_array[];
    logic [7:0] data;
    logic valid = 0;
    int data_size;

    while(1) begin
        @(posedge vif.clk);
        if(vif.valid) break;
    end

    `uvm_info("my_monitor", "begin to collect one pkt", UVM_LOW);
    while(vif.valid) begin
        data_q.push_back(vif.data);
        @(posedge vif.clk);
    end

    /* 2.3.7 : uvm_field 內建 print.copy.compare */
    data_size  = data_q.size();   
    data_array = new[data_size];
    for ( int i = 0; i < data_size; i++ ) begin
        data_array[i] = data_q[i]; 
    end
    tr.pload = new[data_size - 18]; //da sa, e_type, crc
    data_size = tr.unpack_bytes(data_array) / 8; 

    // $display in ref model <main_phase>
    `uvm_info("my_monitor", "end collect one pkt, print it:", UVM_LOW);
    // tr.my_print(); //new func

endtask

`endif
