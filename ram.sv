module dual_port_ram (
    clk,
    rst,
    cs,
    w_en,
    r_en,
    w_addr,
    r_addr,
    w_data,
    r_data
);

    // Parameters
    parameter addr_width = 4;
    parameter data_width = 8;
    parameter depth      = 16;   // total 16 locations

    // Inputs
    input                  clk;
    input                  rst;
    input                  cs;
    input                  w_en;
    input                  r_en;
    input  [addr_width-1:0] w_addr;
    input  [addr_width-1:0] r_addr;
    input  [data_width-1:0] w_data;

    // Outputs
    output reg [data_width-1:0] r_data;

    // Memory declaration
    reg [data_width-1:0] mem [depth-1:0];

    integer i;

    // Sampling operation at posedge of clk
    always @(posedge clk)
    begin
        if (!rst)
        begin
            if (cs)
            begin
                if (w_en)        // it want to write data into mem loc
                    mem[w_addr] <= w_data;

                if (r_en)
                    r_data <= mem[r_addr];
            end
        end
        else                  // Resetting everything
        begin
            r_data <= 0;
            for (i = 0; i < depth; i = i + 1)
                mem[i] <= 0;
        end
    end

endmodule
