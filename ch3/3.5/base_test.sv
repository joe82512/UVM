`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;

    my_env         env;
    
    function new(string name = "base_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction
    
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);

    `uvm_component_utils(base_test);

    UVM_FILE driver_log;

    virtual function void connect_phase(uvm_phase phase);
        // env.set_report_verbosity_level_hier(UVM_NONE); //env以下全關

        driver_log = $fopen("driver.log", "w"); //Show output file after run

        //---> level: 大於不顯示
        // env.in_agt.drv.set_report_verbosity_level(UVM_HIGH);
        // env.in_agt.drv.set_report_id_verbosity("my_driver", UVM_HIGH);

        //---> hier: 連帶往下層設置
        // env.in_agt.set_report_verbosity_level_hier(UVM_HIGH);
        // env.in_agt.set_report_id_verbosity_hier("my_monitor", UVM_HIGH);
        
        //---> override: 改變 msg 等級 , 沒有hier
        // env.in_agt.drv.set_report_severity_override(UVM_WARNING, UVM_ERROR);
        env.in_agt.drv.set_report_severity_id_override(UVM_WARNING, "my_driver", UVM_ERROR); //轉ERROR

        //---> quit_count: UVM_COUNT 達到數量後 $finish , UVM_ERROR 內建
        set_report_max_quit_count(5); //5 個 error msg 就 $finish , 等同 uvm_fatal
        // env.in_agt.drv.set_report_severity_action(UVM_WARNING, UVM_DISPLAY| UVM_COUNT); //warning也加入計算
        // env.in_agt.set_report_severity_action_hier(UVM_WARNING, UVM_DISPLAY| UVM_COUNT);
        
        // env.in_agt.drv.set_report_id_action("my_drv", UVM_DISPLAY| UVM_COUNT); //針對 ID 計數
        // env.in_agt.set_report_id_action_hier("my_drv", UVM_DISPLAY| UVM_COUNT);
        
        env.in_agt.drv.set_report_severity_id_action(UVM_WARNING, "my_drv", UVM_DISPLAY| UVM_COUNT); //ID+msg等級
        // env.in_agt.set_report_severity_id_action_hier(UVM_WARNING, "my_drv", UVM_DISPLAY| UVM_COUNT);

        //---> UVM_STOP: breakpoint
        // env.in_agt.drv.set_report_severity_id_action(UVM_WARNING, "my_drv", UVM_DISPLAY| UVM_STOP); 

        //---> UVM_LOG: 輸出檔案
        env.in_agt.drv.set_report_id_file("my_driver", driver_log); //可加severity
        env.in_agt.drv.set_report_id_action("my_driver", UVM_DISPLAY| UVM_LOG);

        //---> UVM_EXIT: $finsh
        //---> UVM_FATAL: (UVM_DISPLAY| UVM_EXIT)
        //---> UVM_ERROR: (UVM_DISPLAY| UVM_COUNT)
        //---> UVM_NO_ACTION: 連 UVM_DISPALY都沒有

    endfunction

    virtual function void final_phase(uvm_phase phase);
        $fclose(driver_log);
    endfunction

endclass


function void base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env  =  my_env::type_id::create("env", this); 
    // set_report_max_quit_count(5); //5 個 error msg 就 $finish , 等同 uvm_fatal

    uvm_config_db#(int)::set(
        this, 
        "env.in_agt.drv", 
        "pre_num", 
        99          //case.build 預設值99->3(case0)
    );

endfunction

function void base_test::report_phase(uvm_phase phase);
    uvm_report_server server;
    int err_num;
    super.report_phase(phase);

    server = get_report_server();
    err_num = server.get_severity_count(UVM_ERROR);

    if (err_num != 0) begin
        $display("TEST CASE FAILED");
    end
    else begin
        $display("TEST CASE PASSED");
    end

endfunction

`endif
