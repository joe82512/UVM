`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class case0_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;
    int count;

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction 
    
    virtual task pre_body();
        if(uvm_config_db#(int)::get(null, get_full_name(), "count", count)) //不能用this
            `uvm_info("seq0", $sformatf("get count value %0d via config_db", count), UVM_MEDIUM)
        else
            `uvm_error("seq0", "can't get count value!") 
    endtask

    virtual task body();

        repeat (10) begin
            `uvm_do(m_trans)
        end
        #100;

    endtask

    `uvm_object_utils(case0_sequence) //不是component
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

    uvm_config_db#(int)::set(this, "env.i_agt.sqr.*", "count", 9); //*: seq名字未知

    uvm_config_db#(uvm_object_wrapper)::set(
        this, 
        "env.i_agt.sqr.main_phase", 
        "default_sequence", 
        case0_sequence::type_id::get()
    );
endfunction

`endif
