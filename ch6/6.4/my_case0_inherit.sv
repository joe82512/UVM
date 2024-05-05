`ifndef MY_CASE0__SV
`define MY_CASE0__SV

//seq1
class base_sequence extends uvm_sequence #(my_transaction);
    `uvm_object_utils(base_sequence)
    `uvm_declare_p_sequencer(my_sequencer) //自動做sqr的轉型(pre_body)
    function  new(string name= "base_sequence");
        super.new(name);
    endfunction
    //define some common function and task 
endclass

//seq2, inherit seq1
class case0_sequence extends base_sequence; 
    `uvm_object_utils(case0_sequence)
    // `uvm_declare_p_sequencer(my_sequencer) //可省略, 已繼承
    my_transaction m_trans;

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction 
    
    virtual task body();
        repeat (10) begin
            `uvm_do(m_trans)
        end
        #100;
    endtask
endclass

class my_case0 extends base_test;

    function new(string name = "my_case0", uvm_component parent = null);
        super.new(name,parent);
    endfunction 
    extern virtual function void build_phase(uvm_phase phase); 

    `uvm_component_utils(my_case0)
endclass


function void my_case0::build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_db#(uvm_object_wrapper)::set(
        this, 
        "env.i_agt.sqr.main_phase", 
        "default_sequence", 
        case0_sequence::type_id::get()
    );
endfunction

`endif
