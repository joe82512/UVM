`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class case0_sequence extends uvm_sequence #(my_transaction);
    my_transaction m_trans;

    function  new(string name= "case0_sequence");
        super.new(name);
        set_automatic_phase_objection(1); //UVM 1.1d -> UVM 1.2
    endfunction 

    virtual task body();
        repeat (10) begin
            `uvm_do(m_trans)
        end
        #100;
    endtask

    `uvm_object_utils(case0_sequence)
endclass

class bird extends uvm_object;
    //可以override
    virtual function void hungry();
        $display("I am a bird, I am hungry");
    endfunction
    //不能override
    function void hungry2();
        $display("I am a bird, I am hungry2");
    endfunction

    `uvm_object_utils(bird)
    function new(string name = "bird");
        super.new(name);
    endfunction 
endclass

class parrot extends bird;
    //override會成功
    virtual function void hungry();
        $display("I am a parrot, I am hungry");
    endfunction
    //override會失敗
    function void hungry2();
        $display("I am a parrot, I am hungry2");
    endfunction

    `uvm_object_utils(parrot)
    function new(string name = "parrot");
        super.new(name);
    endfunction 
endclass

class my_case0 extends base_test;

    function new(string name = "my_case0", uvm_component parent = null);
        super.new(name,parent);
    endfunction 
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void print_hungry(bird b_ptr); 
    `uvm_component_utils(my_case0)
endclass


function void my_case0::print_hungry(bird b_ptr);
    b_ptr.hungry();
    b_ptr.hungry2();
endfunction

class bear extends uvm_object;
    virtual function void hungry();
        $display("I am a bear, I am hungry");
    endfunction
    function void hungry2();
        $display("I am a bear, I am hungry2");
    endfunction

    `uvm_object_utils(bear)
    function new(string name = "bear");
        super.new(name);
    endfunction 
endclass

function void my_case0::build_phase(uvm_phase phase);
    bird bird_inst;
    parrot parrot_inst;
    super.build_phase(phase);
    
    //factory override, 逆向繼承?
    set_type_override_by_type(bird::get_type(), parrot::get_type());

    // set_type_override_by_type(bird::get_type(), bear::get_type());   //FAIL: 非繼承關係
    // set_type_override_by_type(parrot::get_type(), bird::get_type()); //FAIL: 父->子, 不可逆

    bird_inst = bird::type_id::create("bird_inst");
    parrot_inst = parrot::type_id::create("parrot_inst");
    print_hungry(bird_inst);
    print_hungry(parrot_inst);
endfunction

`endif
