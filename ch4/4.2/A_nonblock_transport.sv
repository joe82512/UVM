`ifndef A_NONBLOCK_TRANSPORT__SV
`define A_NONBLOCK_TRANSPORT__SV

class A extends uvm_component;
    `uvm_component_utils(A)

    uvm_nonblocking_put_port#(my_transaction) A_port;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern function void build_phase(uvm_phase phase);
    extern virtual  task main_phase(uvm_phase phase);
endclass

function void A::build_phase(uvm_phase phase);
    super.build_phase(phase);
    A_port = new("A_port", this);
endfunction

task A::main_phase(uvm_phase phase);
    my_transaction tr;
    repeat(10) begin
        tr = new("tr");
        assert(tr.randomize());
        while(!A_port.can_put()) #10; //判斷是否能發送
        void'(A_port.try_put(tr));    //嘗試發送
    end
endtask

`endif
