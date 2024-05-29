`ifndef CALLBACKS__SV
`define CALLBACKS__SV

class A extends uvm_callback;
    //UVM 1.2 需要加
    `uvm_object_utils(A)
    function new(string name = "A");
        super.new(name);
    endfunction

    // //繼承用 virtual
    // virtual task pre_tran(my_driver drv, ref my_transaction tr);endtask

    my_transaction tr;
   
    virtual function bit gen_tran();
    endfunction

    virtual task run(my_driver drv, uvm_phase phase);
        phase.raise_objection(drv);
        
        drv.vif.data <= 8'b0;
        drv.vif.valid <= 1'b0;
        while(!drv.vif.rst_n)
            @(posedge drv.vif.clk);

        while(gen_tran()) begin
            drv.drive_one_pkt(tr);
        end 
        phase.drop_objection(drv);
    endtask
    
endclass

typedef uvm_callbacks#(my_driver, A) A_pool; //指定pool

`endif
