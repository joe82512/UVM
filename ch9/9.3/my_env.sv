`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

    my_agent   i_agt;
    my_agent   o_agt;

    // bus_agent  bus_agt; //add bus drv.mon.sqr
    bus_agent#(16, 16)  bus_agt;

    my_model   mdl;
    my_scoreboard scb;
    
    uvm_tlm_analysis_fifo #(my_transaction) agt_scb_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) agt_mdl_fifo;
    uvm_tlm_analysis_fifo #(my_transaction) mdl_scb_fifo;
    
    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        i_agt = my_agent::type_id::create("i_agt", this);
        o_agt = my_agent::type_id::create("o_agt", this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt.is_active = UVM_PASSIVE;
        
        // bus_agt = bus_agent::type_id::create("bus_agt", this);
        bus_agt = bus_agent#(16, 16)::type_id::create("bus_agt", this);
        bus_agt.is_active = UVM_ACTIVE; //need input driver
        
        mdl = my_model::type_id::create("mdl", this);
        scb = my_scoreboard::type_id::create("scb", this);
        agt_scb_fifo = new("agt_scb_fifo", this);
        agt_mdl_fifo = new("agt_mdl_fifo", this);
        mdl_scb_fifo = new("mdl_scb_fifo", this);

    endfunction

    extern virtual function void connect_phase(uvm_phase phase);
    
    `uvm_component_utils(my_env)
endclass

function void my_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    i_agt.ap.connect(agt_mdl_fifo.analysis_export);
    mdl.port.connect(agt_mdl_fifo.blocking_get_export);
    mdl.ap.connect(mdl_scb_fifo.analysis_export); //標示export, 實質上是IMP
    scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
    o_agt.ap.connect(agt_scb_fifo.analysis_export);
    scb.act_port.connect(agt_scb_fifo.blocking_get_export); 
endfunction

`endif
