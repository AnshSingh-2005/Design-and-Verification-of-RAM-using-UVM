// ram_trans.svh (declares signal to rand on non-read type)

`include "uvm_macros.svh"
import uvm_pkg::*;

class ram_trans extends uvm_sequence_item;

  // Enum : Type of transaction
  typedef enum {WRITE, READ, SIM_RW, IDLE} case_e;

  // Transaction fields
  rand bit               w_en;
  rand bit               r_en;
  rand bit [ADDR_WIDTH-1:0] w_addr;
  rand bit [ADDR_WIDTH-1:0] r_addr;
  rand bit [DATA_WIDTH-1:0] w_data;
       bit [DATA_WIDTH-1:0] r_data;
       bit               cs;      // chip select (driven by env/agent)
  rand case_e            cases;

  // Min / Max address constraints
  rand int unsigned min_addr = 0;
  rand int unsigned max_addr = (1 << ADDR_WIDTH) - 1;

  // Constraints
  constraint addr_range_c {
    w_addr inside {[min_addr : max_addr]};
    r_addr inside {[min_addr : max_addr]};
  }

  // UVM field registration (field macros to print the fields)
  `uvm_object_utils_begin(ram_trans)
    `uvm_field_enum(case_e, cases,   UVM_ALL_ON)
    `uvm_field_int (w_addr,           UVM_ALL_ON)
    `uvm_field_int (r_addr,           UVM_ALL_ON)
    `uvm_field_int (w_data,           UVM_ALL_ON)
    `uvm_field_int (r_data,           UVM_ALL_ON)
    `uvm_field_int (w_en,             UVM_ALL_ON)
    `uvm_field_int (r_en,             UVM_ALL_ON)
    `uvm_field_int (cs,               UVM_ALL_ON)
    `uvm_field_int (min_addr,         UVM_ALL_ON)
    `uvm_field_int (max_addr,         UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "ram_trans");
    super.new(name);
  endfunction

  // Custom do_print overridden
  function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("cs",       cs,        1);
    printer.print_field("w_en",     w_en,      1);
    printer.print_field("r_en",     r_en,      1);
    printer.print_field("w_addr",   w_addr,    ADDR_WIDTH);
    printer.print_field("r_addr",   r_addr,    ADDR_WIDTH);
    printer.print_field("w_data",   w_data,    DATA_WIDTH);
    printer.print_field("r_data",   r_data,    DATA_WIDTH);
    printer.print_string("cases",   cases.name());
    printer.print_field("min_addr", min_addr,  32);
    printer.print_field("max_addr", max_addr,  32);

  endfunction

endclass
