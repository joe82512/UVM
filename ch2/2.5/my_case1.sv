`ifndef MY_CASE1__SV
`define MY_CASE1__SV

class case1_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "case1_sequence");
        super.new(name);
        set_automatic_phase_objection(1); //UVM 1.1d -> UVM 1.2
    endfunction 

    virtual task body();
        // if(starting_phase != null) //UVM 1.1d
        //     starting_phase.raise_objection(this);
        repeat (10) begin
            `uvm_do_with(m_trans, { m_trans.pload.size() == 60;}) //隨機約束
        end
        #100;
        // if(starting_phase != null) //UVM 1.1d
        //     starting_phase.drop_objection(this);
    endtask

    `uvm_object_utils(case1_sequence);

endclass

class my_case1 extends base_test;
  
    function new(string name = "my_case1", uvm_component parent = null);
        super.new(name,parent);
    endfunction 
    
    extern virtual function void build_phase(uvm_phase phase); 
    `uvm_component_utils(my_case1);

endclass


function void my_case1::build_phase(uvm_phase phase);
    super.build_phase(phase);

        uvm_config_db#(uvm_object_wrapper)::set(
        this,                       //uvm_test_top
        "env.in_agt.sqr.main_phase",
        "default_sequence",
        case1_sequence::type_id::get()
    );

endfunction

`endif
