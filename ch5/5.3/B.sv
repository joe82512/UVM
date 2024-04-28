`ifndef B__SV
`define B__SV

class B extends uvm_component;
    uvm_domain new_domain;
    bit has_jumped; //5.3.3 jump case

    `uvm_component_utils(B)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        new_domain = new("new_domain");
        has_jumped = 0; //5.3.3 jump case
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        set_domain(new_domain); //設置新domain獨立於A
    endfunction

    extern virtual  task reset_phase(uvm_phase phase);
    extern virtual  task post_reset_phase(uvm_phase phase);
    extern virtual  task main_phase(uvm_phase phase);
    extern virtual  task post_main_phase(uvm_phase phase);
endclass

task B::reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("B", "enter into reset phase", UVM_LOW)
    #100; //A卡300, B卡100
    phase.drop_objection(this);
endtask

task B::post_reset_phase(uvm_phase phase);
    `uvm_info("B", "enter into post reset phase", UVM_LOW)
endtask

task B::main_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("B", "enter into main phase", UVM_LOW)
    #500; //A卡200, B卡500

    //5.3.3 jump case
    if(!has_jumped) begin
        phase.jump(uvm_reset_phase::get());
        has_jumped = 1'b1;
    end

    phase.drop_objection(this);
endtask

task B::post_main_phase(uvm_phase phase);
    `uvm_info("B", "enter into post main phase", UVM_LOW)
endtask

`endif
