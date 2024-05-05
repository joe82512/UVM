`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class sequence0 extends uvm_sequence #(my_transaction);
    my_transaction m_trans;
    int num;
    bit has_delayed; //control flag

    function  new(string name= "sequence0");
        super.new(name);
        num = 0;
        has_delayed = 0;
        set_automatic_phase_objection(1);
    endfunction

    // 必須override
    virtual function bit is_relevant();
        if((num >= 3)&&(!has_delayed)) return 0;
        else return 1;
    endfunction

    virtual task wait_for_relevant();
        #10000;
        has_delayed = 1; //不切回有效 , 會造成死循環
    endtask

    virtual task body();
    /*
        fork
            repeat (10) begin
                num++;
                `uvm_do(m_trans)
                `uvm_info("sequence0", "send one transaction", UVM_MEDIUM)
            end
            while(1) begin
                if(!has_delayed) begin
                    if(num >= 3) begin
                        //有效
                        `uvm_info("sequence0", "begin to delay", UVM_MEDIUM)
                        #5000000; //wait time, 但通常用 wait_for_relevant
                        has_delayed = 1'b1;
                        `uvm_info("sequence0", "end delay", UVM_MEDIUM)
                        break;
                    end
                    else
                        #1000;
                end
            end
        join
    */
        repeat (10) begin
            num++;
            `uvm_do(m_trans)
            `uvm_info("sequence0", "send one transaction", UVM_MEDIUM)
        end
        #100;
    endtask

    `uvm_object_utils(sequence0)
endclass

// second seq
class sequence1 extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "sequence1");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction

    virtual task body();
        repeat (10) begin
            `uvm_do_with(m_trans, {m_trans.pload.size == 500;})
            `uvm_info("sequence1", "send one transaction", UVM_MEDIUM)
        end
        #100;
    endtask

    `uvm_object_utils(sequence1)
endclass

class my_case0 extends base_test;

    function new(string name = "my_case0", uvm_component parent = null);
        super.new(name,parent);
    endfunction 
    extern virtual task main_phase(uvm_phase phase);

    `uvm_component_utils(my_case0)
endclass


task my_case0::main_phase(uvm_phase phase);
    sequence0 seq0;
    sequence1 seq1;

    seq0 = new("seq0");
    seq0.starting_phase = phase;
    seq1 = new("seq1");
    seq1.starting_phase = phase;
    fork
        seq0.start(env.i_agt.sqr);
        seq1.start(env.i_agt.sqr);
    join

endtask

`endif
