// module inputMemory #(
//     parameter DATA_WIDTH = 8,          
//     parameter VECTOR_SIZE = 4,         
//     parameter NUMBER_OF_VECTORS = 16,   
//     parameter ADDR_WIDTH = 10          
// )(
//     input clk,      
//     input rst_n,    
    
//     // port a 
//     input write_enable_a,
//     input [ADDR_WIDTH-1:0] write_address_a,
//     input [DATA_WIDTH-1:0] data_in_a,

//     input read_enable_a,
//     input [ADDR_WIDTH-1:0] read_address_a,
//     output reg [DATA_WIDTH-1:0] data_out_a,
//     // port b
//     input write_enable_b,
//     input [ADDR_WIDTH-1:0] write_address_b,
//     input [DATA_WIDTH-1:0] data_in_b,

//     input read_enable_b,
//     input [ADDR_WIDTH-1:0] read_address_b,
//     output reg [DATA_WIDTH-1:0] data_out_b
// );

//     // Memory array to store the vectors
//     reg [DATA_WIDTH-1:0] mem [0:(NUMBER_OF_VECTORS * VECTOR_SIZE)-1];

//     // Write operation for port A
//     always @(posedge clk) begin
//         if (!rst_n) begin
//             // Reset logic if needed
            
//         end else if (write_enable_a) begin
//             mem[write_address_a] <= data_in_a;
//         end
//     end

//     // Read operation for port A
//     always @(posedge clk) begin
//         if (!rst_n) begin
//             data_out_a <= {DATA_WIDTH{1'b0}};
//         end else if (read_enable_a) begin
//             data_out_a <= mem[read_address_a];
//         end
//     end

//     // Write operation for port B
//     always @(posedge clk) begin
//         if (!rst_n) begin
//             // Reset logic if needed
//         end else if (write_enable_b) begin
//             mem[write_address_b] <= data_in_b;
//         end
//     end

//     // Read operation for port B
//     always @(posedge clk) begin
//         if (!rst_n) begin
//             data_out_b <= {DATA_WIDTH{1'b0}};
//         end else if (read_enable_b) begin
//             data_out_b <= mem[read_address_b];
//         end
//     end

// endmodule