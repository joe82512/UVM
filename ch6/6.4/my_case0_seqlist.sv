`ifndef MY_CASE0__SV
`define MY_CASE0__SV

// seq1
class crc_seq extends uvm_sequence#(my_transaction);
    `uvm_object_utils(crc_seq)
    function  new(string name= "crc_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        my_transaction tr;
        `uvm_do_with(tr, { tr.crc_err == 1;
                           tr.dmac == 48'h980F;})
    endtask
endclass

// seq2
class long_seq extends uvm_sequence#(my_transaction);
    `uvm_object_utils(long_seq)
    function  new(string name= "long_seq");
        super.new(name);
    endfunction 
    
    virtual task body();
        my_transaction tr;
        `uvm_do_with(tr, { tr.crc_err == 0;
                           tr.pload.size() == 1500;
                           tr.dmac == 48'hF675;})
    endtask
endclass

// seq = [seq1,seq2]
class case0_sequence extends uvm_sequence #(my_transaction);

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

   virtual task body();
        crc_seq cseq;
        long_seq lseq;

        repeat (10) begin
            // cseq = new("cseq");
            // cseq.start(m_sequencer);
            `uvm_do(cseq)
            
            // lseq = new("lseq");
            // lseq.start(m_sequencer);
            `uvm_do(lseq)
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
