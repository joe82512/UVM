`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class new_transaction extends my_transaction;
    `uvm_object_utils(new_transaction)
    function  new(string name= "new_transaction");
        super.new(name);
    endfunction 

    constraint crc_err_cons{ crc_err dist {0 := 2, 1 := 1}; }
endclass

class case0_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1); //UVM 1.1d -> UVM 1.2
    endfunction 

    virtual task body();
        new_transaction ntr;
        repeat (10) begin
            // m_trans = new();
            // `uvm_info("sequence", "turn off constraint", UVM_MEDIUM)
            // m_trans.crc_err_cons.constraint_mode(0);
            // `uvm_rand_send_with(m_trans, {crc_err dist {0 := 2, 1 := 1};})
            `uvm_do(ntr)
            ntr.print();
        end
        #100;
    endtask

    `uvm_object_utils(case0_sequence)
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
