`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

    A   A_inst;
    B   B_inst;
    // D   D_inst;
    
    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        A_inst = A::type_id::create("A_inst", this);
        B_inst = B::type_id::create("B_inst", this);
        // D_inst = D::type_id::create("D_inst", this);
    endfunction

    extern virtual function void connect_phase(uvm_phase phase);
    
    `uvm_component_utils(my_env)
endclass

function void my_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // A.port -> put -> B.export
    // A_inst.A_port.connect(B_inst.B_export); //A.port->B.ex->B.imp
    // A_inst.A_port.connect(B_inst.B_imp);    //A.port->B.imp
    // A_inst.A_export.connect(B_inst.B_imp);  //A.ex->B.imp
    // A_inst.A_port.connect(C_inst.C_export); //A.port->C.ex->B.ex->B.imp
    // A_inst.A_port.connect(D_inst.D_export); //A.port(C.port)->C.ex(B.ex->B.imp)

    // B.port <- get <- A.export
    // B_inst.B_port.connect(A_inst.A_export);

    // A.transport <-> B.transport
    // A_inst.A_transport.connect(B_inst.B_imp); //block
    A_inst.A_port.connect(B_inst.B_imp); //nonblock

endfunction

`endif
