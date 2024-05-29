`ifndef CALLBACKS__SV
`define CALLBACKS__SV

class A extends uvm_callback;
    //UVM 1.2 需要加
    `uvm_object_utils(A)
    function new(string name = "A");
        super.new(name);
    endfunction

    //繼承用 virtual
    virtual task pre_tran(my_driver drv, ref my_transaction tr);endtask
endclass

typedef uvm_callbacks#(my_driver, A) A_pool; //指定pool

`endif
