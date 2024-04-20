`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class case0_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1); //UVM 1.1d -> UVM 1.2
    endfunction 
    
    virtual task body();

        repeat (10) begin
            // `uvm_do(m_trans)
            `uvm_do_with(m_trans, {
                m_trans.crc_err == 0;
                m_trans.is_vlan == 0;
            })
            `uvm_info("case0_seq", "send one transaction, print it", UVM_LOW)
            m_trans.print();
        end
        #100;

    endtask

    `uvm_object_utils(case0_sequence);

endclass


class my_case0 extends base_test;

    function new(string name = "my_case0", uvm_component parent = null);
        super.new(name,parent);
    endfunction 
    
    extern virtual function void build_phase(uvm_phase phase); 

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        check_config_usage(); //顯示沒被get的config_db
        // print_config(1); //顯示所有參數 , 1:hier
    endfunction

    `uvm_component_utils(my_case0);

endclass


function void my_case0::build_phase(uvm_phase phase);
    super.build_phase(phase);

    uvm_config_db#(uvm_object_wrapper)::set(
        this,                       //uvm_test_top
        "env.in_agt.sqr.main_phase",
        "default_sequence",
        case0_sequence::type_id::get()
    );

    uvm_config_db#(int)::set(
        this, 
        "env.in_agt.drv", 
        "pre_num", 
        7
    );

endfunction

`endif
