[2024-05-08 14:55:10 UTC] qrun -batch -access=rw+/. -uvmhome uvm-1.2 '-timescale' '1ns/1ns' -mfcu design.sv testbench.sv '-voptargs=+acc=npr'  -do  " run -all; exit"  
QuestaSim-64 qrun 2023.1 Utility 2023.01 Jan 23 2023
Start time: 10:55:10 on May 08,2024
qrun -batch -access=rw+/. -uvmhome uvm-1.2 -timescale 1ns/1ns -mfcu design.sv testbench.sv -voptargs="+acc=npr" -do " run -all; exit" 
Creating library 'qrun.out/work'.
Mapping library 'mtiUvm' to 'qrun.out/work'.
QuestaSim-64 vlog 2023.1 Compiler 2023.01 Jan 23 2023
Start time: 10:55:10 on May 08,2024
vlog -timescale 1ns/1ns -mfcu -ccflags "-Wno-missing-declarations" -ccflags "-Wno-maybe-uninitialized" -ccflags "-Wno-return-type" -ccflags "-DQUESTA" /usr/share/questa/questasim/verilog_src/uvm-1.2/src/dpi/uvm_dpi.cc /usr/share/questa/questasim/verilog_src/uvm-1.2/src/uvm_pkg.sv /usr/share/questa/questasim/verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv design.sv testbench.sv -work qrun.out/work "+incdir+/usr/share/questa/questasim/verilog_src/uvm-1.2/src" -csession=incr -writesessionid "+qrun.out/top_dus" -statslog qrun.out/stats_log 
-- Compiling package uvm_pkg (uvm-1.2 Built-in)
-- Compiling package questa_uvm_pkg
-- Importing package uvm_pkg (uvm-1.2 Built-in)
-- Compiling module dut
-- Compiling package uvm_pkg_sv_unit
-- Importing package uvm_pkg (uvm-1.2 Built-in)
-- Compiling interface my_if
-- Compiling module top_tb

Top level modules:
	top_tb
-- Compiling DPI/PLI C++ file /usr/share/questa/questasim/verilog_src/uvm-1.2/src/dpi/uvm_dpi.cc

In file included from /usr/share/questa/questasim/verilog_src/uvm-1.2/src/dpi/uvm_hdl.c:27,
                 from /usr/share/questa/questasim/verilog_src/uvm-1.2/src/dpi/uvm_dpi.cc:37:
/usr/share/questa/questasim/verilog_src/uvm-1.2/src/dpi/uvm_hdl_questa.c: In function 'int uvm_is_vhdl_path(char*)':
/usr/share/questa/questasim/verilog_src/uvm-1.2/src/dpi/uvm_hdl_questa.c:90:12: warning: 'char* strncpy(char*, const char*, size_t)' specified bound depends on the length of the source argument [-Wstringop-overflow=]
   90 |     strncpy(path_copy, path, path_len);
      |     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/share/questa/questasim/verilog_src/uvm-1.2/src/dpi/uvm_hdl_questa.c:72:20: note: length computed here
   72 |   path_len = strlen(path);
      |              ~~~~~~^~~~~~

End time: 10:55:13 on May 08,2024, Elapsed time: 0:00:03
Errors: 0, Warnings: 0
QuestaSim-64 vopt 2023.1 Compiler 2023.01 Jan 23 2023
** Warning: (vopt-10587) Some optimizations are turned off because the +acc switch is in effect. This will cause your simulation to run slowly. Please use -access/-debug to maintain needed visibility.
Start time: 10:55:13 on May 08,2024
vopt -access=rw+/. -timescale 1ns/1ns -mfcu "+acc=npr" -findtoplevels /home/runner/qrun.out/work+0+ -work qrun.out/work -statslog qrun.out/stats_log -o qrun_opt 

Top level modules:
	top_tb

