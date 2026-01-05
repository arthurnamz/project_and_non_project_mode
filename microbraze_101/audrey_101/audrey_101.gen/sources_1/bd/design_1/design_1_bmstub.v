// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module design_1 (
  reset_rtl_0,
  clk_out,
  uart_rtl_0_rxd,
  uart_rtl_0_txd
);

  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_RTL_0 RST" *)
  (* X_INTERFACE_MODE = "slave RST.RESET_RTL_0" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_RTL_0, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
  input reset_rtl_0;
  (* X_INTERFACE_IGNORE = "true" *)
  output clk_out;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart_rtl_0 RxD" *)
  (* X_INTERFACE_MODE = "master uart_rtl_0" *)
  input uart_rtl_0_rxd;
  (* X_INTERFACE_INFO = "xilinx.com:interface:uart:1.0 uart_rtl_0 TxD" *)
  output uart_rtl_0_txd;

  // stub module has no contents

endmodule
