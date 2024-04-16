`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

    my_agent  in_agt, out_agt; // combine driver + monitor
    my_model  mdl; // ref model
    my_scoreboard scb; //scoreboard

    uvm_tlm_analysis_fifo #(my_transaction) agt_mdl_fifo; //ref model
    uvm_tlm_analysis_fifo #(my_transaction) agt_scb_fifo; //scoreboard
    uvm_tlm_analysis_fifo #(my_transaction) mdl_scb_fifo; //scoreboard

    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        in_agt = my_agent::type_id::create("in_agt", this);
        out_agt = my_agent::type_id::create("out_agt", this);
        in_agt.is_active = UVM_ACTIVE; //UVM define
        out_agt.is_active = UVM_PASSIVE;

        mdl = my_model::type_id::create("mdl", this);
        agt_mdl_fifo = new("agt_mdl_fifo", this);

        scb = my_scoreboard::type_id::create("scb", this);
        agt_scb_fifo = new("agt_scb_fifo", this);
        mdl_scb_fifo = new("mdl_scb_fifo", this);

        // 2.4.3 default_sequence
        uvm_config_db#(uvm_object_wrapper)::set(
            this,                   //uvm_test_top
            "in_agt.sqr.main_phase",
            "default_sequence",
            my_sequence::type_id::get()
        );

    endfunction

    extern virtual function void connect_phase(uvm_phase phase);
    // extern virtual task main_phase(uvm_phase phase); //2.4.3 default_sequence 抽離

    `uvm_component_utils(my_env);
endclass

function void my_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    in_agt.ap.connect(agt_mdl_fifo.analysis_export);
    mdl.port.connect(agt_mdl_fifo.blocking_get_export);
    
    mdl.ap.connect(mdl_scb_fifo.analysis_export);
    scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
    
    out_agt.ap.connect(agt_scb_fifo.analysis_export);
    scb.act_port.connect(agt_scb_fifo.blocking_get_export); 
endfunction

// 2.4.2 sequence -> 2.4.3 default_sequence 抽離
/*
task my_env::main_phase(uvm_phase phase);
    my_sequence seq;
    phase.raise_objection(this);
    seq = my_sequence::type_id::create("seq");
    seq.start(in_agt.sqr); 
    phase.drop_objection(this);
endtask
*/

`endif
