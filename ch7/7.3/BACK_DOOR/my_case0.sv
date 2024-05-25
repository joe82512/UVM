`ifndef MY_CASE0__SV
`define MY_CASE0__SV

// bus_seq 改成 reg_model的seq

class case0_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "case0_sequence");
        super.new(name);
    endfunction 
    
    virtual task body();
        repeat (10) begin
            `uvm_do(m_trans)
        end
    endtask

    `uvm_object_utils(case0_sequence)
endclass

class case0_bus_seq extends uvm_sequence #(bus_transaction);
    bus_transaction m_trans;

    function  new(string name= "case0_bus_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        bit[31:0] counter;

        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("invert's initial value is %0h", m_trans.rd_data), UVM_LOW)
        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_WR;
                                m_trans.wr_data == 16'h1;})
        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("after set, invert's value is %0h", m_trans.rd_data), UVM_LOW)
        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_WR;
                                m_trans.wr_data == 16'h0;})
        `uvm_do_with(m_trans, { m_trans.addr == 16'h9;
                                m_trans.bus_op == BUS_RD;})
        `uvm_info("case0_bus_seq", $sformatf("after set, invert's value is %0h", m_trans.rd_data), UVM_LOW)
        
        // counter
        `uvm_do_with(m_trans, { m_trans.addr == 16'h5;
                                m_trans.bus_op == BUS_RD;})
        counter[31:16] = m_trans.rd_data[15:0]; 
        `uvm_do_with(m_trans, { m_trans.addr == 16'h6;
                                m_trans.bus_op == BUS_RD;})
        counter[15:0] = m_trans.rd_data[15:0]; 
        `uvm_info("case0_bus_seq", $sformatf("counter's value is %0h", counter), UVM_LOW)
    endtask

    `uvm_object_utils(case0_bus_seq)
endclass


// class case0_cfg_vseq extends uvm_sequence;

//     `uvm_object_utils(case0_cfg_vseq)
//     `uvm_declare_p_sequencer(my_vsqr)
    
//     function  new(string name= "case0_cfg_vseq");
//         super.new(name);
//         set_automatic_phase_objection(1);
//     endfunction 
    
//     virtual task body();
//         // uvm_status_e   status;
//         // uvm_reg_data_t value;
//         case0_bus_seq  bseq;
        
//         // p_sequencer.p_rm.invert.read(status, value, UVM_FRONTDOOR); //前門訪問
//         // `uvm_info("case0_cfg_vseq", $sformatf("invert's initial value is %0h", value), UVM_LOW)
//         // p_sequencer.p_rm.invert.write(status, 1, UVM_FRONTDOOR);    // write
//         // p_sequencer.p_rm.invert.read(status, value, UVM_FRONTDOOR); // read
//         // `uvm_info("case0_cfg_vseq", $sformatf("after set, invert's value is %0h", value), UVM_LOW)
//         bseq = case0_bus_seq::type_id::create("bseq");
//         bseq.start(p_sequencer.p_bus_sqr);
//     endtask

// endclass

// 把vseq包一起
class case0_vseq extends uvm_sequence;
    `uvm_object_utils(case0_vseq)
    `uvm_declare_p_sequencer(my_vsqr)
    function new(string name = "case0_vseq");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

    virtual task body();
        case0_sequence dseq;
        case0_bus_seq  bseq;
        // uvm_status_e   status;
        // uvm_reg_data_t value;

        bseq = case0_bus_seq::type_id::create("bseq");
        bseq.start(p_sequencer.p_bus_sqr);
        // #10000;
        dseq = case0_sequence::type_id::create("dseq");
        dseq.start(p_sequencer.p_my_sqr);

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
        "v_sqr.main_phase", 
        "default_sequence", 
        case0_vseq::type_id::get()
    );
    
endfunction

`endif
