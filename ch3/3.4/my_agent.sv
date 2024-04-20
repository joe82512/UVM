`ifndef MY_AGENT__SV
`define MY_AGENT__SV

class my_agent extends uvm_agent ;
    my_sequencer  sqr; //sequencer
    my_driver     drv;
    my_monitor    mon;

    uvm_analysis_port #(my_transaction)  ap; //2.3.5 ref model
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
    
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    `uvm_component_utils(my_agent);
endclass 


function void my_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (is_active == UVM_ACTIVE) begin //UVM define
        sqr = my_sequencer::type_id::create("sqr", this); //sequencer
        drv = my_driver::type_id::create("drv", this);
    end
    mon = my_monitor::type_id::create("mon", this);
endfunction 

function void my_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // sequence
    if (is_active == UVM_ACTIVE) begin
        drv.seq_item_port.connect(sqr.seq_item_export);
    end

    ap = mon.ap; //pointer 2.3.5 ref model
endfunction

`endif
