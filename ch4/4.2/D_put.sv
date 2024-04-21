`ifndef D_PUT__SV
`define D_PUT__SV

class D extends uvm_component;
    `uvm_component_utils(D)

    B B_inst; //D.ex包B.ex

    uvm_blocking_put_export#(my_transaction) D_export; //D.ex包B.ex

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase); //D.ex包B.ex
    extern virtual  task main_phase(uvm_phase phase);
endclass

function void D::build_phase(uvm_phase phase);
    super.build_phase(phase);
    D_export = new("D_export", this); //D.ex包B.ex
    B_inst = B::type_id::create("B_inst", this); //D.ex包B.ex
endfunction

// D.ex包B.ex
function void D::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    this.D_export.connect(B_inst.B_export);
endfunction

task D::main_phase(uvm_phase phase);

endtask

`endif