Analyzing design...
-- Loading module top_tb
-- Loading package questa_uvm_pkg
-- Loading interface my_if
-- Loading module dut
Optimizing 7 design-units (inlining 0/4 module instances):
-- Optimizing package uvm_pkg (uvm-1.2 Built-in)(fast)
-- Optimizing package questa_uvm_pkg(fast)
-- Optimizing package uvm_pkg_sv_unit(fast)
-- Optimizing module top_tb(fast)
-- Optimizing module dut(fast)
-- Optimizing interface my_if(fast__2)
-- Optimizing interface my_if(fast)
Optimized design name is qrun_opt
End time: 10:55:20 on May 08,2024, Elapsed time: 0:00:07
Errors: 0, Warnings: 1
# vsim -batch -voptargs="+acc=npr" -lib qrun.out/work -do " run -all; exit" -statslog qrun.out/stats_log qrun_opt -appendlog -l qrun.log -csession=incr 
# Start time: 10:55:20 on May 08,2024
# Loading /tmp/unknown@31ca901f270e_dpi_9/linux_x86_64_gcc-10.3.0/export_tramp.so
# //  Questa Sim-64
# //  Version 2023.1 linux_x86_64 Jan 23 2023
# //
# //  Copyright 1991-2023 Mentor Graphics Corporation
# //  All Rights Reserved.
# //
# //  QuestaSim and its associated documentation contain trade
# //  secrets and commercial or financial information that are the property of
# //  Mentor Graphics Corporation and are privileged, confidential,
# //  and exempt from disclosure under the Freedom of Information Act,
# //  5 U.S.C. Section 552. Furthermore, this information
# //  is prohibited from disclosure under the Trade Secrets Act,
# //  18 U.S.C. Section 1905.
# //
# Loading sv_std.std
# Loading work.my_if(fast)
# Loading work.uvm_pkg(fast)
# Loading work.uvm_pkg_sv_unit(fast)
# Loading work.questa_uvm_pkg(fast)
# Loading work.top_tb(fast)
# Loading work.my_if(fast__2)
# Loading work.dut(fast)
# Compiling /tmp/unknown@31ca901f270e_dpi_9/linux_x86_64_gcc-10.3.0/exportwrapper.c
# Loading /tmp/unknown@31ca901f270e_dpi_9/linux_x86_64_gcc-10.3.0/vsim_auto_compile.so
# 
# run -all
# UVM_INFO /usr/share/questa/questasim/verilog_src/uvm-1.2/src/base/uvm_root.svh(392) @ 0: reporter [UVM/RELNOTES] 
# ----------------------------------------------------------------
# UVM-1.2
# (C) 2007-2014 Mentor Graphics Corporation
# (C) 2007-2014 Cadence Design Systems, Inc.
# (C) 2006-2014 Synopsys, Inc.
# (C) 2011-2013 Cypress Semiconductor Corp.
# (C) 2013-2014 NVIDIA Corporation
# ----------------------------------------------------------------
# 
#   ***********       IMPORTANT RELEASE NOTES         ************
# 
#   You are using a version of the UVM library that has been compiled
#   with `UVM_NO_DEPRECATED undefined.
#   See http://www.eda.org/svdb/view.php?id=3313 for more details.
# 
#   You are using a version of the UVM library that has been compiled
#   with `UVM_OBJECT_DO_NOT_NEED_CONSTRUCTOR undefined.
#   See http://www.eda.org/svdb/view.php?id=3770 for more details.
# 
#       (Specify +UVM_NO_RELNOTES to turn off this notice)
# 
# UVM_INFO /usr/share/questa/questasim/verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv(277) @ 0: reporter [Questa UVM] QUESTA_UVM-1.2.3
# UVM_INFO /usr/share/questa/questasim/verilog_src/questa_uvm_pkg-1.2/src/questa_uvm_pkg.sv(278) @ 0: reporter [Questa UVM]  questa_uvm::init(+struct)
# UVM_INFO @ 0: reporter [RNTST] Running test my_case0...
# UVM_INFO my_case0_component.sv(34) @ 0: uvm_test_top.env.i_agt.drv [crc_driver] crc_driver
# UVM_INFO my_driver.sv(40) @ 1100: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(47) @ 2100: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 2300: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 154300: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @857                                      
#   dmac                         integral        48    'he56e3eaa45e8                            
#   smac                         integral        48    'hf391893d6428                            
#   ether_type                   integral        16    'hded6                                    
#   pload                        da(integral)    744   -                                         
#     [0]                        integral        8     'h10                                      
#     [1]                        integral        8     'h4                                       
#     [2]                        integral        8     'h3c                                      
#     [3]                        integral        8     'hdb                                      
#     [4]                        integral        8     'hd2                                      
#     ...                        ...             ...   ...                                       
#     [739]                      integral        8     'h7e                                      
#     [740]                      integral        8     'h87                                      
#     [741]                      integral        8     'h51                                      
#     [742]                      integral        8     'h4a                                      
#     [743]                      integral        8     'hb1                                      
#   crc                          integral        32    'h765f2a                                  
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    1100                                      
#   end_time                     time            64    154300                                    
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 154300: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 154500: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 154500: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @882          
#   dmac             integral        48    'he56e3eaa45e8
#   smac             integral        48    'hf391893d6428
#   ether_type       integral        16    'hded6        
#   pload            da(integral)    744   -             
#     [0]            integral        8     'h10          
#     [1]            integral        8     'h4           
#     [2]            integral        8     'h3c          
#     [3]            integral        8     'hdb          
#     [4]            integral        8     'hd2          
#     ...            ...             ...   ...           
#     [739]          integral        8     'h7e          
#     [740]          integral        8     'h87          
#     [741]          integral        8     'h51          
#     [742]          integral        8     'h4a          
#     [743]          integral        8     'hb1          
#   crc              integral        32    'h765f2a      
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 154700: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 154700: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 155300: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 155500: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 294500: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @870                                      
#   dmac                         integral        48    'hbc8d71a5ce49                            
#   smac                         integral        48    'h5424a99de88                             
#   ether_type                   integral        16    'h23bf                                    
#   pload                        da(integral)    679   -                                         
#     [0]                        integral        8     'h37                                      
#     [1]                        integral        8     'h58                                      
#     [2]                        integral        8     'h38                                      
#     [3]                        integral        8     'h24                                      
#     [4]                        integral        8     'hbf                                      
#     ...                        ...             ...   ...                                       
#     [674]                      integral        8     'hb6                                      
#     [675]                      integral        8     'h36                                      
#     [676]                      integral        8     'h7a                                      
#     [677]                      integral        8     'h8e                                      
#     [678]                      integral        8     'h49                                      
#   crc                          integral        32    'h5dcb0e                                  
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    154300                                    
#   end_time                     time            64    294500                                    
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 294500: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 294700: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 294700: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @914          
#   dmac             integral        48    'hbc8d71a5ce49
#   smac             integral        48    'h5424a99de88 
#   ether_type       integral        16    'h23bf        
#   pload            da(integral)    679   -             
#     [0]            integral        8     'h37          
#     [1]            integral        8     'h58          
#     [2]            integral        8     'h38          
#     [3]            integral        8     'h24          
#     [4]            integral        8     'hbf          
#     ...            ...             ...   ...           
#     [674]          integral        8     'hb6          
#     [675]          integral        8     'h36          
#     [676]          integral        8     'h7a          
#     [677]          integral        8     'h8e          
#     [678]          integral        8     'h49          
#   crc              integral        32    'h5dcb0e      
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 294900: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 294900: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 295500: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 295700: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 586500: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @902                                      
#   dmac                         integral        48    'hc84cde07a7f9                            
#   smac                         integral        48    'h82650cd26600                            
#   ether_type                   integral        16    'he033                                    
#   pload                        da(integral)    1438  -                                         
#     [0]                        integral        8     'h80                                      
#     [1]                        integral        8     'h99                                      
#     [2]                        integral        8     'h73                                      
#     [3]                        integral        8     'h2d                                      
#     [4]                        integral        8     'h75                                      
#     ...                        ...             ...   ...                                       
#     [1433]                     integral        8     'h32                                      
#     [1434]                     integral        8     'he3                                      
#     [1435]                     integral        8     'hbe                                      
#     [1436]                     integral        8     'hc                                       
#     [1437]                     integral        8     'ha3                                      
#   crc                          integral        32    'h2462bd                                  
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    294500                                    
#   end_time                     time            64    586500                                    
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 586500: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 586700: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 586700: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @946          
#   dmac             integral        48    'hc84cde07a7f9
#   smac             integral        48    'h82650cd26600
#   ether_type       integral        16    'he033        
#   pload            da(integral)    1438  -             
#     [0]            integral        8     'h80          
#     [1]            integral        8     'h99          
#     [2]            integral        8     'h73          
#     [3]            integral        8     'h2d          
#     [4]            integral        8     'h75          
#     ...            ...             ...   ...           
#     [1433]         integral        8     'h32          
#     [1434]         integral        8     'he3          
#     [1435]         integral        8     'hbe          
#     [1436]         integral        8     'hc           
#     [1437]         integral        8     'ha3          
#   crc              integral        32    'h2462bd      
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 586900: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 586900: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 587500: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 587700: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 810100: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @934                                      
#   dmac                         integral        48    'h526fe8c22d9c                            
#   smac                         integral        48    'ha9bd1ed74081                            
#   ether_type                   integral        16    'hc5ec                                    
#   pload                        da(integral)    1096  -                                         
#     [0]                        integral        8     'hf3                                      
#     [1]                        integral        8     'h14                                      
#     [2]                        integral        8     'he4                                      
#     [3]                        integral        8     'h90                                      
#     [4]                        integral        8     'hc9                                      
#     ...                        ...             ...   ...                                       
#     [1091]                     integral        8     'h1a                                      
#     [1092]                     integral        8     'hb5                                      
#     [1093]                     integral        8     'hed                                      
#     [1094]                     integral        8     'h6d                                      
#     [1095]                     integral        8     'hfc                                      
#   crc                          integral        32    'h85d16d                                  
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    586500                                    
#   end_time                     time            64    810100                                    
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 810100: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 810300: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 810300: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @978          
#   dmac             integral        48    'h526fe8c22d9c
#   smac             integral        48    'ha9bd1ed74081
#   ether_type       integral        16    'hc5ec        
#   pload            da(integral)    1096  -             
#     [0]            integral        8     'hf3          
#     [1]            integral        8     'h14          
#     [2]            integral        8     'he4          
#     [3]            integral        8     'h90          
#     [4]            integral        8     'hc9          
#     ...            ...             ...   ...           
#     [1091]         integral        8     'h1a          
#     [1092]         integral        8     'hb5          
#     [1093]         integral        8     'hed          
#     [1094]         integral        8     'h6d          
#     [1095]         integral        8     'hfc          
#   crc              integral        32    'h85d16d      
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 810500: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 810500: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 811100: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 811300: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 937700: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @966                                      
#   dmac                         integral        48    'h9ced1e7d7be7                            
#   smac                         integral        48    'h8df2ee62da58                            
#   ether_type                   integral        16    'hd18f                                    
#   pload                        da(integral)    616   -                                         
#     [0]                        integral        8     'h85                                      
#     [1]                        integral        8     'h44                                      
#     [2]                        integral        8     'h2c                                      
#     [3]                        integral        8     'hcb                                      
#     [4]                        integral        8     'hb4                                      
#     ...                        ...             ...   ...                                       
#     [611]                      integral        8     'hd0                                      
#     [612]                      integral        8     'ha8                                      
#     [613]                      integral        8     'h7c                                      
#     [614]                      integral        8     'hd                                       
#     [615]                      integral        8     'h77                                      
#   crc                          integral        32    'h7c67c3                                  
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    810100                                    
#   end_time                     time            64    937700                                    
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 937700: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 937900: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 937900: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @1010         
#   dmac             integral        48    'h9ced1e7d7be7
#   smac             integral        48    'h8df2ee62da58
#   ether_type       integral        16    'hd18f        
#   pload            da(integral)    616   -             
#     [0]            integral        8     'h85          
#     [1]            integral        8     'h44          
#     [2]            integral        8     'h2c          
#     [3]            integral        8     'hcb          
#     [4]            integral        8     'hb4          
#     ...            ...             ...   ...           
#     [611]          integral        8     'hd0          
#     [612]          integral        8     'ha8          
#     [613]          integral        8     'h7c          
#     [614]          integral        8     'hd           
#     [615]          integral        8     'h77          
#   crc              integral        32    'h7c67c3      
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 938100: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 938100: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 938700: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 938900: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 1184900: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @998                                      
#   dmac                         integral        48    'ha355360df3e5                            
#   smac                         integral        48    'hda8be0421065                            
#   ether_type                   integral        16    'h2ac5                                    
#   pload                        da(integral)    1214  -                                         
#     [0]                        integral        8     'h3b                                      
#     [1]                        integral        8     'hc2                                      
#     [2]                        integral        8     'he2                                      
#     [3]                        integral        8     'hbf                                      
#     [4]                        integral        8     'h5a                                      
#     ...                        ...             ...   ...                                       
#     [1209]                     integral        8     'he8                                      
#     [1210]                     integral        8     'hb5                                      
#     [1211]                     integral        8     'hd2                                      
#     [1212]                     integral        8     'h26                                      
#     [1213]                     integral        8     'h6d                                      
#   crc                          integral        32    'h93db4d                                  
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    937700                                    
#   end_time                     time            64    1184900                                   
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 1184900: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 1185100: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 1185100: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @1042         
#   dmac             integral        48    'ha355360df3e5
#   smac             integral        48    'hda8be0421065
#   ether_type       integral        16    'h2ac5        
#   pload            da(integral)    1214  -             
#     [0]            integral        8     'h3b          
#     [1]            integral        8     'hc2          
#     [2]            integral        8     'he2          
#     [3]            integral        8     'hbf          
#     [4]            integral        8     'h5a          
#     ...            ...             ...   ...           
#     [1209]         integral        8     'he8          
#     [1210]         integral        8     'hb5          
#     [1211]         integral        8     'hd2          
#     [1212]         integral        8     'h26          
#     [1213]         integral        8     'h6d          
#   crc              integral        32    'h93db4d      
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 1185300: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 1185300: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 1185900: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 1186100: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 1372300: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @1030                                     
#   dmac                         integral        48    'h13e099efe520                            
#   smac                         integral        48    'h92960889c500                            
#   ether_type                   integral        16    'hf6a4                                    
#   pload                        da(integral)    915   -                                         
#     [0]                        integral        8     'hb0                                      
#     [1]                        integral        8     'h29                                      
#     [2]                        integral        8     'h95                                      
#     [3]                        integral        8     'h62                                      
#     [4]                        integral        8     'h4                                       
#     ...                        ...             ...   ...                                       
#     [910]                      integral        8     'h1d                                      
#     [911]                      integral        8     'h44                                      
#     [912]                      integral        8     'h6                                       
#     [913]                      integral        8     'hd6                                      
#     [914]                      integral        8     'hb9                                      
#   crc                          integral        32    'h67824                                   
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    1184900                                   
#   end_time                     time            64    1372300                                   
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 1372300: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 1372500: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 1372500: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @1074         
#   dmac             integral        48    'h13e099efe520
#   smac             integral        48    'h92960889c500
#   ether_type       integral        16    'hf6a4        
#   pload            da(integral)    915   -             
#     [0]            integral        8     'hb0          
#     [1]            integral        8     'h29          
#     [2]            integral        8     'h95          
#     [3]            integral        8     'h62          
#     [4]            integral        8     'h4           
#     ...            ...             ...   ...           
#     [910]          integral        8     'h1d          
#     [911]          integral        8     'h44          
#     [912]          integral        8     'h6           
#     [913]          integral        8     'hd6          
#     [914]          integral        8     'hb9          
#   crc              integral        32    'h67824       
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 1372700: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 1372700: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 1373300: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 1373500: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 1632100: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @1062                                     
#   dmac                         integral        48    'ha98d183057e6                            
#   smac                         integral        48    'h69dcc6047d81                            
#   ether_type                   integral        16    'heed3                                    
#   pload                        da(integral)    1277  -                                         
#     [0]                        integral        8     'h39                                      
#     [1]                        integral        8     'h22                                      
#     [2]                        integral        8     'heb                                      
#     [3]                        integral        8     'h4d                                      
#     [4]                        integral        8     'h95                                      
#     ...                        ...             ...   ...                                       
#     [1272]                     integral        8     'h8                                       
#     [1273]                     integral        8     'h87                                      
#     [1274]                     integral        8     'h9a                                      
#     [1275]                     integral        8     'hcf                                      
#     [1276]                     integral        8     'h45                                      
#   crc                          integral        32    'h14436                                   
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    1372300                                   
#   end_time                     time            64    1632100                                   
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 1632100: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 1632300: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 1632300: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @1106         
#   dmac             integral        48    'ha98d183057e6
#   smac             integral        48    'h69dcc6047d81
#   ether_type       integral        16    'heed3        
#   pload            da(integral)    1277  -             
#     [0]            integral        8     'h39          
#     [1]            integral        8     'h22          
#     [2]            integral        8     'heb          
#     [3]            integral        8     'h4d          
#     [4]            integral        8     'h95          
#     ...            ...             ...   ...           
#     [1272]         integral        8     'h8           
#     [1273]         integral        8     'h87          
#     [1274]         integral        8     'h9a          
#     [1275]         integral        8     'hcf          
#     [1276]         integral        8     'h45          
#   crc              integral        32    'h14436       
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 1632500: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 1632500: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 1633100: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 1633300: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 1792300: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @1094                                     
#   dmac                         integral        48    'h44e722e4f224                            
#   smac                         integral        48    'hbee2bc063c20                            
#   ether_type                   integral        16    'hf910                                    
#   pload                        da(integral)    779   -                                         
#     [0]                        integral        8     'h93                                      
#     [1]                        integral        8     'h8b                                      
#     [2]                        integral        8     'hf1                                      
#     [3]                        integral        8     'hfd                                      
#     [4]                        integral        8     'h57                                      
#     ...                        ...             ...   ...                                       
#     [774]                      integral        8     'h2f                                      
#     [775]                      integral        8     'ha                                       
#     [776]                      integral        8     'hff                                      
#     [777]                      integral        8     'hf1                                      
#     [778]                      integral        8     'h80                                      
#   crc                          integral        32    'h768f36                                  
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    1632100                                   
#   end_time                     time            64    1792300                                   
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# UVM_INFO my_driver.sv(40) @ 1792300: uvm_test_top.env.i_agt.drv [my_driver] begin to drive one pkt
# UVM_INFO my_monitor.sv(59) @ 1792500: uvm_test_top.env.i_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_model.sv(34) @ 1792500: uvm_test_top.env.mdl [my_model] get one transaction, copy and print it:
# -------------------------------------------------------
# Name               Type            Size  Value         
# -------------------------------------------------------
# uvm_sequence_item  my_transaction  -     @1138         
#   dmac             integral        48    'h44e722e4f224
#   smac             integral        48    'hbee2bc063c20
#   ether_type       integral        16    'hf910        
#   pload            da(integral)    779   -             
#     [0]            integral        8     'h93          
#     [1]            integral        8     'h8b          
#     [2]            integral        8     'hf1          
#     [3]            integral        8     'hfd          
#     [4]            integral        8     'h57          
#     ...            ...             ...   ...           
#     [774]          integral        8     'h2f          
#     [775]          integral        8     'ha           
#     [776]          integral        8     'hff          
#     [777]          integral        8     'hf1          
#     [778]          integral        8     'h80          
#   crc              integral        32    'h768f36      
#   crc_err          integral        1     'h0           
#   sfd_err          integral        1     'h0           
#   pre_err          integral        1     'h0           
# -------------------------------------------------------
# UVM_INFO my_monitor.sv(59) @ 1792700: uvm_test_top.env.o_agt.mon [my_monitor] end collect one pkt
# UVM_INFO my_scoreboard.sv(46) @ 1792700: uvm_test_top.env.scb [my_scoreboard] Compare SUCCESSFULLY
# UVM_INFO my_monitor.sv(47) @ 1793300: uvm_test_top.env.i_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_monitor.sv(47) @ 1793500: uvm_test_top.env.o_agt.mon [my_monitor] begin to collect one pkt
# UVM_INFO my_driver.sv(50) @ 1844700: uvm_test_top.env.i_agt.drv [my_driver] end drive one pkt
# -----------------------------------------------------------------------------------------------
# Name                           Type            Size  Value                                     
# -----------------------------------------------------------------------------------------------
# uvm_sequence_item              my_transaction  -     @1126                                     
#   dmac                         integral        48    'h19416d4016eb                            
#   smac                         integral        48    'h4973206e4689                            
#   ether_type                   integral        16    'h6655                                    
#   pload                        da(integral)    240   -                                         
#     [0]                        integral        8     'h8c                                      
#     [1]                        integral        8     'h97                                      
#     [2]                        integral        8     'h7a                                      
#     [3]                        integral        8     'h40                                      
#     [4]                        integral        8     'h6d                                      
#     ...                        ...             ...   ...                                       
#     [235]                      integral        8     'h76                                      
#     [236]                      integral        8     'h6b                                      
#     [237]                      integral        8     'h98                                      
#     [238]                      integral        8     'hb                                       
#     [239]                      integral        8     'had                                      
#   crc                          integral        32    'hd3b96                                   
#   crc_err                      integral        1     'h0                                       
#   sfd_err                      integral        1     'h0                                       
#   pre_err                      integral        1     'h0                                       
#   begin_time                   time            64    1792300                                   
#   end_time                     time            64    1844700                                   
#   depth                        int             32    'd2                                       
#   parent sequence (name)       string          15    normal_sequence                           
#   parent sequence (full name)  string          42    uvm_test_top.env.i_agt.sqr.normal_sequence
#   sequencer                    string          26    uvm_test_top.env.i_agt.sqr                
# -----------------------------------------------------------------------------------------------
# TEST CASE PASSED
# UVM_INFO /usr/share/questa/questasim/verilog_src/uvm-1.2/src/base/uvm_report_server.svh(847) @ 1844800: reporter [UVM/REPORT/SERVER] 
# --- UVM Report Summary ---
# 
# ** Report counts by severity
# UVM_INFO :   81
# UVM_WARNING :    0
# UVM_ERROR :    0
# UVM_FATAL :    0
# ** Report counts by id
# [Questa UVM]     2
# [RNTST]     1
# [UVM/RELNOTES]     1
# [crc_driver]     1
# [my_driver]    20
# [my_model]     9
# [my_monitor]    38
# [my_scoreboard]     9
# 
# ** Note: $finish    : /usr/share/questa/questasim/verilog_src/uvm-1.2/src/base/uvm_root.svh(517)
#    Time: 1844800 ns  Iteration: 128  Instance: /top_tb
# End time: 10:55:22 on May 08,2024, Elapsed time: 0:00:02
# Errors: 0, Warnings: 0
# *** Summary *********************************************
#     qrun: Errors:   0, Warnings:   0
#     vlog: Errors:   0, Warnings:   0
#     vopt: Errors:   0, Warnings:   1
#     vsim: Errors:   0, Warnings:   0
#   Totals: Errors:   0, Warnings:   1
Done