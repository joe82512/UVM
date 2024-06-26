`ifndef BUS_AGENT__SV
`define BUS_AGENT__SV

// same as my_agent.sv

// class bus_agent extends uvm_agent ;
class bus_agent#(int ADDR_WIDTH=16, int DATA_WIDTH=16) extends uvm_agent ;
    // bus_sequencer  sqr;
    // bus_driver     drv;
    // bus_monitor    mon;
    bus_sequencer#(ADDR_WIDTH, DATA_WIDTH)  sqr;
    bus_driver#(ADDR_WIDTH, DATA_WIDTH)     drv;
    bus_monitor#(ADDR_WIDTH, DATA_WIDTH)    mon;
    
    // uvm_analysis_port #(bus_transaction)  ap;
    uvm_analysis_port #(bus_transaction#(ADDR_WIDTH, DATA_WIDTH))  ap;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
    
    // extern virtual function void build_phase(uvm_phase phase);
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            // sqr = bus_sequencer::type_id::create("sqr", this);
            // drv = bus_driver::type_id::create("drv", this);
            sqr = bus_sequencer#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("sqr", this);
            drv = bus_driver#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("drv", this);
        end
        // mon = bus_monitor::type_id::create("mon", this);
        mon = bus_monitor#(ADDR_WIDTH, DATA_WIDTH)::type_id::create("mon", this);
    endfunction 
    
    // extern virtual function void connect_phase(uvm_phase phase);
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            drv.seq_item_port.connect(sqr.seq_item_export);
        end
        ap = mon.ap;
    endfunction

    // `uvm_component_utils(bus_agent)
    `uvm_component_utils(bus_agent#(ADDR_WIDTH, DATA_WIDTH))
endclass 



`endif

