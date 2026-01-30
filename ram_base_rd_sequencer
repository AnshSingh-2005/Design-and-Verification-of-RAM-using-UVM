`include "uvm_macros.svh"
import uvm_pkg::*;


class ram_base_wr_seq extends uvm_sequence #(ram_trans);   // request = ram_trans

  // uvm_object_utils (ram_base_wr_seq)
  // it includes macros to register your particular
  // class in factory to get all factory method
  `uvm_object_utils(ram_base_wr_seq)

  ram_trans trans;    // handle to randomize everything

  // constructor
  function new(string name = "ram_base_wr_seq");
    super.new(name);  // default type so as it is original
  endfunction

  // virtual task body()
  virtual task body();

    // To invoke start method, we need handle
    `uvm_info(get_type_name(),
              "Executing base READ seq",
              UVM_LOW)    // verbosity to set priority of msg

    repeat (no_of_tr) begin

      // trans ram_trans::type_id::create
      trans = ram_trans::type_id::create("trans");

      start_item(trans);   // if driver sends req it will pass the transaction

      if (!trans.randomize() with { trans.kind == READ; }) begin
        `uvm_error(get_type_name(), "Randomization failed")
      end

      finish_item(trans);  // driver acknowledges

    end

  endtask

endclass

'endif
