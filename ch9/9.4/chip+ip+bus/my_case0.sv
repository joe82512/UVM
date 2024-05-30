`ifndef MY_CASE0__SV
`define MY_CASE0__SV

// bus_seq 改成 reg_model的seq

class case0_bus_seq extends uvm_sequence #(bus_transaction);
    bus_transaction m_trans;

    function  new(string name= "case0_bus_seq");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction 
    
    virtual task body();
        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("module A invert's initial value is %0h", m_trans.rd_data), UVM_LOW)
        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_WR;
                                m_trans.wr_data == 16'h1;})
        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("after set, module A invert's value is %0h", m_trans.rd_data), UVM_LOW)


        `uvm_do_with(m_trans, { m_trans.addr == 16'h4009;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("module A invert's initial value is %0h", m_trans.rd_data), UVM_LOW)
        `uvm_do_with(m_trans, { m_trans.addr == 16'h4009;
                                m_trans.bus_op == BUS_WR;
                                m_trans.wr_data == 16'h1;})
        `uvm_do_with(m_trans, { m_trans.addr == 16'h4009;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("after set, module A invert's value is %0h", m_trans.rd_data), UVM_LOW)


        `uvm_do_with(m_trans, { m_trans.addr == 16'h8009;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("module A invert's initial value is %0h", m_trans.rd_data), UVM_LOW)
        `uvm_do_with(m_trans, { m_trans.addr == 16'h8009;
                                m_trans.bus_op == BUS_WR;
                                m_trans.wr_data == 16'h1;})
        `uvm_do_with(m_trans, { m_trans.addr == 16'h8009;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("after set, module A invert's value is %0h", m_trans.rd_data), UVM_LOW)

    endtask

    `uvm_object_utils(case0_bus_seq)
endclass

class case0_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction 
    
    virtual task body();
        #100000;
        repeat (10) begin
            `uvm_do(m_trans)
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
        "env.bus_agt.sqr.configure_phase", 
        "default_sequence", 
        case0_bus_seq::type_id::get()
    );

    uvm_config_db#(uvm_object_wrapper)::set(
        this, 
        "env.env_A.i_agt.sqr.main_phase", 
        "default_sequence", 
        case0_sequence::type_id::get()
    );
    
endfunction

`endif
