`include "uvm_macros.svh"
import uvm_pkg::*;
`include "ram_pkg.sv"   // separate file

module tb;

  import ram_pkg::*;

  bit clk;   // physical signals
  bit rst;

  // Interface instance
  ram_if intf (.clk(clk));

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // DUT instantiation
  dual_port_ram dut (
    .clk     (intf.clk),     // Driver is in interface only
    .rst     (intf.rst),     // From interface, RTL is going to collect the signal
    .w_en    (intf.w_en),
    .r_en    (intf.r_en),
    .w_addr  (intf.w_addr),
    .r_addr  (intf.r_addr),
    .w_data  (intf.w_data),
    .r_data  (intf.r_data),
    .cs      (intf.cs)
  );

  // Reset task
  task automatic reset();
    rst = 1;
    intf.rst = 1;
    #20;
    rst = 0;
    intf.rst = 0;
    `uvm_info("TB", "Reset Deasserted", UVM_LOW)
  endtask

  // Simulation initialization
  initial begin
    // Set virtual interface in config DB
    uvm_config_db#(virtual ram_if)::set(null, "*", "vif", intf);

    // To pass something to your respective component,
    // we are using configuration database

    $dumpfile("dump.vcd");
    $dumpvars();
  end

  initial begin
    fork
      reset();
      run_test("ram_base_test"); // Run randomly
    join
  end

endmodule
