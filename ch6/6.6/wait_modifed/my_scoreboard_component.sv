`ifndef MY_SCOREBOARD__SV
`define MY_SCOREBOARD__SV

// `uvm_analysis_imp_decl(_monitor) //imp+後綴
// `uvm_analysis_imp_decl(_model)

class my_scoreboard extends uvm_scoreboard;
    my_transaction  expect_queue[$];

    // 收兩個IMP
    uvm_blocking_get_port #(my_transaction)  exp_port;
    uvm_blocking_get_port #(my_transaction)  act_port;
    `uvm_component_utils(my_scoreboard)

    extern function new(string name, uvm_component parent = null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task main_phase(uvm_phase phase);
endclass 

function my_scoreboard::new(string name, uvm_component parent = null);
    super.new(name, parent);
endfunction 

function void my_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
endfunction 

task my_scoreboard::main_phase(uvm_phase phase);
    my_transaction  get_expect,  get_actual, tmp_tran;
    bit result;
    bit cmp_en = 1'b1;
    
    super.main_phase(phase);
    fork 
        //等待 get 到參數 cmp_en
        while(1) begin
            uvm_config_db#(bit)::wait_modified(this, "", "cmp_en");
            void'(uvm_config_db#(bit)::get(this, "", "cmp_en", cmp_en)); 
            `uvm_info("my_scoreboard", $sformatf("cmp_en value modified, the new value is %0d", cmp_en), UVM_LOW)
        end

        while (1) begin
            exp_port.get(get_expect);
            expect_queue.push_back(get_expect);
        end
        while (1) begin
            act_port.get(get_actual);
            if(expect_queue.size() > 0) begin
                tmp_tran = expect_queue.pop_front();
                result = get_actual.compare(tmp_tran);
                if(result) begin 
                `uvm_info("my_scoreboard", "Compare SUCCESSFULLY", UVM_LOW);
                end
                else begin
                `uvm_error("my_scoreboard", "Compare FAILED");
                $display("the expect pkt is");
                tmp_tran.print();
                $display("the actual pkt is");
                get_actual.print();
                end
            end
            else begin
                `uvm_error("my_scoreboard", "Received from DUT, while Expect Queue is empty");
                $display("the unexpected pkt is");
                get_actual.print();
            end 
        end
    join
endtask

`endif
