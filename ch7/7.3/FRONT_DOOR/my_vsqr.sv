`ifndef MY_VSQR__SV
`define MY_VSQR__SV

//add reg_model

class my_vsqr extends uvm_sequencer;
  
    my_sequencer    p_my_sqr;
    bus_sequencer   p_bus_sqr;

    // reg_model     p_rm;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction 
    
    `uvm_component_utils(my_vsqr)
endclass

`endif
