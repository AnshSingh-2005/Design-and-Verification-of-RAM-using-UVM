module simple_ram #(
    parameter int DATA_WIDTH = 8,
    parameter int ADDR_WIDTH = 4    // DEPTH = 2^ADDR_WIDTH
)(
    input  logic                     clk,
    input  logic                     we,
    input  logic [ADDR_WIDTH-1:0]     addr,
    input  logic [DATA_WIDTH-1:0]     wdata,
    output logic [DATA_WIDTH-1:0]     rdata
);

    localparam int DEPTH = 1 << ADDR_WIDTH;

    // Memory declaration
    logic [DATA_WIDTH-1:0] mem [DEPTH];

    // Write operation (synchronous)
    always_ff @(posedge clk) begin
        if (we) begin
            mem[addr] <= wdata;
        end
    end

    // Read operation (asynchronous)
    always_comb begin
        rdata = mem[addr];
    end

endmodule
