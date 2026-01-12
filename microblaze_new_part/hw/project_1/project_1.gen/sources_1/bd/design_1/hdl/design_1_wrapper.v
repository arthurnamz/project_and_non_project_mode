//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
//Date        : Sat Jan 10 07:11:32 2026
//Host        : arthur-nathaniel running 64-bit Ubuntu 24.04.3 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk,
    gpio_tri_o,
    reset,
    uart_rxd,
    uart_txd);
  input clk;
  output [1:0]gpio_tri_o;
  input reset;
  input uart_rxd;
  output uart_txd;

  wire clk;
  wire [1:0]gpio_tri_o;
  wire reset;
  wire uart_rxd;
  wire uart_txd;

  design_1 design_1_i
       (.clk(clk),
        .gpio_tri_o(gpio_tri_o),
        .reset(reset),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));
endmodule
