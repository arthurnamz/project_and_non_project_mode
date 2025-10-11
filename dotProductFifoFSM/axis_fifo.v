`timescale 1ns / 1ps

module axis_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8,
    parameter ADDR_WIDTH = 3
)
(
    input clk,
    input rstn,

    //Slave interface (reacing data)
    input [DATA_WIDTH-1:0] s_axis_tdata,
    input s_axis_tvalid,    
    output s_axis_tready,

    //Master interface (sending data)
    output [DATA_WIDTH-1:0] m_axis_tdata,
    output m_axis_tvalid,
    input m_axis_tready
);

    wire full;
    wire empty;

    assign s_axis_tready = ~full;
    assign m_axis_tvalid = ~empty;

    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) fifo_inst (
        .clk(clk),
        .rstn(rstn),

        .data_in(s_axis_tdata),
        .wr_en(s_axis_tvalid),
        .full(full),

        .data_out(m_axis_tdata),
        .rd_en(m_axis_tready),
        .empty(empty)
    );

endmodule