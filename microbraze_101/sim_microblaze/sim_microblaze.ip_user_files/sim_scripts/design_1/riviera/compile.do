transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/microblaze_v11_0_14
vlib riviera/xil_defaultlib
vlib riviera/lmb_v10_v3_0_14
vlib riviera/lmb_bram_if_cntlr_v4_0_25
vlib riviera/blk_mem_gen_v8_4_9
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/mdm_v3_2_27
vlib riviera/lib_cdc_v1_0_3
vlib riviera/proc_sys_reset_v5_0_16
vlib riviera/sim_clk_gen_v1_0_5
vlib riviera/lib_pkg_v1_0_4
vlib riviera/lib_srl_fifo_v1_0_4
vlib riviera/axi_uartlite_v2_0_37
vlib riviera/xlconstant_v1_1_9
vlib riviera/smartconnect_v1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_33
vlib riviera/axi_vip_v1_1_19

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap microblaze_v11_0_14 riviera/microblaze_v11_0_14
vmap xil_defaultlib riviera/xil_defaultlib
vmap lmb_v10_v3_0_14 riviera/lmb_v10_v3_0_14
vmap lmb_bram_if_cntlr_v4_0_25 riviera/lmb_bram_if_cntlr_v4_0_25
vmap blk_mem_gen_v8_4_9 riviera/blk_mem_gen_v8_4_9
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap mdm_v3_2_27 riviera/mdm_v3_2_27
vmap lib_cdc_v1_0_3 riviera/lib_cdc_v1_0_3
vmap proc_sys_reset_v5_0_16 riviera/proc_sys_reset_v5_0_16
vmap sim_clk_gen_v1_0_5 riviera/sim_clk_gen_v1_0_5
vmap lib_pkg_v1_0_4 riviera/lib_pkg_v1_0_4
vmap lib_srl_fifo_v1_0_4 riviera/lib_srl_fifo_v1_0_4
vmap axi_uartlite_v2_0_37 riviera/axi_uartlite_v2_0_37
vmap xlconstant_v1_1_9 riviera/xlconstant_v1_1_9
vmap smartconnect_v1_0 riviera/smartconnect_v1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_33 riviera/axi_register_slice_v2_1_33
vmap axi_vip_v1_1_19 riviera/axi_vip_v1_1_19

vlog -work xilinx_vip  -incr "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"/tools/Xilinx/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v11_0_14 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/a243/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_microblaze_0_1/sim/design_1_microblaze_0_1.vhd" \

vcom -work lmb_v10_v3_0_14 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/7495/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_dlmb_v10_0/sim/design_1_dlmb_v10_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_v10_0/sim/design_1_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_25 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/73e9/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_dlmb_bram_if_cntlr_0/sim/design_1_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_bram_if_cntlr_0/sim/design_1_ilmb_bram_if_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_9  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/5ec1/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_lmb_bram_0/sim/design_1_lmb_bram_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_v3_2_27 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/da3a/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_mdm_1_0/sim/design_1_mdm_1_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_1_0/design_1_clk_wiz_1_0.v" \

vcom -work lib_cdc_v1_0_3 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/2a4f/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_16 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0831/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_rst_clk_wiz_1_100M_0/sim/design_1_rst_clk_wiz_1_100M_0.vhd" \

vlog -work sim_clk_gen_v1_0_5  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/e8d4/hdl/sim_clk_gen_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_sim_clk_gen_0_1/sim/design_1_sim_clk_gen_0_1.v" \

vcom -work lib_pkg_v1_0_4 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/8c68/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_4 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/1e5a/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_37 -93  -incr \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/9a87/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_uartlite_0_0/sim/design_1_axi_uartlite_0_0.vhd" \

vlog -work xlconstant_v1_1_9  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/e2d2/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_0/sim/bd_afc3_one_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_1/sim/bd_afc3_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f49a/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_2/sim/bd_afc3_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_3/sim/bd_afc3_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/63ed/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_4/sim/bd_afc3_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_5/sim/bd_afc3_s00a2s_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_6/sim/bd_afc3_sarn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_7/sim/bd_afc3_srn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_8/sim/bd_afc3_sawn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_9/sim/bd_afc3_swn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_10/sim/bd_afc3_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_11/sim/bd_afc3_m00s2a_0.sv" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/37bc/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_12/sim/bd_afc3_m00e_0.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/sim/bd_afc3.v" \

vlog -work smartconnect_v1_0  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_33  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3ee4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_19  -incr "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/8c45/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/3cbc" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/0127/hdl/verilog" "+incdir+../../../../sim_microblaze.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+/tools/Xilinx/Vivado/2024.2/data/xilinx_vip/include" -l xilinx_vip -l xpm -l microblaze_v11_0_14 -l xil_defaultlib -l lmb_v10_v3_0_14 -l lmb_bram_if_cntlr_v4_0_25 -l blk_mem_gen_v8_4_9 -l axi_lite_ipif_v3_0_4 -l mdm_v3_2_27 -l lib_cdc_v1_0_3 -l proc_sys_reset_v5_0_16 -l sim_clk_gen_v1_0_5 -l lib_pkg_v1_0_4 -l lib_srl_fifo_v1_0_4 -l axi_uartlite_v2_0_37 -l xlconstant_v1_1_9 -l smartconnect_v1_0 -l axi_infrastructure_v1_1_0 -l axi_register_slice_v2_1_33 -l axi_vip_v1_1_19 \
"../../../bd/design_1/ip/design_1_axi_smc_0/sim/design_1_axi_smc_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

