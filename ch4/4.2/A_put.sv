`ifndef A_PUT__SV
`define A_PUT__SV

class A extends uvm_component;
    `uvm_component_utils(A)

    C C_inst; //A.port(C.port)

    uvm_blocking_put_port#(my_transaction) A_port;
    // uvm_blocking_put_export#(my_transaction) A_export;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase); //A包C, 改由C發出tr
    extern virtual  task main_phase(uvm_phase phase);
endclass

function void A::build_phase(uvm_phase phase);
    super.build_phase(phase);
    A_port = new("A_port", this);
    // A_export = new("A_export", this);
    C_inst = C::type_id::create("C_inst", this); //A包C
endfunction

// A.port包C.port
function void A::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    C_inst.C_port.connect(this.A_port);
endfunction

task A::main_phase(uvm_phase phase);
    // //改由C.port發出
    // my_transaction tr;
    // repeat(10) begin
    //     #10;
    //     tr = new("tr");
    //     assert(tr.randomize());
    //     A_port.put(tr);
    //     // A_export.put(tr);
    // end
endtask

`endif
