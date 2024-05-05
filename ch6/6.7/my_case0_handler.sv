`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class case0_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction 

    virtual task pre_body();
        use_response_handler(1); //打開功能
    endtask
    
    //override
    virtual function void response_handler(uvm_sequence_item response);
        if(!$cast(rsp, response)) //轉型成seq_item
            `uvm_error("seq", "can't cast")
        else begin
            `uvm_info("seq", "get one response", UVM_MEDIUM)
            rsp.print();
        end
    endfunction

    // get(rsp) , set from driver
    virtual task body();
        repeat (10) begin
            `uvm_do(m_trans)
            // get_response(rsp);
            // `uvm_info("seq", "get one response", UVM_MEDIUM)
            // rsp.print();
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

    uvm_config_db#(uvm_object_wrapper)::set(
        this, 
        "env.i_agt.sqr.main_phase", 
        "default_sequence", 
        case0_sequence::type_id::get()
    );
endfunction

`endif
