// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module design_1 (
  rst,
  uart_rxd,
  uart_txd,
  clk_out
);

  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST RST" *)
  (* X_INTERFACE_MODE = "slave RST.RST" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *)
  input rst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart RxD" *)
  (* X_INTERFACE_MODE = "master uart" *)
  input uart_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart TxD" *)
  output uart_txd;
  (* X_INTERFACE_IGNORE = "true" *)
  output clk_out;

  // stub module has no contents

endmodule
