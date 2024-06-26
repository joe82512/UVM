`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class drv0_seq extends uvm_sequence #(my_transaction);
    my_transaction m_trans;
    bit first_start;
    `uvm_object_utils(drv0_seq)

    function  new(string name= "drv0_seq");
        super.new(name);
        first_start = 1;
    endfunction 
    
    virtual task body();
        void'(uvm_config_db#(bit)::get(uvm_root::get(), get_full_name(), "first_start", first_start));
        if(first_start)
            `uvm_info("drv0_seq", "this is the first start of the sequence", UVM_MEDIUM)
        else
            `uvm_info("drv0_seq", "this is not the first start of the sequence", UVM_MEDIUM)
        // 傳遞參數給 v_sqr的seq (sequence)
        uvm_config_db#(bit)::set(uvm_root::get(), "uvm_test_top.v_sqr.*", "first_start", 0);
        
        repeat (10) begin
            `uvm_do(m_trans)
        end
    endtask
endclass

class drv1_seq extends uvm_sequence #(my_transaction);
    my_transaction m_trans;
    `uvm_object_utils(drv1_seq)

    function  new(string name= "drv1_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        repeat (10) begin
            `uvm_do(m_trans)
        end
    endtask
endclass

class case0_vseq extends uvm_sequence;
    `uvm_object_utils(case0_vseq)
    `uvm_declare_p_sequencer(my_vsqr) 
    function new(string name = "case0_vseq");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

    virtual task body();
        my_transaction tr;
        drv0_seq seq0;
        drv1_seq seq1;

        fork
            repeat(2) `uvm_do_on(seq0, p_sequencer.p_sqr0);
            repeat(2) `uvm_do_on(seq1, p_sequencer.p_sqr1);
        join 
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
        "v_sqr.main_phase",  
        "default_sequence", 
        case0_vseq::type_id::get()
    );
endfunction

`endif
