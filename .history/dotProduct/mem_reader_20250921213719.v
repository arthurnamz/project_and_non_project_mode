`timescale 1ns / 1ps

// Memory Reader Module
// Reads data from mem1 and mem2 and provides direct outputs
// Modified to give outputs directly from mem1 and mem2

module mem_reader #(
    parameter DATA_WIDTH = 8,
    parameter VECTOR_WIDTH = 4,
    parameter DEPTH = VECTOR_WIDTH * DATA_WIDTH,
    parameter ADDR_WIDTH = 5
)(
    input clk,
    input rst_n,
    
    // Control signals
    input start_reading,
    output reg reading_done,
    
    // Read control for mem1 and mem2
    output reg rd_en_mem1,
    output reg rd_en_mem2,
    output reg [ADDR_WIDTH-1:0] rd_addr_mem1,
    output reg [ADDR_WIDTH-1:0] rd_addr_mem2,
    
    // Direct outputs from mem1 and mem2
    output wire [DATA_WIDTH-1:0] mem1_output,
    output wire [DATA_WIDTH-1:0] mem2_output,
    
    // Status signals
    output reg data_valid,
    output reg [2:0] element_count
);

    // Internal signals
    reg [ADDR_WIDTH-1:0] read_counter;
    reg reading_state;
    
    // Memory instances
    mem1 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(DEPTH)
    ) u_mem1 (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(1'b0),        // No write operation
        .write_address({ADDR_WIDTH{1'b0}}), // Not used
        .data_in({DATA_WIDTH{1'b0}}),       // Not used
        .read_en(rd_en_mem1),
        .read_address(rd_addr_mem1),
        .data_out(mem1_output)
    );

    mem2 #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH),
        .MEM_SIZE(DEPTH)
    ) u_mem2 (
        .clk(clk),
        .rst_n(rst_n),
        .write_en(1'b0),        // No write operation
        .write_address({ADDR_WIDTH{1'b0}}), // Not used
        .data_in({DATA_WIDTH{1'b0}}),       // Not used
        .read_en(rd_en_mem2),
        .read_address(rd_addr_mem2),
        .data_out(mem2_output)
    );

    // Main control logic
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
                // Start reading sequence
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
                    // Continue reading
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
                    // Reading complete
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
