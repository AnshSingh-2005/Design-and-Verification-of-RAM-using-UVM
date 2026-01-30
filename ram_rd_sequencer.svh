`include "uvm_macros.svh"
import uvm_pkg::*;

// class ram_rd_sequencer extends uvm_sequencer #(ram_trans)
class ram_rd_sequencer extends uvm_sequencer #(ram_trans);

  // UVM factory registration
  // uvm_component_utils (ram_rd_sequencer)
  `uvm_component_utils(ram_rd_sequencer)

  // constructor
  function new(string name = "ram_rd_sequencer",
               uvm_component parent = null);
    super.new(name, parent);   // this is a component pointing to parent
  endfunction

endclass
