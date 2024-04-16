`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

class my_driver extends uvm_driver;
    virtual my_if vif; //2.2.4 virtual interface in class

    /* factory 通常會搭配 objection raise+drop 達成 $finish 作用 */
    `uvm_component_utils(my_driver); //2.2.2: factory
    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("my_driver", "new is called", UVM_LOW); //UVM_LOW: log priority
    endfunction

    /* 綁定 top(testbench) 跟 driver 的 virtual interface : uvm_config_db<get> 靜態函數 */
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("my_driver", "build_phase is called", UVM_LOW);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif)) // get
            `uvm_fatal("my_driver", "virtual interface must be set for vif!!!") //fatal = msg error + $finish
    endfunction

    extern virtual task main_phase(uvm_phase phase); //可不用 virtual, 但要確保有定義
    extern virtual task drive_one_pkt(my_transaction tr);
endclass

task my_driver::main_phase(uvm_phase phase);
    my_transaction tr; //2.3.2 引入transaction

    /* objection 必須在第一個仿真耗時前 ex: @(posedge top_tb.clk); */
    phase.raise_objection(this); //2.2.3: objection
    `uvm_info("my_driver", "main_phase is called", UVM_LOW);
    vif.data <= 8'b0;   //top_tb.rxd <= 8'b0; 
    vif.valid <= 1'b0;  //top_tb.rx_dv <= 1'b0;
    
    while(!vif.rst_n)       //while(!top_tb.rst_n)
        @(posedge vif.clk); //    @(posedge top_tb.clk);
    
    for(int i = 0; i < 2; i++) begin 
        tr = new("tr"); //2.3.2 引入transaction
        assert(tr.randomize() with {pload.size == 200;});
        drive_one_pkt(tr);
    end
    repeat(5) @(posedge vif.clk);
    phase.drop_objection(this); //2.2.3: objection
endtask

// 2.3.2 引入transaction
task my_driver::drive_one_pkt(my_transaction tr);
    // bit [47:0] tmp_data;
    // bit [7:0] data_q[$];

    byte unsigned  data_q[];
    int  data_size;
    
    /*
    //push dmac to data_q
    tmp_data = tr.dmac;
    for(int i = 0; i < 6; i++) begin
        data_q.push_back(tmp_data[7:0]);
        tmp_data = (tmp_data >> 8);
    end
    //push smac to data_q
    tmp_data = tr.smac;
    for(int i = 0; i < 6; i++) begin
        data_q.push_back(tmp_data[7:0]);
        tmp_data = (tmp_data >> 8);
    end
    //push ether_type to data_q
    tmp_data = tr.ether_type;
    for(int i = 0; i < 2; i++) begin
        data_q.push_back(tmp_data[7:0]);
        tmp_data = (tmp_data >> 8);
    end
    //push payload to data_q
    for(int i = 0; i < tr.pload.size; i++) begin
        data_q.push_back(tr.pload[i]);
    end
    //push crc to data_q
    tmp_data = tr.crc;
    for(int i = 0; i < 4; i++) begin
        data_q.push_back(tmp_data[7:0]);
        tmp_data = (tmp_data >> 8);
    end

    `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
    repeat(3) @(posedge vif.clk);

    while(data_q.size() > 0) begin
        @(posedge vif.clk);
        vif.valid <= 1'b1;
        vif.data <= data_q.pop_front(); 
    end
    */

    /* 2.3.7 : uvm_field 內建 print.copy.compare */
    data_size = tr.pack_bytes(data_q) / 8; 
    `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);
    repeat(3) @(posedge vif.clk);
    for ( int i = 0; i < data_size; i++ ) begin
        @(posedge vif.clk);
        vif.valid <= 1'b1;
        vif.data <= data_q[i]; 
    end

    @(posedge vif.clk);
    vif.valid <= 1'b0;
    `uvm_info("my_driver", "end drive one pkt", UVM_LOW);
endtask

`endif