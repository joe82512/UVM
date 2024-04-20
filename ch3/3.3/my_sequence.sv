`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function new(string name= "my_sequence");
        super.new(name);
        set_automatic_phase_objection(1); //UVM 1.1d -> UVM 1.2
    endfunction

    virtual task body();

        repeat (10) begin
            `uvm_do(m_trans);
        end
        #1000;

    endtask

    `uvm_object_utils(my_sequence);
endclass

`endif
