`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function new(string name= "my_sequence");
        super.new(name);
        set_automatic_phase_objection(1); //UVM 1.1d -> UVM 1.2
    endfunction

    virtual task body();

        // 2.4.3 default_sequence (env移植過來) -> UVM 1.1d
        // if(starting_phase != null) 
        //     starting_phase.raise_objection(this);

        repeat (10) begin
            `uvm_do(m_trans);
        end
        #1000;

        // 2.4.3 default_sequence (env移植過來) -> UVM 1.1d
        // if(starting_phase != null) 
        //     starting_phase.drop_objection(this);

    endtask

    `uvm_object_utils(my_sequence);
endclass

`endif
