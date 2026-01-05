// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module design_1 (
  uart_rxd,
  uart_txd,
  gpio_tri_o,
  reset,
  clk_out
);

  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart RxD" *)
  (* X_INTERFACE_MODE = "master uart" *)
  input uart_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart TxD" *)
  output uart_txd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 gpio TRI_O" *)
  (* X_INTERFACE_MODE = "master gpio" *)
  output [31:0]gpio_tri_o;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET RST" *)
  (* X_INTERFACE_MODE = "slave RST.RESET" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input reset;
  (* X_INTERFACE_IGNORE = "true" *)
  output clk_out;

  // stub module has no contents

endmodule
