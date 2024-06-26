`ifndef REG_MODEL__SV
`define REG_MODEL__SV

// reg_field -> reg -> reg_block -> reg_map
// 至少含有一個 reg_block
// reg_map : mapping physical address

// reg_model -> map {global,buf,mac}
//     |_ global_blk (reg_block) -> map
//     |       |_ reg_invert
//     |               |_ reg_data (reg_field)
//     |
//     |_ buf_blk (reg_block) -> map
//     |       |_ reg_depth
//     |               |_ reg_data (reg_field)
//     |
//     |_ mac_blk (reg_block) -> map
//             |_ reg_vlan
//                     |_ reg_data (reg_field)

class reg_invert extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build(); //不是build_phase
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 1, 0, "RW", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_invert)

    function new(input string name="reg_invert");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE); //16是reg數
    endfunction
endclass

class reg_depth extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 16, 0, "RW", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_depth)

    function new(input string name="reg_depth");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class reg_vlan extends uvm_reg;

    rand uvm_reg_field reg_data;

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create("reg_data");
        // parameter: parent, size, lsb_pos, access, volatile, reset value, has_reset, is_rand, individually accessible
        reg_data.configure(this, 10, 0, "RW", 1, 0, 1, 1, 0);
    endfunction

    `uvm_object_utils(reg_vlan)

    function new(input string name="reg_vlan");
        //parameter: name, size, has_coverage
        super.new(name, 16, UVM_NO_COVERAGE);
    endfunction
endclass

class global_blk extends uvm_reg_block;
    rand reg_invert invert;
    
    virtual function void build();
        default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

        invert = reg_invert::type_id::create("invert", , get_full_name());
        invert.configure(this, null, "");
        invert.build();
        default_map.add_reg(invert, 'h9, "RW");
    endfunction

    `uvm_object_utils(global_blk)

    function new(input string name="global_blk");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 
   
endclass

class buf_blk extends uvm_reg_block;
    rand reg_depth depth;
    
    virtual function void build();
        default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

        depth = reg_depth::type_id::create("depth", , get_full_name());
        depth.configure(this, null, "");
        depth.build();
        default_map.add_reg(depth, 'h3, "RW");
    endfunction

    `uvm_object_utils(buf_blk)

    function new(input string name="buf_blk");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 
   
endclass

class mac_blk extends uvm_reg_block;
    rand reg_vlan vlan;
    
    virtual function void build();
        default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);

        vlan = reg_vlan::type_id::create("vlan", , get_full_name());
        vlan.configure(this, null, "");
        vlan.build();
        default_map.add_reg(vlan, 'h40, "RW");
    endfunction

    `uvm_object_utils(mac_blk)

    function new(input string name="mac_blk");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 
   
endclass

class reg_model extends uvm_reg_block;

    rand global_blk gb_ins;
    rand buf_blk    bb_ins;
    rand mac_blk    mb_ins;

    virtual function void build();
        default_map = create_map("default_map", 0, 2, UVM_BIG_ENDIAN, 0);
        gb_ins = global_blk::type_id::create("gb_ins");
        gb_ins.configure(this, "");
        gb_ins.build();
        gb_ins.lock_model();
        default_map.add_submap(gb_ins.default_map, 16'h0);

        bb_ins = buf_blk::type_id::create("bb_ins");
        bb_ins.configure(this, "");
        bb_ins.build();
        bb_ins.lock_model();
        default_map.add_submap(bb_ins.default_map, 16'h1000);

        mb_ins = mac_blk::type_id::create("mb_ins");
        mb_ins.configure(this, "");
        mb_ins.build();
        mb_ins.lock_model();
        default_map.add_submap(mb_ins.default_map, 16'h2000);

    endfunction

    `uvm_object_utils(reg_model)

    function new(input string name="reg_model");
        super.new(name, UVM_NO_COVERAGE);
    endfunction 

endclass

`endif
