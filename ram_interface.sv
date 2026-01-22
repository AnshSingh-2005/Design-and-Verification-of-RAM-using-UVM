interface ram_if (input clk);

  // Interface signals
  logic cs;        // Some control signal
  logic rst;       // Reset is an output
  logic w_en;      // To avoid ambiguity
  logic r_en;      // Connected to both driver & monitor

  // Driver clocking block to avoid race conditions
  clocking drv_cb @(posedge clk);
    default input #1 output #0;

    output w_en, r_en, w_addr, r_addr,
           w_data, cs;
    input  r_data, rst;
  endclocking

  // Monitor clocking block
  clocking mon_cb @(posedge clk);
    default input #1 output #0;

    input w_en, r_en, w_addr, r_addr,
          w_data, r_data, rst, cs;
  endclocking

  // The component that is communicating
  // with the interface clocking block
  // should be written for that
  
  //Modport(To give direction to the signal)
  modport drv_mp(clocking drv_cb,input clk);
  modport mon_mp(clocking mon_cb,input clk);


endinterface
