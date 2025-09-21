`timescale 1ns / 1ps

// Input Memory Wrapper
// Contains mem1, mem2, and mem_reader with shared memory instances
// No mem_controller needed - direct connections

module input_memory_wrapper #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input rst_n,
    
    // Input interface for writing data
    input write_en,
    input [ADDR_WIDTH-1:0] write_addr,
    input [DATA_WIDTH-1:0] data_a,
    input [DATA_WIDTH-1:0] data_b,
    
    // Memory reader control interface
    input start_reading,
    output wire reading_done,
    output wire [DATA_WIDTH-1:0] mem1_output,
    output wire [DATA_WIDTH-1:0] mem2_output,
    output wire data_valid,
    output wire [2:0] element_count
);

    // Shared memory instances - used by both write interface and mem_reader
    mem1 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(DEPTH)
    ) mem1_inst (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .write_address(write_addr),
        .data_in(data_a),
        .read_en(rd_en_mem1),           // Connected to mem_reader
        .read_address(rd_addr_mem1),    // Connected to mem_reader
        .data_out(mem1_output)
    );

    mem2 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(DEPTH)
    ) mem2_inst (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(write_en),
        .write_address(write_addr),
        .data_in(data_b),
        .read_en(rd_en_mem2),           // Connected to mem_reader
        .read_address(rd_addr_mem2),    // Connected to mem_reader
        .data_out(mem2_output)
    );

    // Internal signals for mem_reader control
    reg rd_en_mem1, rd_en_mem2;
    reg [ADDR_WIDTH-1:0] rd_addr_mem1, rd_addr_mem2;
    reg [ADDR_WIDTH-1:0] read_counter;
    reg reading_state;
    reg [2:0] element_counter;

    // Memory reader control logic (extracted from mem_reader)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_en_mem1 <= 1'b0;
            rd_en_mem2 <= 1'b0;
            rd_addr_mem1 <= {ADDR_WIDTH{1'b0}};
            rd_addr_mem2 <= {ADDR_WIDTH{1'b0}};
            read_counter <= {ADDR_WIDTH{1'b0}};
            reading_done <= 1'b0;
            data_valid <= 1'b0;
            element_count <= 3'b0;
            reading_state <= 1'b0;
        end else begin
            reading_done <= 1'b0;
            
            if (start_reading && !reading_state) begin
                reading_state <= 1'b1;
                read_counter <= {ADDR_WIDTH{1'b0}};
                element_count <= 3'b0;
                rd_en_mem1 <= 1'b1;
                rd_en_mem2 <= 1'b1;
                rd_addr_mem1 <= {ADDR_WIDTH{1'b0}};
                rd_addr_mem2 <= {ADDR_WIDTH{1'b0}};
                data_valid <= 1'b1;
            end else if (reading_state) begin
                if (read_counter < DEPTH - 1) begin
                    read_counter <= read_counter + 1'b1;
                    rd_addr_mem1 <= read_counter + 1'b1;
                    rd_addr_mem2 <= read_counter + 1'b1;
                    
                    if (element_count < VECTOR_WIDTH - 1) begin
                        element_count <= element_count + 1'b1;
                    end else begin
                        element_count <= 3'b0;
                    end
                    
                    data_valid <= 1'b1;
                end else begin
                    reading_state <= 1'b0;
                    rd_en_mem1 <= 1'b0;
                    rd_en_mem2 <= 1'b0;
                    data_valid <= 1'b0;
                    reading_done <= 1'b1;
                    element_count <= 3'b0;
                end
            end else begin
                data_valid <= 1'b0;
            end
        end
    end

endmodule