module tb_ram;

    parameter ADDR_WIDTH = 4;
    parameter DATA_WIDTH = 8;

    logic clk;
    logic we;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] din;
    logic [DATA_WIDTH-1:0] dout;

    // DUT instantiation
    ram #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Scoreboard memory
    logic [DATA_WIDTH-1:0] golden_mem [0:(1<<ADDR_WIDTH)-1];

    initial begin
        clk = 0;
        we  = 0;
        addr = 0;
        din  = 0;

        // Initialize scoreboard
        foreach (golden_mem[i])
            golden_mem[i] = 0;

        // ---------------- WRITE PHASE ----------------
        $display("Starting WRITE phase...");
        repeat (10) begin
            @(posedge clk);
            we   = 1;
            addr = $urandom_range(0, (1<<ADDR_WIDTH)-1);
            din  = $urandom_range(0, 255);
            golden_mem[addr] = din;
        end

        // ---------------- READ + CHECK PHASE ----------------
        $display("Starting READ phase...");
        we = 0;

        repeat (10) begin
            @(posedge clk);
            addr = $urandom_range(0, (1<<ADDR_WIDTH)-1);

            @(posedge clk);   // wait for read data

            if (dout !== golden_mem[addr])
                $error("Mismatch at addr=%0d | Expected=%0h Actual=%0h",
                        addr, golden_mem[addr], dout);
            else
                $display("PASS: addr=%0d data=%0h", addr, dout);
        end

        $display("Simulation completed.");
        $finish;
    end

endmodule
