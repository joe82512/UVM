`ifndef BUS_TRANSACTION__SV
`define BUS_TRANSACTION__SV

typedef enum{BUS_RD, BUS_WR} bus_op_e;

// class bus_transaction extends uvm_sequence_item;
class bus_transaction#(int ADDR_WIDTH=16, int DATA_WIDTH=16) extends uvm_sequence_item;

    // rand bit[15:0] rd_data;
    // rand bit[15:0] wr_data;
    // rand bit[15:0] addr;
    rand bit[DATA_WIDTH-1:0] rd_data;
    rand bit[DATA_WIDTH-1:0] wr_data;
    rand bit[ADDR_WIDTH-1:0] addr;

    rand bus_op_e  bus_op;

    // `uvm_object_utils_begin(bus_transaction)
    `uvm_object_utils_begin(bus_transaction#(ADDR_WIDTH, DATA_WIDTH))
        `uvm_field_int(rd_data, UVM_ALL_ON)
        `uvm_field_int(wr_data, UVM_ALL_ON)
        `uvm_field_int(addr   , UVM_ALL_ON)
        `uvm_field_enum(bus_op_e, bus_op, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "bus_transaction");
        super.new();
    endfunction

endclass
`endif
