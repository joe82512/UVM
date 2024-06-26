`ifndef A__SV
`define A__SV

class A extends uvm_component;
    `uvm_component_utils(A)

    uvm_analysis_port#(my_transaction) A_ap;
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern function void build_phase(uvm_phase phase);
    extern virtual  task main_phase(uvm_phase phase);
endclass

function void A::build_phase(uvm_phase phase);
    super.build_phase(phase);
    A_ap = new("A_ap", this);
endfunction

task A::main_phase(uvm_phase phase);
    my_transaction tr;
    repeat(10) begin
        #10;
        tr = new("tr");
        assert(tr.randomize());
        A_ap.write(tr);
    end
endtask

`endif
