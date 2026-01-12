-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (lin64) Build 5239630 Fri Nov 08 22:34:34 MST 2024
-- Date        : Tue Jan  6 06:22:25 2026
-- Host        : arthur-nathaniel running 64-bit Ubuntu 24.04.3 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/arthur/Documents/FPGA_master_class/project_and_non_project_mode/microblaze_new_part/hw/project_1/project_1.gen/sources_1/bd/design_1/ip/design_1_mysimple_multi_0_0/design_1_mysimple_multi_0_0_sim_netlist.vhdl
-- Design      : design_1_mysimple_multi_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7s50csga324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_mysimple_multi_0_0_mysimple_multi_slave_lite_v1_0_S00_AXI is
  port (
    axi_awready_reg_0 : out STD_LOGIC;
    axi_arready_reg_0 : out STD_LOGIC;
    axi_rvalid_reg_0 : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_bready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_mysimple_multi_0_0_mysimple_multi_slave_lite_v1_0_S00_AXI : entity is "mysimple_multi_slave_lite_v1_0_S00_AXI";
end design_1_mysimple_multi_0_0_mysimple_multi_slave_lite_v1_0_S00_AXI;

architecture STRUCTURE of design_1_mysimple_multi_0_0_mysimple_multi_slave_lite_v1_0_S00_AXI is
  signal \FSM_sequential_state_read[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_read[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_write[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state_write[1]_i_1_n_0\ : STD_LOGIC;
  signal axi_araddr : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \axi_araddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_araddr[3]_i_1_n_0\ : STD_LOGIC;
  signal axi_arready0 : STD_LOGIC;
  signal axi_arready_i_1_n_0 : STD_LOGIC;
  signal \^axi_arready_reg_0\ : STD_LOGIC;
  signal \axi_awaddr[2]_i_1_n_0\ : STD_LOGIC;
  signal \axi_awaddr[3]_i_1_n_0\ : STD_LOGIC;
  signal \axi_awaddr_reg_n_0_[2]\ : STD_LOGIC;
  signal \axi_awaddr_reg_n_0_[3]\ : STD_LOGIC;
  signal \axi_awready0__0\ : STD_LOGIC;
  signal axi_awready_i_1_n_0 : STD_LOGIC;
  signal axi_awready_i_2_n_0 : STD_LOGIC;
  signal \^axi_awready_reg_0\ : STD_LOGIC;
  signal axi_bvalid_i_1_n_0 : STD_LOGIC;
  signal axi_rvalid_i_1_n_0 : STD_LOGIC;
  signal \^axi_rvalid_reg_0\ : STD_LOGIC;
  signal axi_wready_i_1_n_0 : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 31 downto 7 );
  signal \^s00_axi_bvalid\ : STD_LOGIC;
  signal \^s00_axi_wready\ : STD_LOGIC;
  signal slv_reg0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \slv_reg0[15]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg0[23]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg0[31]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg0[7]_i_1_n_0\ : STD_LOGIC;
  signal slv_reg1 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \slv_reg1[15]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg1[23]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg1[31]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg1[7]_i_1_n_0\ : STD_LOGIC;
  signal slv_reg2 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal slv_reg3 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \slv_reg3[15]__0_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg3[19]_i_2_n_0\ : STD_LOGIC;
  signal \slv_reg3[19]_i_3_n_0\ : STD_LOGIC;
  signal \slv_reg3[19]_i_4_n_0\ : STD_LOGIC;
  signal \slv_reg3[23]__0_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg3[23]_i_2_n_0\ : STD_LOGIC;
  signal \slv_reg3[23]_i_3_n_0\ : STD_LOGIC;
  signal \slv_reg3[23]_i_4_n_0\ : STD_LOGIC;
  signal \slv_reg3[23]_i_5_n_0\ : STD_LOGIC;
  signal \slv_reg3[27]_i_2_n_0\ : STD_LOGIC;
  signal \slv_reg3[27]_i_3_n_0\ : STD_LOGIC;
  signal \slv_reg3[27]_i_4_n_0\ : STD_LOGIC;
  signal \slv_reg3[27]_i_5_n_0\ : STD_LOGIC;
  signal \slv_reg3[31]__0_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg3[31]__0_i_2_n_0\ : STD_LOGIC;
  signal \slv_reg3[31]_i_2_n_0\ : STD_LOGIC;
  signal \slv_reg3[31]_i_3_n_0\ : STD_LOGIC;
  signal \slv_reg3[31]_i_4_n_0\ : STD_LOGIC;
  signal \slv_reg3[31]_i_5_n_0\ : STD_LOGIC;
  signal \slv_reg3[7]__0_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_100\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_101\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_102\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_103\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_104\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_105\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_106\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_107\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_108\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_109\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_110\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_111\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_112\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_113\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_114\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_115\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_116\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_117\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_118\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_119\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_120\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_121\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_122\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_123\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_124\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_125\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_126\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_127\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_128\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_129\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_130\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_131\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_132\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_133\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_134\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_135\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_136\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_137\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_138\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_139\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_140\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_141\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_142\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_143\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_144\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_145\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_146\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_147\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_148\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_149\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_150\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_151\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_152\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_153\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_58\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_59\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_60\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_61\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_62\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_63\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_64\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_65\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_66\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_67\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_68\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_69\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_70\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_71\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_72\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_73\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_74\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_75\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_76\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_77\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_78\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_79\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_80\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_81\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_82\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_83\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_84\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_85\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_86\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_87\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_88\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_89\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_90\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_91\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_92\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_93\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_94\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_95\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_96\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_97\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_98\ : STD_LOGIC;
  signal \slv_reg3_reg0__0_n_99\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_100\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_101\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_102\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_103\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_104\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_105\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_58\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_59\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_60\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_61\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_62\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_63\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_64\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_65\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_66\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_67\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_68\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_69\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_70\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_71\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_72\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_73\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_74\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_75\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_76\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_77\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_78\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_79\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_80\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_81\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_82\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_83\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_84\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_85\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_86\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_87\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_88\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_89\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_90\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_91\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_92\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_93\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_94\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_95\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_96\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_97\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_98\ : STD_LOGIC;
  signal \slv_reg3_reg0__1_n_99\ : STD_LOGIC;
  signal slv_reg3_reg0_n_100 : STD_LOGIC;
  signal slv_reg3_reg0_n_101 : STD_LOGIC;
  signal slv_reg3_reg0_n_102 : STD_LOGIC;
  signal slv_reg3_reg0_n_103 : STD_LOGIC;
  signal slv_reg3_reg0_n_104 : STD_LOGIC;
  signal slv_reg3_reg0_n_105 : STD_LOGIC;
  signal slv_reg3_reg0_n_106 : STD_LOGIC;
  signal slv_reg3_reg0_n_107 : STD_LOGIC;
  signal slv_reg3_reg0_n_108 : STD_LOGIC;
  signal slv_reg3_reg0_n_109 : STD_LOGIC;
  signal slv_reg3_reg0_n_110 : STD_LOGIC;
  signal slv_reg3_reg0_n_111 : STD_LOGIC;
  signal slv_reg3_reg0_n_112 : STD_LOGIC;
  signal slv_reg3_reg0_n_113 : STD_LOGIC;
  signal slv_reg3_reg0_n_114 : STD_LOGIC;
  signal slv_reg3_reg0_n_115 : STD_LOGIC;
  signal slv_reg3_reg0_n_116 : STD_LOGIC;
  signal slv_reg3_reg0_n_117 : STD_LOGIC;
  signal slv_reg3_reg0_n_118 : STD_LOGIC;
  signal slv_reg3_reg0_n_119 : STD_LOGIC;
  signal slv_reg3_reg0_n_120 : STD_LOGIC;
  signal slv_reg3_reg0_n_121 : STD_LOGIC;
  signal slv_reg3_reg0_n_122 : STD_LOGIC;
  signal slv_reg3_reg0_n_123 : STD_LOGIC;
  signal slv_reg3_reg0_n_124 : STD_LOGIC;
  signal slv_reg3_reg0_n_125 : STD_LOGIC;
  signal slv_reg3_reg0_n_126 : STD_LOGIC;
  signal slv_reg3_reg0_n_127 : STD_LOGIC;
  signal slv_reg3_reg0_n_128 : STD_LOGIC;
  signal slv_reg3_reg0_n_129 : STD_LOGIC;
  signal slv_reg3_reg0_n_130 : STD_LOGIC;
  signal slv_reg3_reg0_n_131 : STD_LOGIC;
  signal slv_reg3_reg0_n_132 : STD_LOGIC;
  signal slv_reg3_reg0_n_133 : STD_LOGIC;
  signal slv_reg3_reg0_n_134 : STD_LOGIC;
  signal slv_reg3_reg0_n_135 : STD_LOGIC;
  signal slv_reg3_reg0_n_136 : STD_LOGIC;
  signal slv_reg3_reg0_n_137 : STD_LOGIC;
  signal slv_reg3_reg0_n_138 : STD_LOGIC;
  signal slv_reg3_reg0_n_139 : STD_LOGIC;
  signal slv_reg3_reg0_n_140 : STD_LOGIC;
  signal slv_reg3_reg0_n_141 : STD_LOGIC;
  signal slv_reg3_reg0_n_142 : STD_LOGIC;
  signal slv_reg3_reg0_n_143 : STD_LOGIC;
  signal slv_reg3_reg0_n_144 : STD_LOGIC;
  signal slv_reg3_reg0_n_145 : STD_LOGIC;
  signal slv_reg3_reg0_n_146 : STD_LOGIC;
  signal slv_reg3_reg0_n_147 : STD_LOGIC;
  signal slv_reg3_reg0_n_148 : STD_LOGIC;
  signal slv_reg3_reg0_n_149 : STD_LOGIC;
  signal slv_reg3_reg0_n_150 : STD_LOGIC;
  signal slv_reg3_reg0_n_151 : STD_LOGIC;
  signal slv_reg3_reg0_n_152 : STD_LOGIC;
  signal slv_reg3_reg0_n_153 : STD_LOGIC;
  signal slv_reg3_reg0_n_58 : STD_LOGIC;
  signal slv_reg3_reg0_n_59 : STD_LOGIC;
  signal slv_reg3_reg0_n_60 : STD_LOGIC;
  signal slv_reg3_reg0_n_61 : STD_LOGIC;
  signal slv_reg3_reg0_n_62 : STD_LOGIC;
  signal slv_reg3_reg0_n_63 : STD_LOGIC;
  signal slv_reg3_reg0_n_64 : STD_LOGIC;
  signal slv_reg3_reg0_n_65 : STD_LOGIC;
  signal slv_reg3_reg0_n_66 : STD_LOGIC;
  signal slv_reg3_reg0_n_67 : STD_LOGIC;
  signal slv_reg3_reg0_n_68 : STD_LOGIC;
  signal slv_reg3_reg0_n_69 : STD_LOGIC;
  signal slv_reg3_reg0_n_70 : STD_LOGIC;
  signal slv_reg3_reg0_n_71 : STD_LOGIC;
  signal slv_reg3_reg0_n_72 : STD_LOGIC;
  signal slv_reg3_reg0_n_73 : STD_LOGIC;
  signal slv_reg3_reg0_n_74 : STD_LOGIC;
  signal slv_reg3_reg0_n_75 : STD_LOGIC;
  signal slv_reg3_reg0_n_76 : STD_LOGIC;
  signal slv_reg3_reg0_n_77 : STD_LOGIC;
  signal slv_reg3_reg0_n_78 : STD_LOGIC;
  signal slv_reg3_reg0_n_79 : STD_LOGIC;
  signal slv_reg3_reg0_n_80 : STD_LOGIC;
  signal slv_reg3_reg0_n_81 : STD_LOGIC;
  signal slv_reg3_reg0_n_82 : STD_LOGIC;
  signal slv_reg3_reg0_n_83 : STD_LOGIC;
  signal slv_reg3_reg0_n_84 : STD_LOGIC;
  signal slv_reg3_reg0_n_85 : STD_LOGIC;
  signal slv_reg3_reg0_n_86 : STD_LOGIC;
  signal slv_reg3_reg0_n_87 : STD_LOGIC;
  signal slv_reg3_reg0_n_88 : STD_LOGIC;
  signal slv_reg3_reg0_n_89 : STD_LOGIC;
  signal slv_reg3_reg0_n_90 : STD_LOGIC;
  signal slv_reg3_reg0_n_91 : STD_LOGIC;
  signal slv_reg3_reg0_n_92 : STD_LOGIC;
  signal slv_reg3_reg0_n_93 : STD_LOGIC;
  signal slv_reg3_reg0_n_94 : STD_LOGIC;
  signal slv_reg3_reg0_n_95 : STD_LOGIC;
  signal slv_reg3_reg0_n_96 : STD_LOGIC;
  signal slv_reg3_reg0_n_97 : STD_LOGIC;
  signal slv_reg3_reg0_n_98 : STD_LOGIC;
  signal slv_reg3_reg0_n_99 : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_1\ : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_2\ : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_3\ : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_4\ : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_5\ : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_6\ : STD_LOGIC;
  signal \slv_reg3_reg[19]_i_1_n_7\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_1\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_2\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_3\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_4\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_5\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_6\ : STD_LOGIC;
  signal \slv_reg3_reg[23]_i_1_n_7\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_0\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_1\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_2\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_3\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_4\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_5\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_6\ : STD_LOGIC;
  signal \slv_reg3_reg[27]_i_1_n_7\ : STD_LOGIC;
  signal \slv_reg3_reg[31]_i_1_n_1\ : STD_LOGIC;
  signal \slv_reg3_reg[31]_i_1_n_2\ : STD_LOGIC;
  signal \slv_reg3_reg[31]_i_1_n_3\ : STD_LOGIC;
  signal \slv_reg3_reg[31]_i_1_n_4\ : STD_LOGIC;
  signal \slv_reg3_reg[31]_i_1_n_5\ : STD_LOGIC;
  signal \slv_reg3_reg[31]_i_1_n_6\ : STD_LOGIC;
  signal \slv_reg3_reg[31]_i_1_n_7\ : STD_LOGIC;
  signal state_read : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal state_write : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal NLW_slv_reg3_reg0_CARRYCASCOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_slv_reg3_reg0_MULTSIGNOUT_UNCONNECTED : STD_LOGIC;
  signal NLW_slv_reg3_reg0_OVERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_slv_reg3_reg0_PATTERNBDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_slv_reg3_reg0_PATTERNDETECT_UNCONNECTED : STD_LOGIC;
  signal NLW_slv_reg3_reg0_UNDERFLOW_UNCONNECTED : STD_LOGIC;
  signal NLW_slv_reg3_reg0_ACOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal NLW_slv_reg3_reg0_BCOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal NLW_slv_reg3_reg0_CARRYOUT_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_slv_reg3_reg0__0_CARRYCASCOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__0_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__0_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__0_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__0_PATTERNDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__0_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__0_ACOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal \NLW_slv_reg3_reg0__0_BCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \NLW_slv_reg3_reg0__0_CARRYOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_slv_reg3_reg0__1_CARRYCASCOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__1_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__1_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__1_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__1_PATTERNDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__1_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_slv_reg3_reg0__1_ACOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal \NLW_slv_reg3_reg0__1_BCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \NLW_slv_reg3_reg0__1_CARRYOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_slv_reg3_reg0__1_PCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal \NLW_slv_reg3_reg[31]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_read_reg[0]\ : label is "Idle:00,Rdata:10,Raddr:01";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_read_reg[1]\ : label is "Idle:00,Rdata:10,Raddr:01";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_state_write[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \FSM_sequential_state_write[1]_i_1\ : label is "soft_lutpair0";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_write_reg[0]\ : label is "Idle:00,Wdata:10,Waddr:01";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_write_reg[1]\ : label is "Idle:00,Wdata:10,Waddr:01";
  attribute SOFT_HLUTNM of axi_awready_i_2 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of axi_bvalid_i_2 : label is "soft_lutpair1";
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of slv_reg3_reg0 : label is "{SYNTH-10 {cell *THIS*} {string 16x18 4}}";
  attribute METHODOLOGY_DRC_VIOS of \slv_reg3_reg0__0\ : label is "{SYNTH-10 {cell *THIS*} {string 18x18 4}}";
  attribute METHODOLOGY_DRC_VIOS of \slv_reg3_reg0__1\ : label is "{SYNTH-10 {cell *THIS*} {string 18x16 4}}";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \slv_reg3_reg[19]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \slv_reg3_reg[23]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \slv_reg3_reg[27]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \slv_reg3_reg[31]_i_1\ : label is 35;
begin
  axi_arready_reg_0 <= \^axi_arready_reg_0\;
  axi_awready_reg_0 <= \^axi_awready_reg_0\;
  axi_rvalid_reg_0 <= \^axi_rvalid_reg_0\;
  s00_axi_bvalid <= \^s00_axi_bvalid\;
  s00_axi_wready <= \^s00_axi_wready\;
\FSM_sequential_state_read[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0007777FFFF"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^axi_arready_reg_0\,
      I2 => s00_axi_rready,
      I3 => \^axi_rvalid_reg_0\,
      I4 => state_read(0),
      I5 => state_read(1),
      O => \FSM_sequential_state_read[0]_i_1_n_0\
    );
\FSM_sequential_state_read[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0FFF88880000"
    )
        port map (
      I0 => \^axi_arready_reg_0\,
      I1 => s00_axi_arvalid,
      I2 => s00_axi_rready,
      I3 => \^axi_rvalid_reg_0\,
      I4 => state_read(0),
      I5 => state_read(1),
      O => \FSM_sequential_state_read[1]_i_1_n_0\
    );
\FSM_sequential_state_read_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \FSM_sequential_state_read[0]_i_1_n_0\,
      Q => state_read(0),
      R => axi_awready_i_1_n_0
    );
\FSM_sequential_state_read_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \FSM_sequential_state_read[1]_i_1_n_0\,
      Q => state_read(1),
      R => axi_awready_i_1_n_0
    );
\FSM_sequential_state_write[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF0F7FF"
    )
        port map (
      I0 => \^axi_awready_reg_0\,
      I1 => s00_axi_awvalid,
      I2 => s00_axi_wvalid,
      I3 => state_write(0),
      I4 => state_write(1),
      O => \FSM_sequential_state_write[0]_i_1_n_0\
    );
\FSM_sequential_state_write[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF0F0800"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => \^axi_awready_reg_0\,
      I2 => s00_axi_wvalid,
      I3 => state_write(0),
      I4 => state_write(1),
      O => \FSM_sequential_state_write[1]_i_1_n_0\
    );
\FSM_sequential_state_write_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \FSM_sequential_state_write[0]_i_1_n_0\,
      Q => state_write(0),
      R => axi_awready_i_1_n_0
    );
\FSM_sequential_state_write_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \FSM_sequential_state_write[1]_i_1_n_0\,
      Q => state_write(1),
      R => axi_awready_i_1_n_0
    );
\axi_araddr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => s00_axi_araddr(0),
      I1 => s00_axi_aresetn,
      I2 => axi_arready0,
      I3 => state_read(0),
      I4 => state_read(1),
      I5 => axi_araddr(2),
      O => \axi_araddr[2]_i_1_n_0\
    );
\axi_araddr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFBFFF00008000"
    )
        port map (
      I0 => s00_axi_araddr(1),
      I1 => s00_axi_aresetn,
      I2 => axi_arready0,
      I3 => state_read(0),
      I4 => state_read(1),
      I5 => axi_araddr(3),
      O => \axi_araddr[3]_i_1_n_0\
    );
\axi_araddr[3]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^axi_arready_reg_0\,
      O => axi_arready0
    );
\axi_araddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_araddr[2]_i_1_n_0\,
      Q => axi_araddr(2),
      R => '0'
    );
\axi_araddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_araddr[3]_i_1_n_0\,
      Q => axi_araddr(3),
      R => '0'
    );
axi_arready_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C4C4C4C4FFCFCFCF"
    )
        port map (
      I0 => s00_axi_arvalid,
      I1 => \^axi_arready_reg_0\,
      I2 => state_read(1),
      I3 => s00_axi_rready,
      I4 => \^axi_rvalid_reg_0\,
      I5 => state_read(0),
      O => axi_arready_i_1_n_0
    );
axi_arready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_arready_i_1_n_0,
      Q => \^axi_arready_reg_0\,
      R => axi_awready_i_1_n_0
    );
\axi_awaddr[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFF20000000"
    )
        port map (
      I0 => s00_axi_awaddr(0),
      I1 => state_write(1),
      I2 => state_write(0),
      I3 => s00_axi_awvalid,
      I4 => \^axi_awready_reg_0\,
      I5 => \axi_awaddr_reg_n_0_[2]\,
      O => \axi_awaddr[2]_i_1_n_0\
    );
\axi_awaddr[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFFFFFFF20000000"
    )
        port map (
      I0 => s00_axi_awaddr(1),
      I1 => state_write(1),
      I2 => state_write(0),
      I3 => s00_axi_awvalid,
      I4 => \^axi_awready_reg_0\,
      I5 => \axi_awaddr_reg_n_0_[3]\,
      O => \axi_awaddr[3]_i_1_n_0\
    );
\axi_awaddr_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_awaddr[2]_i_1_n_0\,
      Q => \axi_awaddr_reg_n_0_[2]\,
      R => axi_awready_i_1_n_0
    );
\axi_awaddr_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \axi_awaddr[3]_i_1_n_0\,
      Q => \axi_awaddr_reg_n_0_[3]\,
      R => axi_awready_i_1_n_0
    );
axi_awready_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s00_axi_aresetn,
      O => axi_awready_i_1_n_0
    );
axi_awready_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCC4FFCF"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => \^axi_awready_reg_0\,
      I2 => state_write(1),
      I3 => s00_axi_wvalid,
      I4 => state_write(0),
      O => axi_awready_i_2_n_0
    );
axi_awready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_awready_i_2_n_0,
      Q => \^axi_awready_reg_0\,
      R => axi_awready_i_1_n_0
    );
axi_bvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FBFF3838C3FF0000"
    )
        port map (
      I0 => \axi_awready0__0\,
      I1 => state_write(0),
      I2 => state_write(1),
      I3 => s00_axi_bready,
      I4 => \^s00_axi_bvalid\,
      I5 => s00_axi_wvalid,
      O => axi_bvalid_i_1_n_0
    );
axi_bvalid_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s00_axi_awvalid,
      I1 => \^axi_awready_reg_0\,
      O => \axi_awready0__0\
    );
axi_bvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_bvalid_i_1_n_0,
      Q => \^s00_axi_bvalid\,
      R => axi_awready_i_1_n_0
    );
axi_rvalid_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFFFFF00800080"
    )
        port map (
      I0 => \^axi_arready_reg_0\,
      I1 => s00_axi_arvalid,
      I2 => state_read(0),
      I3 => state_read(1),
      I4 => s00_axi_rready,
      I5 => \^axi_rvalid_reg_0\,
      O => axi_rvalid_i_1_n_0
    );
axi_rvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_rvalid_i_1_n_0,
      Q => \^axi_rvalid_reg_0\,
      R => axi_awready_i_1_n_0
    );
axi_wready_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"F1"
    )
        port map (
      I0 => state_write(1),
      I1 => state_write(0),
      I2 => \^s00_axi_wready\,
      O => axi_wready_i_1_n_0
    );
axi_wready_reg: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => axi_wready_i_1_n_0,
      Q => \^s00_axi_wready\,
      R => axi_awready_i_1_n_0
    );
\s00_axi_rdata[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(0),
      I1 => slv_reg0(0),
      I2 => slv_reg3(0),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(0),
      O => s00_axi_rdata(0)
    );
\s00_axi_rdata[10]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(10),
      I1 => slv_reg0(10),
      I2 => slv_reg3(10),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(10),
      O => s00_axi_rdata(10)
    );
\s00_axi_rdata[11]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(11),
      I1 => slv_reg0(11),
      I2 => slv_reg3(11),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(11),
      O => s00_axi_rdata(11)
    );
\s00_axi_rdata[12]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(12),
      I1 => slv_reg0(12),
      I2 => slv_reg3(12),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(12),
      O => s00_axi_rdata(12)
    );
\s00_axi_rdata[13]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(13),
      I1 => slv_reg0(13),
      I2 => slv_reg3(13),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(13),
      O => s00_axi_rdata(13)
    );
\s00_axi_rdata[14]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(14),
      I1 => slv_reg0(14),
      I2 => slv_reg3(14),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(14),
      O => s00_axi_rdata(14)
    );
\s00_axi_rdata[15]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(15),
      I1 => slv_reg0(15),
      I2 => slv_reg3(15),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(15),
      O => s00_axi_rdata(15)
    );
\s00_axi_rdata[16]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(16),
      I1 => slv_reg0(16),
      I2 => slv_reg3(16),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(16),
      O => s00_axi_rdata(16)
    );
\s00_axi_rdata[17]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(17),
      I1 => slv_reg0(17),
      I2 => slv_reg3(17),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(17),
      O => s00_axi_rdata(17)
    );
\s00_axi_rdata[18]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(18),
      I1 => slv_reg0(18),
      I2 => slv_reg3(18),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(18),
      O => s00_axi_rdata(18)
    );
\s00_axi_rdata[19]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(19),
      I1 => slv_reg0(19),
      I2 => slv_reg3(19),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(19),
      O => s00_axi_rdata(19)
    );
\s00_axi_rdata[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(1),
      I1 => slv_reg0(1),
      I2 => slv_reg3(1),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(1),
      O => s00_axi_rdata(1)
    );
\s00_axi_rdata[20]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(20),
      I1 => slv_reg0(20),
      I2 => slv_reg3(20),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(20),
      O => s00_axi_rdata(20)
    );
\s00_axi_rdata[21]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(21),
      I1 => slv_reg0(21),
      I2 => slv_reg3(21),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(21),
      O => s00_axi_rdata(21)
    );
\s00_axi_rdata[22]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(22),
      I1 => slv_reg0(22),
      I2 => slv_reg3(22),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(22),
      O => s00_axi_rdata(22)
    );
\s00_axi_rdata[23]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(23),
      I1 => slv_reg0(23),
      I2 => slv_reg3(23),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(23),
      O => s00_axi_rdata(23)
    );
\s00_axi_rdata[24]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(24),
      I1 => slv_reg0(24),
      I2 => slv_reg3(24),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(24),
      O => s00_axi_rdata(24)
    );
\s00_axi_rdata[25]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(25),
      I1 => slv_reg0(25),
      I2 => slv_reg3(25),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(25),
      O => s00_axi_rdata(25)
    );
\s00_axi_rdata[26]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(26),
      I1 => slv_reg0(26),
      I2 => slv_reg3(26),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(26),
      O => s00_axi_rdata(26)
    );
\s00_axi_rdata[27]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(27),
      I1 => slv_reg0(27),
      I2 => slv_reg3(27),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(27),
      O => s00_axi_rdata(27)
    );
\s00_axi_rdata[28]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(28),
      I1 => slv_reg0(28),
      I2 => slv_reg3(28),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(28),
      O => s00_axi_rdata(28)
    );
\s00_axi_rdata[29]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(29),
      I1 => slv_reg0(29),
      I2 => slv_reg3(29),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(29),
      O => s00_axi_rdata(29)
    );
\s00_axi_rdata[2]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(2),
      I1 => slv_reg0(2),
      I2 => slv_reg3(2),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(2),
      O => s00_axi_rdata(2)
    );
\s00_axi_rdata[30]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(30),
      I1 => slv_reg0(30),
      I2 => slv_reg3(30),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(30),
      O => s00_axi_rdata(30)
    );
\s00_axi_rdata[31]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(31),
      I1 => slv_reg0(31),
      I2 => slv_reg3(31),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(31),
      O => s00_axi_rdata(31)
    );
\s00_axi_rdata[3]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(3),
      I1 => slv_reg0(3),
      I2 => slv_reg3(3),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(3),
      O => s00_axi_rdata(3)
    );
\s00_axi_rdata[4]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(4),
      I1 => slv_reg0(4),
      I2 => slv_reg3(4),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(4),
      O => s00_axi_rdata(4)
    );
\s00_axi_rdata[5]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(5),
      I1 => slv_reg0(5),
      I2 => slv_reg3(5),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(5),
      O => s00_axi_rdata(5)
    );
\s00_axi_rdata[6]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(6),
      I1 => slv_reg0(6),
      I2 => slv_reg3(6),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(6),
      O => s00_axi_rdata(6)
    );
\s00_axi_rdata[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(7),
      I1 => slv_reg0(7),
      I2 => slv_reg3(7),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(7),
      O => s00_axi_rdata(7)
    );
\s00_axi_rdata[8]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(8),
      I1 => slv_reg0(8),
      I2 => slv_reg3(8),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(8),
      O => s00_axi_rdata(8)
    );
\s00_axi_rdata[9]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0FFAACCF000AACC"
    )
        port map (
      I0 => slv_reg1(9),
      I1 => slv_reg0(9),
      I2 => slv_reg3(9),
      I3 => axi_araddr(2),
      I4 => axi_araddr(3),
      I5 => slv_reg2(9),
      O => s00_axi_rdata(9)
    );
\slv_reg0[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002220200000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => s00_axi_wstrb(1),
      O => \slv_reg0[15]_i_1_n_0\
    );
\slv_reg0[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002220200000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => s00_axi_wstrb(2),
      O => \slv_reg0[23]_i_1_n_0\
    );
\slv_reg0[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002220200000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => s00_axi_wstrb(3),
      O => \slv_reg0[31]_i_1_n_0\
    );
\slv_reg0[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0002220200000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => s00_axi_wstrb(0),
      O => \slv_reg0[7]_i_1_n_0\
    );
\slv_reg0_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(0),
      Q => slv_reg0(0),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(10),
      Q => slv_reg0(10),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(11),
      Q => slv_reg0(11),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(12),
      Q => slv_reg0(12),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(13),
      Q => slv_reg0(13),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(14),
      Q => slv_reg0(14),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(15),
      Q => slv_reg0(15),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(16),
      Q => slv_reg0(16),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(17),
      Q => slv_reg0(17),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(18),
      Q => slv_reg0(18),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(19),
      Q => slv_reg0(19),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(1),
      Q => slv_reg0(1),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(20),
      Q => slv_reg0(20),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(21),
      Q => slv_reg0(21),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(22),
      Q => slv_reg0(22),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[23]_i_1_n_0\,
      D => s00_axi_wdata(23),
      Q => slv_reg0(23),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(24),
      Q => slv_reg0(24),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(25),
      Q => slv_reg0(25),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(26),
      Q => slv_reg0(26),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(27),
      Q => slv_reg0(27),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(28),
      Q => slv_reg0(28),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(29),
      Q => slv_reg0(29),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(2),
      Q => slv_reg0(2),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(30),
      Q => slv_reg0(30),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[31]_i_1_n_0\,
      D => s00_axi_wdata(31),
      Q => slv_reg0(31),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(3),
      Q => slv_reg0(3),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(4),
      Q => slv_reg0(4),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(5),
      Q => slv_reg0(5),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(6),
      Q => slv_reg0(6),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[7]_i_1_n_0\,
      D => s00_axi_wdata(7),
      Q => slv_reg0(7),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(8),
      Q => slv_reg0(8),
      R => axi_awready_i_1_n_0
    );
\slv_reg0_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg0[15]_i_1_n_0\,
      D => s00_axi_wdata(9),
      Q => slv_reg0(9),
      R => axi_awready_i_1_n_0
    );
\slv_reg1[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2020200000002000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(1),
      I3 => \axi_awaddr_reg_n_0_[2]\,
      I4 => s00_axi_awvalid,
      I5 => s00_axi_awaddr(0),
      O => \slv_reg1[15]_i_1_n_0\
    );
\slv_reg1[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2020200000002000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(2),
      I3 => \axi_awaddr_reg_n_0_[2]\,
      I4 => s00_axi_awvalid,
      I5 => s00_axi_awaddr(0),
      O => \slv_reg1[23]_i_1_n_0\
    );
\slv_reg1[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2020200000002000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(3),
      I3 => \axi_awaddr_reg_n_0_[2]\,
      I4 => s00_axi_awvalid,
      I5 => s00_axi_awaddr(0),
      O => \slv_reg1[31]_i_1_n_0\
    );
\slv_reg1[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2020200000002000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(0),
      I3 => \axi_awaddr_reg_n_0_[2]\,
      I4 => s00_axi_awvalid,
      I5 => s00_axi_awaddr(0),
      O => \slv_reg1[7]_i_1_n_0\
    );
\slv_reg1_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(0),
      Q => slv_reg1(0),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(10),
      Q => slv_reg1(10),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(11),
      Q => slv_reg1(11),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(12),
      Q => slv_reg1(12),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(13),
      Q => slv_reg1(13),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(14),
      Q => slv_reg1(14),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(15),
      Q => slv_reg1(15),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(16),
      Q => slv_reg1(16),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(17),
      Q => slv_reg1(17),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(18),
      Q => slv_reg1(18),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(19),
      Q => slv_reg1(19),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(1),
      Q => slv_reg1(1),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(20),
      Q => slv_reg1(20),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(21),
      Q => slv_reg1(21),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(22),
      Q => slv_reg1(22),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[23]_i_1_n_0\,
      D => s00_axi_wdata(23),
      Q => slv_reg1(23),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(24),
      Q => slv_reg1(24),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(25),
      Q => slv_reg1(25),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(26),
      Q => slv_reg1(26),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(27),
      Q => slv_reg1(27),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(28),
      Q => slv_reg1(28),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(29),
      Q => slv_reg1(29),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(2),
      Q => slv_reg1(2),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(30),
      Q => slv_reg1(30),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[31]_i_1_n_0\,
      D => s00_axi_wdata(31),
      Q => slv_reg1(31),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(3),
      Q => slv_reg1(3),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(4),
      Q => slv_reg1(4),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(5),
      Q => slv_reg1(5),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(6),
      Q => slv_reg1(6),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[7]_i_1_n_0\,
      D => s00_axi_wdata(7),
      Q => slv_reg1(7),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(8),
      Q => slv_reg1(8),
      R => axi_awready_i_1_n_0
    );
\slv_reg1_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg1[15]_i_1_n_0\,
      D => s00_axi_wdata(9),
      Q => slv_reg1(9),
      R => axi_awready_i_1_n_0
    );
\slv_reg2[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000808080"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(1),
      I3 => s00_axi_awaddr(0),
      I4 => s00_axi_awvalid,
      I5 => \axi_awaddr_reg_n_0_[2]\,
      O => p_1_in(15)
    );
\slv_reg2[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000808080"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(2),
      I3 => s00_axi_awaddr(0),
      I4 => s00_axi_awvalid,
      I5 => \axi_awaddr_reg_n_0_[2]\,
      O => p_1_in(23)
    );
\slv_reg2[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000808080"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(3),
      I3 => s00_axi_awaddr(0),
      I4 => s00_axi_awvalid,
      I5 => \axi_awaddr_reg_n_0_[2]\,
      O => p_1_in(31)
    );
\slv_reg2[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080000000808080"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => \slv_reg3[31]__0_i_2_n_0\,
      I2 => s00_axi_wstrb(0),
      I3 => s00_axi_awaddr(0),
      I4 => s00_axi_awvalid,
      I5 => \axi_awaddr_reg_n_0_[2]\,
      O => p_1_in(7)
    );
\slv_reg2_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(0),
      Q => slv_reg2(0),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(10),
      Q => slv_reg2(10),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(11),
      Q => slv_reg2(11),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(12),
      Q => slv_reg2(12),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(13),
      Q => slv_reg2(13),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(14),
      Q => slv_reg2(14),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(15),
      Q => slv_reg2(15),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(16),
      Q => slv_reg2(16),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(17),
      Q => slv_reg2(17),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(18),
      Q => slv_reg2(18),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(19),
      Q => slv_reg2(19),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(1),
      Q => slv_reg2(1),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(20),
      Q => slv_reg2(20),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(21),
      Q => slv_reg2(21),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(22),
      Q => slv_reg2(22),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(23),
      D => s00_axi_wdata(23),
      Q => slv_reg2(23),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(24),
      Q => slv_reg2(24),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(25),
      Q => slv_reg2(25),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(26),
      Q => slv_reg2(26),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(27),
      Q => slv_reg2(27),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(28),
      Q => slv_reg2(28),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(29),
      Q => slv_reg2(29),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(2),
      Q => slv_reg2(2),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(30),
      Q => slv_reg2(30),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(31),
      D => s00_axi_wdata(31),
      Q => slv_reg2(31),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(3),
      Q => slv_reg2(3),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(4),
      Q => slv_reg2(4),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(5),
      Q => slv_reg2(5),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(6),
      Q => slv_reg2(6),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(7),
      D => s00_axi_wdata(7),
      Q => slv_reg2(7),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(8),
      Q => slv_reg2(8),
      R => axi_awready_i_1_n_0
    );
\slv_reg2_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => p_1_in(15),
      D => s00_axi_wdata(9),
      Q => slv_reg2(9),
      R => axi_awready_i_1_n_0
    );
\slv_reg3[15]__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8880008000000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => s00_axi_wstrb(1),
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => \slv_reg3[31]__0_i_2_n_0\,
      O => \slv_reg3[15]__0_i_1_n_0\
    );
\slv_reg3[19]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_103\,
      I1 => slv_reg3_reg0_n_103,
      O => \slv_reg3[19]_i_2_n_0\
    );
\slv_reg3[19]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_104\,
      I1 => slv_reg3_reg0_n_104,
      O => \slv_reg3[19]_i_3_n_0\
    );
\slv_reg3[19]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_105\,
      I1 => slv_reg3_reg0_n_105,
      O => \slv_reg3[19]_i_4_n_0\
    );
\slv_reg3[23]__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8880008000000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => s00_axi_wstrb(2),
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => \slv_reg3[31]__0_i_2_n_0\,
      O => \slv_reg3[23]__0_i_1_n_0\
    );
\slv_reg3[23]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_99\,
      I1 => slv_reg3_reg0_n_99,
      O => \slv_reg3[23]_i_2_n_0\
    );
\slv_reg3[23]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_100\,
      I1 => slv_reg3_reg0_n_100,
      O => \slv_reg3[23]_i_3_n_0\
    );
\slv_reg3[23]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_101\,
      I1 => slv_reg3_reg0_n_101,
      O => \slv_reg3[23]_i_4_n_0\
    );
\slv_reg3[23]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_102\,
      I1 => slv_reg3_reg0_n_102,
      O => \slv_reg3[23]_i_5_n_0\
    );
\slv_reg3[27]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_95\,
      I1 => slv_reg3_reg0_n_95,
      O => \slv_reg3[27]_i_2_n_0\
    );
\slv_reg3[27]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_96\,
      I1 => slv_reg3_reg0_n_96,
      O => \slv_reg3[27]_i_3_n_0\
    );
\slv_reg3[27]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_97\,
      I1 => slv_reg3_reg0_n_97,
      O => \slv_reg3[27]_i_4_n_0\
    );
\slv_reg3[27]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_98\,
      I1 => slv_reg3_reg0_n_98,
      O => \slv_reg3[27]_i_5_n_0\
    );
\slv_reg3[31]__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8880008000000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => s00_axi_wstrb(3),
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => \slv_reg3[31]__0_i_2_n_0\,
      O => \slv_reg3[31]__0_i_1_n_0\
    );
\slv_reg3[31]__0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s00_axi_awaddr(1),
      I1 => s00_axi_awvalid,
      I2 => \axi_awaddr_reg_n_0_[3]\,
      O => \slv_reg3[31]__0_i_2_n_0\
    );
\slv_reg3[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_91\,
      I1 => slv_reg3_reg0_n_91,
      O => \slv_reg3[31]_i_2_n_0\
    );
\slv_reg3[31]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_92\,
      I1 => slv_reg3_reg0_n_92,
      O => \slv_reg3[31]_i_3_n_0\
    );
\slv_reg3[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_93\,
      I1 => slv_reg3_reg0_n_93,
      O => \slv_reg3[31]_i_4_n_0\
    );
\slv_reg3[31]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \slv_reg3_reg0__1_n_94\,
      I1 => slv_reg3_reg0_n_94,
      O => \slv_reg3[31]_i_5_n_0\
    );
\slv_reg3[7]__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8880008000000000"
    )
        port map (
      I0 => s00_axi_wvalid,
      I1 => s00_axi_wstrb(0),
      I2 => \axi_awaddr_reg_n_0_[2]\,
      I3 => s00_axi_awvalid,
      I4 => s00_axi_awaddr(0),
      I5 => \slv_reg3[31]__0_i_2_n_0\,
      O => \slv_reg3[7]__0_i_1_n_0\
    );
slv_reg3_reg0: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 17) => B"0000000000000",
      A(16 downto 0) => slv_reg1(16 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => NLW_slv_reg3_reg0_ACOUT_UNCONNECTED(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17 downto 15) => B"000",
      B(14 downto 0) => slv_reg0(31 downto 17),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => NLW_slv_reg3_reg0_BCOUT_UNCONNECTED(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => NLW_slv_reg3_reg0_CARRYCASCOUT_UNCONNECTED,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => NLW_slv_reg3_reg0_CARRYOUT_UNCONNECTED(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => NLW_slv_reg3_reg0_MULTSIGNOUT_UNCONNECTED,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => NLW_slv_reg3_reg0_OVERFLOW_UNCONNECTED,
      P(47) => slv_reg3_reg0_n_58,
      P(46) => slv_reg3_reg0_n_59,
      P(45) => slv_reg3_reg0_n_60,
      P(44) => slv_reg3_reg0_n_61,
      P(43) => slv_reg3_reg0_n_62,
      P(42) => slv_reg3_reg0_n_63,
      P(41) => slv_reg3_reg0_n_64,
      P(40) => slv_reg3_reg0_n_65,
      P(39) => slv_reg3_reg0_n_66,
      P(38) => slv_reg3_reg0_n_67,
      P(37) => slv_reg3_reg0_n_68,
      P(36) => slv_reg3_reg0_n_69,
      P(35) => slv_reg3_reg0_n_70,
      P(34) => slv_reg3_reg0_n_71,
      P(33) => slv_reg3_reg0_n_72,
      P(32) => slv_reg3_reg0_n_73,
      P(31) => slv_reg3_reg0_n_74,
      P(30) => slv_reg3_reg0_n_75,
      P(29) => slv_reg3_reg0_n_76,
      P(28) => slv_reg3_reg0_n_77,
      P(27) => slv_reg3_reg0_n_78,
      P(26) => slv_reg3_reg0_n_79,
      P(25) => slv_reg3_reg0_n_80,
      P(24) => slv_reg3_reg0_n_81,
      P(23) => slv_reg3_reg0_n_82,
      P(22) => slv_reg3_reg0_n_83,
      P(21) => slv_reg3_reg0_n_84,
      P(20) => slv_reg3_reg0_n_85,
      P(19) => slv_reg3_reg0_n_86,
      P(18) => slv_reg3_reg0_n_87,
      P(17) => slv_reg3_reg0_n_88,
      P(16) => slv_reg3_reg0_n_89,
      P(15) => slv_reg3_reg0_n_90,
      P(14) => slv_reg3_reg0_n_91,
      P(13) => slv_reg3_reg0_n_92,
      P(12) => slv_reg3_reg0_n_93,
      P(11) => slv_reg3_reg0_n_94,
      P(10) => slv_reg3_reg0_n_95,
      P(9) => slv_reg3_reg0_n_96,
      P(8) => slv_reg3_reg0_n_97,
      P(7) => slv_reg3_reg0_n_98,
      P(6) => slv_reg3_reg0_n_99,
      P(5) => slv_reg3_reg0_n_100,
      P(4) => slv_reg3_reg0_n_101,
      P(3) => slv_reg3_reg0_n_102,
      P(2) => slv_reg3_reg0_n_103,
      P(1) => slv_reg3_reg0_n_104,
      P(0) => slv_reg3_reg0_n_105,
      PATTERNBDETECT => NLW_slv_reg3_reg0_PATTERNBDETECT_UNCONNECTED,
      PATTERNDETECT => NLW_slv_reg3_reg0_PATTERNDETECT_UNCONNECTED,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47) => slv_reg3_reg0_n_106,
      PCOUT(46) => slv_reg3_reg0_n_107,
      PCOUT(45) => slv_reg3_reg0_n_108,
      PCOUT(44) => slv_reg3_reg0_n_109,
      PCOUT(43) => slv_reg3_reg0_n_110,
      PCOUT(42) => slv_reg3_reg0_n_111,
      PCOUT(41) => slv_reg3_reg0_n_112,
      PCOUT(40) => slv_reg3_reg0_n_113,
      PCOUT(39) => slv_reg3_reg0_n_114,
      PCOUT(38) => slv_reg3_reg0_n_115,
      PCOUT(37) => slv_reg3_reg0_n_116,
      PCOUT(36) => slv_reg3_reg0_n_117,
      PCOUT(35) => slv_reg3_reg0_n_118,
      PCOUT(34) => slv_reg3_reg0_n_119,
      PCOUT(33) => slv_reg3_reg0_n_120,
      PCOUT(32) => slv_reg3_reg0_n_121,
      PCOUT(31) => slv_reg3_reg0_n_122,
      PCOUT(30) => slv_reg3_reg0_n_123,
      PCOUT(29) => slv_reg3_reg0_n_124,
      PCOUT(28) => slv_reg3_reg0_n_125,
      PCOUT(27) => slv_reg3_reg0_n_126,
      PCOUT(26) => slv_reg3_reg0_n_127,
      PCOUT(25) => slv_reg3_reg0_n_128,
      PCOUT(24) => slv_reg3_reg0_n_129,
      PCOUT(23) => slv_reg3_reg0_n_130,
      PCOUT(22) => slv_reg3_reg0_n_131,
      PCOUT(21) => slv_reg3_reg0_n_132,
      PCOUT(20) => slv_reg3_reg0_n_133,
      PCOUT(19) => slv_reg3_reg0_n_134,
      PCOUT(18) => slv_reg3_reg0_n_135,
      PCOUT(17) => slv_reg3_reg0_n_136,
      PCOUT(16) => slv_reg3_reg0_n_137,
      PCOUT(15) => slv_reg3_reg0_n_138,
      PCOUT(14) => slv_reg3_reg0_n_139,
      PCOUT(13) => slv_reg3_reg0_n_140,
      PCOUT(12) => slv_reg3_reg0_n_141,
      PCOUT(11) => slv_reg3_reg0_n_142,
      PCOUT(10) => slv_reg3_reg0_n_143,
      PCOUT(9) => slv_reg3_reg0_n_144,
      PCOUT(8) => slv_reg3_reg0_n_145,
      PCOUT(7) => slv_reg3_reg0_n_146,
      PCOUT(6) => slv_reg3_reg0_n_147,
      PCOUT(5) => slv_reg3_reg0_n_148,
      PCOUT(4) => slv_reg3_reg0_n_149,
      PCOUT(3) => slv_reg3_reg0_n_150,
      PCOUT(2) => slv_reg3_reg0_n_151,
      PCOUT(1) => slv_reg3_reg0_n_152,
      PCOUT(0) => slv_reg3_reg0_n_153,
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => NLW_slv_reg3_reg0_UNDERFLOW_UNCONNECTED
    );
\slv_reg3_reg0__0\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 17) => B"0000000000000",
      A(16 downto 0) => slv_reg0(16 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => \NLW_slv_reg3_reg0__0_ACOUT_UNCONNECTED\(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17) => '0',
      B(16 downto 0) => slv_reg1(16 downto 0),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => \NLW_slv_reg3_reg0__0_BCOUT_UNCONNECTED\(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => \NLW_slv_reg3_reg0__0_CARRYCASCOUT_UNCONNECTED\,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => \NLW_slv_reg3_reg0__0_CARRYOUT_UNCONNECTED\(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => \NLW_slv_reg3_reg0__0_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6 downto 0) => B"0000101",
      OVERFLOW => \NLW_slv_reg3_reg0__0_OVERFLOW_UNCONNECTED\,
      P(47) => \slv_reg3_reg0__0_n_58\,
      P(46) => \slv_reg3_reg0__0_n_59\,
      P(45) => \slv_reg3_reg0__0_n_60\,
      P(44) => \slv_reg3_reg0__0_n_61\,
      P(43) => \slv_reg3_reg0__0_n_62\,
      P(42) => \slv_reg3_reg0__0_n_63\,
      P(41) => \slv_reg3_reg0__0_n_64\,
      P(40) => \slv_reg3_reg0__0_n_65\,
      P(39) => \slv_reg3_reg0__0_n_66\,
      P(38) => \slv_reg3_reg0__0_n_67\,
      P(37) => \slv_reg3_reg0__0_n_68\,
      P(36) => \slv_reg3_reg0__0_n_69\,
      P(35) => \slv_reg3_reg0__0_n_70\,
      P(34) => \slv_reg3_reg0__0_n_71\,
      P(33) => \slv_reg3_reg0__0_n_72\,
      P(32) => \slv_reg3_reg0__0_n_73\,
      P(31) => \slv_reg3_reg0__0_n_74\,
      P(30) => \slv_reg3_reg0__0_n_75\,
      P(29) => \slv_reg3_reg0__0_n_76\,
      P(28) => \slv_reg3_reg0__0_n_77\,
      P(27) => \slv_reg3_reg0__0_n_78\,
      P(26) => \slv_reg3_reg0__0_n_79\,
      P(25) => \slv_reg3_reg0__0_n_80\,
      P(24) => \slv_reg3_reg0__0_n_81\,
      P(23) => \slv_reg3_reg0__0_n_82\,
      P(22) => \slv_reg3_reg0__0_n_83\,
      P(21) => \slv_reg3_reg0__0_n_84\,
      P(20) => \slv_reg3_reg0__0_n_85\,
      P(19) => \slv_reg3_reg0__0_n_86\,
      P(18) => \slv_reg3_reg0__0_n_87\,
      P(17) => \slv_reg3_reg0__0_n_88\,
      P(16) => \slv_reg3_reg0__0_n_89\,
      P(15) => \slv_reg3_reg0__0_n_90\,
      P(14) => \slv_reg3_reg0__0_n_91\,
      P(13) => \slv_reg3_reg0__0_n_92\,
      P(12) => \slv_reg3_reg0__0_n_93\,
      P(11) => \slv_reg3_reg0__0_n_94\,
      P(10) => \slv_reg3_reg0__0_n_95\,
      P(9) => \slv_reg3_reg0__0_n_96\,
      P(8) => \slv_reg3_reg0__0_n_97\,
      P(7) => \slv_reg3_reg0__0_n_98\,
      P(6) => \slv_reg3_reg0__0_n_99\,
      P(5) => \slv_reg3_reg0__0_n_100\,
      P(4) => \slv_reg3_reg0__0_n_101\,
      P(3) => \slv_reg3_reg0__0_n_102\,
      P(2) => \slv_reg3_reg0__0_n_103\,
      P(1) => \slv_reg3_reg0__0_n_104\,
      P(0) => \slv_reg3_reg0__0_n_105\,
      PATTERNBDETECT => \NLW_slv_reg3_reg0__0_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \NLW_slv_reg3_reg0__0_PATTERNDETECT_UNCONNECTED\,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47) => \slv_reg3_reg0__0_n_106\,
      PCOUT(46) => \slv_reg3_reg0__0_n_107\,
      PCOUT(45) => \slv_reg3_reg0__0_n_108\,
      PCOUT(44) => \slv_reg3_reg0__0_n_109\,
      PCOUT(43) => \slv_reg3_reg0__0_n_110\,
      PCOUT(42) => \slv_reg3_reg0__0_n_111\,
      PCOUT(41) => \slv_reg3_reg0__0_n_112\,
      PCOUT(40) => \slv_reg3_reg0__0_n_113\,
      PCOUT(39) => \slv_reg3_reg0__0_n_114\,
      PCOUT(38) => \slv_reg3_reg0__0_n_115\,
      PCOUT(37) => \slv_reg3_reg0__0_n_116\,
      PCOUT(36) => \slv_reg3_reg0__0_n_117\,
      PCOUT(35) => \slv_reg3_reg0__0_n_118\,
      PCOUT(34) => \slv_reg3_reg0__0_n_119\,
      PCOUT(33) => \slv_reg3_reg0__0_n_120\,
      PCOUT(32) => \slv_reg3_reg0__0_n_121\,
      PCOUT(31) => \slv_reg3_reg0__0_n_122\,
      PCOUT(30) => \slv_reg3_reg0__0_n_123\,
      PCOUT(29) => \slv_reg3_reg0__0_n_124\,
      PCOUT(28) => \slv_reg3_reg0__0_n_125\,
      PCOUT(27) => \slv_reg3_reg0__0_n_126\,
      PCOUT(26) => \slv_reg3_reg0__0_n_127\,
      PCOUT(25) => \slv_reg3_reg0__0_n_128\,
      PCOUT(24) => \slv_reg3_reg0__0_n_129\,
      PCOUT(23) => \slv_reg3_reg0__0_n_130\,
      PCOUT(22) => \slv_reg3_reg0__0_n_131\,
      PCOUT(21) => \slv_reg3_reg0__0_n_132\,
      PCOUT(20) => \slv_reg3_reg0__0_n_133\,
      PCOUT(19) => \slv_reg3_reg0__0_n_134\,
      PCOUT(18) => \slv_reg3_reg0__0_n_135\,
      PCOUT(17) => \slv_reg3_reg0__0_n_136\,
      PCOUT(16) => \slv_reg3_reg0__0_n_137\,
      PCOUT(15) => \slv_reg3_reg0__0_n_138\,
      PCOUT(14) => \slv_reg3_reg0__0_n_139\,
      PCOUT(13) => \slv_reg3_reg0__0_n_140\,
      PCOUT(12) => \slv_reg3_reg0__0_n_141\,
      PCOUT(11) => \slv_reg3_reg0__0_n_142\,
      PCOUT(10) => \slv_reg3_reg0__0_n_143\,
      PCOUT(9) => \slv_reg3_reg0__0_n_144\,
      PCOUT(8) => \slv_reg3_reg0__0_n_145\,
      PCOUT(7) => \slv_reg3_reg0__0_n_146\,
      PCOUT(6) => \slv_reg3_reg0__0_n_147\,
      PCOUT(5) => \slv_reg3_reg0__0_n_148\,
      PCOUT(4) => \slv_reg3_reg0__0_n_149\,
      PCOUT(3) => \slv_reg3_reg0__0_n_150\,
      PCOUT(2) => \slv_reg3_reg0__0_n_151\,
      PCOUT(1) => \slv_reg3_reg0__0_n_152\,
      PCOUT(0) => \slv_reg3_reg0__0_n_153\,
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => \NLW_slv_reg3_reg0__0_UNDERFLOW_UNCONNECTED\
    );
\slv_reg3_reg0__1\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 0,
      ADREG => 1,
      ALUMODEREG => 0,
      AREG => 0,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 0,
      BREG => 0,
      B_INPUT => "DIRECT",
      CARRYINREG => 0,
      CARRYINSELREG => 0,
      CREG => 1,
      DREG => 1,
      INMODEREG => 0,
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 0,
      PATTERN => X"000000000000",
      PREG => 0,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "MULTIPLY",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 17) => B"0000000000000",
      A(16 downto 0) => slv_reg0(16 downto 0),
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => \NLW_slv_reg3_reg0__1_ACOUT_UNCONNECTED\(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17 downto 15) => B"000",
      B(14 downto 0) => slv_reg1(31 downto 17),
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => \NLW_slv_reg3_reg0__1_BCOUT_UNCONNECTED\(17 downto 0),
      C(47 downto 0) => B"111111111111111111111111111111111111111111111111",
      CARRYCASCIN => '0',
      CARRYCASCOUT => \NLW_slv_reg3_reg0__1_CARRYCASCOUT_UNCONNECTED\,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => \NLW_slv_reg3_reg0__1_CARRYOUT_UNCONNECTED\(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => \NLW_slv_reg3_reg0__1_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6 downto 0) => B"1010101",
      OVERFLOW => \NLW_slv_reg3_reg0__1_OVERFLOW_UNCONNECTED\,
      P(47) => \slv_reg3_reg0__1_n_58\,
      P(46) => \slv_reg3_reg0__1_n_59\,
      P(45) => \slv_reg3_reg0__1_n_60\,
      P(44) => \slv_reg3_reg0__1_n_61\,
      P(43) => \slv_reg3_reg0__1_n_62\,
      P(42) => \slv_reg3_reg0__1_n_63\,
      P(41) => \slv_reg3_reg0__1_n_64\,
      P(40) => \slv_reg3_reg0__1_n_65\,
      P(39) => \slv_reg3_reg0__1_n_66\,
      P(38) => \slv_reg3_reg0__1_n_67\,
      P(37) => \slv_reg3_reg0__1_n_68\,
      P(36) => \slv_reg3_reg0__1_n_69\,
      P(35) => \slv_reg3_reg0__1_n_70\,
      P(34) => \slv_reg3_reg0__1_n_71\,
      P(33) => \slv_reg3_reg0__1_n_72\,
      P(32) => \slv_reg3_reg0__1_n_73\,
      P(31) => \slv_reg3_reg0__1_n_74\,
      P(30) => \slv_reg3_reg0__1_n_75\,
      P(29) => \slv_reg3_reg0__1_n_76\,
      P(28) => \slv_reg3_reg0__1_n_77\,
      P(27) => \slv_reg3_reg0__1_n_78\,
      P(26) => \slv_reg3_reg0__1_n_79\,
      P(25) => \slv_reg3_reg0__1_n_80\,
      P(24) => \slv_reg3_reg0__1_n_81\,
      P(23) => \slv_reg3_reg0__1_n_82\,
      P(22) => \slv_reg3_reg0__1_n_83\,
      P(21) => \slv_reg3_reg0__1_n_84\,
      P(20) => \slv_reg3_reg0__1_n_85\,
      P(19) => \slv_reg3_reg0__1_n_86\,
      P(18) => \slv_reg3_reg0__1_n_87\,
      P(17) => \slv_reg3_reg0__1_n_88\,
      P(16) => \slv_reg3_reg0__1_n_89\,
      P(15) => \slv_reg3_reg0__1_n_90\,
      P(14) => \slv_reg3_reg0__1_n_91\,
      P(13) => \slv_reg3_reg0__1_n_92\,
      P(12) => \slv_reg3_reg0__1_n_93\,
      P(11) => \slv_reg3_reg0__1_n_94\,
      P(10) => \slv_reg3_reg0__1_n_95\,
      P(9) => \slv_reg3_reg0__1_n_96\,
      P(8) => \slv_reg3_reg0__1_n_97\,
      P(7) => \slv_reg3_reg0__1_n_98\,
      P(6) => \slv_reg3_reg0__1_n_99\,
      P(5) => \slv_reg3_reg0__1_n_100\,
      P(4) => \slv_reg3_reg0__1_n_101\,
      P(3) => \slv_reg3_reg0__1_n_102\,
      P(2) => \slv_reg3_reg0__1_n_103\,
      P(1) => \slv_reg3_reg0__1_n_104\,
      P(0) => \slv_reg3_reg0__1_n_105\,
      PATTERNBDETECT => \NLW_slv_reg3_reg0__1_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \NLW_slv_reg3_reg0__1_PATTERNDETECT_UNCONNECTED\,
      PCIN(47) => \slv_reg3_reg0__0_n_106\,
      PCIN(46) => \slv_reg3_reg0__0_n_107\,
      PCIN(45) => \slv_reg3_reg0__0_n_108\,
      PCIN(44) => \slv_reg3_reg0__0_n_109\,
      PCIN(43) => \slv_reg3_reg0__0_n_110\,
      PCIN(42) => \slv_reg3_reg0__0_n_111\,
      PCIN(41) => \slv_reg3_reg0__0_n_112\,
      PCIN(40) => \slv_reg3_reg0__0_n_113\,
      PCIN(39) => \slv_reg3_reg0__0_n_114\,
      PCIN(38) => \slv_reg3_reg0__0_n_115\,
      PCIN(37) => \slv_reg3_reg0__0_n_116\,
      PCIN(36) => \slv_reg3_reg0__0_n_117\,
      PCIN(35) => \slv_reg3_reg0__0_n_118\,
      PCIN(34) => \slv_reg3_reg0__0_n_119\,
      PCIN(33) => \slv_reg3_reg0__0_n_120\,
      PCIN(32) => \slv_reg3_reg0__0_n_121\,
      PCIN(31) => \slv_reg3_reg0__0_n_122\,
      PCIN(30) => \slv_reg3_reg0__0_n_123\,
      PCIN(29) => \slv_reg3_reg0__0_n_124\,
      PCIN(28) => \slv_reg3_reg0__0_n_125\,
      PCIN(27) => \slv_reg3_reg0__0_n_126\,
      PCIN(26) => \slv_reg3_reg0__0_n_127\,
      PCIN(25) => \slv_reg3_reg0__0_n_128\,
      PCIN(24) => \slv_reg3_reg0__0_n_129\,
      PCIN(23) => \slv_reg3_reg0__0_n_130\,
      PCIN(22) => \slv_reg3_reg0__0_n_131\,
      PCIN(21) => \slv_reg3_reg0__0_n_132\,
      PCIN(20) => \slv_reg3_reg0__0_n_133\,
      PCIN(19) => \slv_reg3_reg0__0_n_134\,
      PCIN(18) => \slv_reg3_reg0__0_n_135\,
      PCIN(17) => \slv_reg3_reg0__0_n_136\,
      PCIN(16) => \slv_reg3_reg0__0_n_137\,
      PCIN(15) => \slv_reg3_reg0__0_n_138\,
      PCIN(14) => \slv_reg3_reg0__0_n_139\,
      PCIN(13) => \slv_reg3_reg0__0_n_140\,
      PCIN(12) => \slv_reg3_reg0__0_n_141\,
      PCIN(11) => \slv_reg3_reg0__0_n_142\,
      PCIN(10) => \slv_reg3_reg0__0_n_143\,
      PCIN(9) => \slv_reg3_reg0__0_n_144\,
      PCIN(8) => \slv_reg3_reg0__0_n_145\,
      PCIN(7) => \slv_reg3_reg0__0_n_146\,
      PCIN(6) => \slv_reg3_reg0__0_n_147\,
      PCIN(5) => \slv_reg3_reg0__0_n_148\,
      PCIN(4) => \slv_reg3_reg0__0_n_149\,
      PCIN(3) => \slv_reg3_reg0__0_n_150\,
      PCIN(2) => \slv_reg3_reg0__0_n_151\,
      PCIN(1) => \slv_reg3_reg0__0_n_152\,
      PCIN(0) => \slv_reg3_reg0__0_n_153\,
      PCOUT(47 downto 0) => \NLW_slv_reg3_reg0__1_PCOUT_UNCONNECTED\(47 downto 0),
      RSTA => '0',
      RSTALLCARRYIN => '0',
      RSTALUMODE => '0',
      RSTB => '0',
      RSTC => '0',
      RSTCTRL => '0',
      RSTD => '0',
      RSTINMODE => '0',
      RSTM => '0',
      RSTP => '0',
      UNDERFLOW => \NLW_slv_reg3_reg0__1_UNDERFLOW_UNCONNECTED\
    );
\slv_reg3_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_105\,
      Q => slv_reg3(0),
      R => '0'
    );
\slv_reg3_reg[0]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(0),
      Q => slv_reg3(0),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_95\,
      Q => slv_reg3(10),
      R => '0'
    );
\slv_reg3_reg[10]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(10),
      Q => slv_reg3(10),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_94\,
      Q => slv_reg3(11),
      R => '0'
    );
\slv_reg3_reg[11]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(11),
      Q => slv_reg3(11),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_93\,
      Q => slv_reg3(12),
      R => '0'
    );
\slv_reg3_reg[12]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(12),
      Q => slv_reg3(12),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_92\,
      Q => slv_reg3(13),
      R => '0'
    );
\slv_reg3_reg[13]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(13),
      Q => slv_reg3(13),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_91\,
      Q => slv_reg3(14),
      R => '0'
    );
\slv_reg3_reg[14]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(14),
      Q => slv_reg3(14),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_90\,
      Q => slv_reg3(15),
      R => '0'
    );
\slv_reg3_reg[15]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(15),
      Q => slv_reg3(15),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[19]_i_1_n_7\,
      Q => slv_reg3(16),
      R => '0'
    );
\slv_reg3_reg[16]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(16),
      Q => slv_reg3(16),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[19]_i_1_n_6\,
      Q => slv_reg3(17),
      R => '0'
    );
\slv_reg3_reg[17]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(17),
      Q => slv_reg3(17),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[19]_i_1_n_5\,
      Q => slv_reg3(18),
      R => '0'
    );
\slv_reg3_reg[18]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(18),
      Q => slv_reg3(18),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[19]_i_1_n_4\,
      Q => slv_reg3(19),
      R => '0'
    );
\slv_reg3_reg[19]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(19),
      Q => slv_reg3(19),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[19]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \slv_reg3_reg[19]_i_1_n_0\,
      CO(2) => \slv_reg3_reg[19]_i_1_n_1\,
      CO(1) => \slv_reg3_reg[19]_i_1_n_2\,
      CO(0) => \slv_reg3_reg[19]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \slv_reg3_reg0__1_n_103\,
      DI(2) => \slv_reg3_reg0__1_n_104\,
      DI(1) => \slv_reg3_reg0__1_n_105\,
      DI(0) => '0',
      O(3) => \slv_reg3_reg[19]_i_1_n_4\,
      O(2) => \slv_reg3_reg[19]_i_1_n_5\,
      O(1) => \slv_reg3_reg[19]_i_1_n_6\,
      O(0) => \slv_reg3_reg[19]_i_1_n_7\,
      S(3) => \slv_reg3[19]_i_2_n_0\,
      S(2) => \slv_reg3[19]_i_3_n_0\,
      S(1) => \slv_reg3[19]_i_4_n_0\,
      S(0) => \slv_reg3_reg0__0_n_89\
    );
\slv_reg3_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_104\,
      Q => slv_reg3(1),
      R => '0'
    );
\slv_reg3_reg[1]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(1),
      Q => slv_reg3(1),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[23]_i_1_n_7\,
      Q => slv_reg3(20),
      R => '0'
    );
\slv_reg3_reg[20]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(20),
      Q => slv_reg3(20),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[23]_i_1_n_6\,
      Q => slv_reg3(21),
      R => '0'
    );
\slv_reg3_reg[21]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(21),
      Q => slv_reg3(21),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[23]_i_1_n_5\,
      Q => slv_reg3(22),
      R => '0'
    );
\slv_reg3_reg[22]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(22),
      Q => slv_reg3(22),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[23]_i_1_n_4\,
      Q => slv_reg3(23),
      R => '0'
    );
\slv_reg3_reg[23]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[23]__0_i_1_n_0\,
      D => s00_axi_wdata(23),
      Q => slv_reg3(23),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[23]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \slv_reg3_reg[19]_i_1_n_0\,
      CO(3) => \slv_reg3_reg[23]_i_1_n_0\,
      CO(2) => \slv_reg3_reg[23]_i_1_n_1\,
      CO(1) => \slv_reg3_reg[23]_i_1_n_2\,
      CO(0) => \slv_reg3_reg[23]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \slv_reg3_reg0__1_n_99\,
      DI(2) => \slv_reg3_reg0__1_n_100\,
      DI(1) => \slv_reg3_reg0__1_n_101\,
      DI(0) => \slv_reg3_reg0__1_n_102\,
      O(3) => \slv_reg3_reg[23]_i_1_n_4\,
      O(2) => \slv_reg3_reg[23]_i_1_n_5\,
      O(1) => \slv_reg3_reg[23]_i_1_n_6\,
      O(0) => \slv_reg3_reg[23]_i_1_n_7\,
      S(3) => \slv_reg3[23]_i_2_n_0\,
      S(2) => \slv_reg3[23]_i_3_n_0\,
      S(1) => \slv_reg3[23]_i_4_n_0\,
      S(0) => \slv_reg3[23]_i_5_n_0\
    );
\slv_reg3_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[27]_i_1_n_7\,
      Q => slv_reg3(24),
      R => '0'
    );
\slv_reg3_reg[24]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(24),
      Q => slv_reg3(24),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[27]_i_1_n_6\,
      Q => slv_reg3(25),
      R => '0'
    );
\slv_reg3_reg[25]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(25),
      Q => slv_reg3(25),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[27]_i_1_n_5\,
      Q => slv_reg3(26),
      R => '0'
    );
\slv_reg3_reg[26]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(26),
      Q => slv_reg3(26),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[27]_i_1_n_4\,
      Q => slv_reg3(27),
      R => '0'
    );
\slv_reg3_reg[27]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(27),
      Q => slv_reg3(27),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[27]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \slv_reg3_reg[23]_i_1_n_0\,
      CO(3) => \slv_reg3_reg[27]_i_1_n_0\,
      CO(2) => \slv_reg3_reg[27]_i_1_n_1\,
      CO(1) => \slv_reg3_reg[27]_i_1_n_2\,
      CO(0) => \slv_reg3_reg[27]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => \slv_reg3_reg0__1_n_95\,
      DI(2) => \slv_reg3_reg0__1_n_96\,
      DI(1) => \slv_reg3_reg0__1_n_97\,
      DI(0) => \slv_reg3_reg0__1_n_98\,
      O(3) => \slv_reg3_reg[27]_i_1_n_4\,
      O(2) => \slv_reg3_reg[27]_i_1_n_5\,
      O(1) => \slv_reg3_reg[27]_i_1_n_6\,
      O(0) => \slv_reg3_reg[27]_i_1_n_7\,
      S(3) => \slv_reg3[27]_i_2_n_0\,
      S(2) => \slv_reg3[27]_i_3_n_0\,
      S(1) => \slv_reg3[27]_i_4_n_0\,
      S(0) => \slv_reg3[27]_i_5_n_0\
    );
\slv_reg3_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[31]_i_1_n_7\,
      Q => slv_reg3(28),
      R => '0'
    );
\slv_reg3_reg[28]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(28),
      Q => slv_reg3(28),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[31]_i_1_n_6\,
      Q => slv_reg3(29),
      R => '0'
    );
\slv_reg3_reg[29]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(29),
      Q => slv_reg3(29),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_103\,
      Q => slv_reg3(2),
      R => '0'
    );
\slv_reg3_reg[2]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(2),
      Q => slv_reg3(2),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[31]_i_1_n_5\,
      Q => slv_reg3(30),
      R => '0'
    );
\slv_reg3_reg[30]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(30),
      Q => slv_reg3(30),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg[31]_i_1_n_4\,
      Q => slv_reg3(31),
      R => '0'
    );
\slv_reg3_reg[31]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[31]__0_i_1_n_0\,
      D => s00_axi_wdata(31),
      Q => slv_reg3(31),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[31]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \slv_reg3_reg[27]_i_1_n_0\,
      CO(3) => \NLW_slv_reg3_reg[31]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \slv_reg3_reg[31]_i_1_n_1\,
      CO(1) => \slv_reg3_reg[31]_i_1_n_2\,
      CO(0) => \slv_reg3_reg[31]_i_1_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2) => \slv_reg3_reg0__1_n_92\,
      DI(1) => \slv_reg3_reg0__1_n_93\,
      DI(0) => \slv_reg3_reg0__1_n_94\,
      O(3) => \slv_reg3_reg[31]_i_1_n_4\,
      O(2) => \slv_reg3_reg[31]_i_1_n_5\,
      O(1) => \slv_reg3_reg[31]_i_1_n_6\,
      O(0) => \slv_reg3_reg[31]_i_1_n_7\,
      S(3) => \slv_reg3[31]_i_2_n_0\,
      S(2) => \slv_reg3[31]_i_3_n_0\,
      S(1) => \slv_reg3[31]_i_4_n_0\,
      S(0) => \slv_reg3[31]_i_5_n_0\
    );
\slv_reg3_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_102\,
      Q => slv_reg3(3),
      R => '0'
    );
\slv_reg3_reg[3]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(3),
      Q => slv_reg3(3),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_101\,
      Q => slv_reg3(4),
      R => '0'
    );
\slv_reg3_reg[4]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(4),
      Q => slv_reg3(4),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_100\,
      Q => slv_reg3(5),
      R => '0'
    );
\slv_reg3_reg[5]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(5),
      Q => slv_reg3(5),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_99\,
      Q => slv_reg3(6),
      R => '0'
    );
\slv_reg3_reg[6]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(6),
      Q => slv_reg3(6),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_98\,
      Q => slv_reg3(7),
      R => '0'
    );
\slv_reg3_reg[7]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[7]__0_i_1_n_0\,
      D => s00_axi_wdata(7),
      Q => slv_reg3(7),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_97\,
      Q => slv_reg3(8),
      R => '0'
    );
\slv_reg3_reg[8]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(8),
      Q => slv_reg3(8),
      R => axi_awready_i_1_n_0
    );
\slv_reg3_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => '1',
      D => \slv_reg3_reg0__0_n_96\,
      Q => slv_reg3(9),
      R => '0'
    );
\slv_reg3_reg[9]__0\: unisim.vcomponents.FDRE
     port map (
      C => s00_axi_aclk,
      CE => \slv_reg3[15]__0_i_1_n_0\,
      D => s00_axi_wdata(9),
      Q => slv_reg3(9),
      R => axi_awready_i_1_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_mysimple_multi_0_0_mysimple_multi is
  port (
    axi_awready_reg : out STD_LOGIC;
    axi_arready_reg : out STD_LOGIC;
    axi_rvalid_reg : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_aresetn : in STD_LOGIC;
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_bready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_mysimple_multi_0_0_mysimple_multi : entity is "mysimple_multi";
end design_1_mysimple_multi_0_0_mysimple_multi;

architecture STRUCTURE of design_1_mysimple_multi_0_0_mysimple_multi is
begin
mysimple_multi_slave_lite_v1_0_S00_AXI_inst: entity work.design_1_mysimple_multi_0_0_mysimple_multi_slave_lite_v1_0_S00_AXI
     port map (
      axi_arready_reg_0 => axi_arready_reg,
      axi_awready_reg_0 => axi_awready_reg,
      axi_rvalid_reg_0 => axi_rvalid_reg,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_araddr(1 downto 0) => s00_axi_araddr(1 downto 0),
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_awaddr(1 downto 0) => s00_axi_awaddr(1 downto 0),
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_rdata(31 downto 0) => s00_axi_rdata(31 downto 0),
      s00_axi_rready => s00_axi_rready,
      s00_axi_wdata(31 downto 0) => s00_axi_wdata(31 downto 0),
      s00_axi_wready => s00_axi_wready,
      s00_axi_wstrb(3 downto 0) => s00_axi_wstrb(3 downto 0),
      s00_axi_wvalid => s00_axi_wvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_mysimple_multi_0_0 is
  port (
    s00_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_awvalid : in STD_LOGIC;
    s00_axi_awready : out STD_LOGIC;
    s00_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_wvalid : in STD_LOGIC;
    s00_axi_wready : out STD_LOGIC;
    s00_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_bvalid : out STD_LOGIC;
    s00_axi_bready : in STD_LOGIC;
    s00_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s00_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s00_axi_arvalid : in STD_LOGIC;
    s00_axi_arready : out STD_LOGIC;
    s00_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s00_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s00_axi_rvalid : out STD_LOGIC;
    s00_axi_rready : in STD_LOGIC;
    s00_axi_aclk : in STD_LOGIC;
    s00_axi_aresetn : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_mysimple_multi_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_mysimple_multi_0_0 : entity is "design_1_mysimple_multi_0_0,mysimple_multi,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_mysimple_multi_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_mysimple_multi_0_0 : entity is "mysimple_multi,Vivado 2024.2";
end design_1_mysimple_multi_0_0;

architecture STRUCTURE of design_1_mysimple_multi_0_0 is
  signal \<const0>\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of s00_axi_aclk : signal is "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of s00_axi_aclk : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of s00_axi_aclk : signal is "XIL_INTERFACENAME S00_AXI_CLK, ASSOCIATED_BUSIF S00_AXI, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_1_0_clk_out1, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 S00_AXI_RST RST";
  attribute X_INTERFACE_MODE of s00_axi_aresetn : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s00_axi_aresetn : signal is "XIL_INTERFACENAME S00_AXI_RST, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axi_arready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY";
  attribute X_INTERFACE_INFO of s00_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID";
  attribute X_INTERFACE_INFO of s00_axi_awready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY";
  attribute X_INTERFACE_INFO of s00_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID";
  attribute X_INTERFACE_INFO of s00_axi_bready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BREADY";
  attribute X_INTERFACE_INFO of s00_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BVALID";
  attribute X_INTERFACE_INFO of s00_axi_rready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RREADY";
  attribute X_INTERFACE_INFO of s00_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RVALID";
  attribute X_INTERFACE_INFO of s00_axi_wready : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WREADY";
  attribute X_INTERFACE_INFO of s00_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WVALID";
  attribute X_INTERFACE_INFO of s00_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR";
  attribute X_INTERFACE_INFO of s00_axi_arprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT";
  attribute X_INTERFACE_INFO of s00_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR";
  attribute X_INTERFACE_MODE of s00_axi_awaddr : signal is "slave";
  attribute X_INTERFACE_PARAMETER of s00_axi_awaddr : signal is "XIL_INTERFACENAME S00_AXI, WIZ_DATA_WIDTH 32, WIZ_NUM_REG 4, SUPPORTS_NARROW_BURST 0, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 100000000, ID_WIDTH 0, ADDR_WIDTH 4, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_clk_wiz_1_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s00_axi_awprot : signal is "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT";
  attribute X_INTERFACE_INFO of s00_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI BRESP";
  attribute X_INTERFACE_INFO of s00_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RDATA";
  attribute X_INTERFACE_INFO of s00_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 S00_AXI RRESP";
  attribute X_INTERFACE_INFO of s00_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WDATA";
  attribute X_INTERFACE_INFO of s00_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB";
begin
  s00_axi_bresp(1) <= \<const0>\;
  s00_axi_bresp(0) <= \<const0>\;
  s00_axi_rresp(1) <= \<const0>\;
  s00_axi_rresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.design_1_mysimple_multi_0_0_mysimple_multi
     port map (
      axi_arready_reg => s00_axi_arready,
      axi_awready_reg => s00_axi_awready,
      axi_rvalid_reg => s00_axi_rvalid,
      s00_axi_aclk => s00_axi_aclk,
      s00_axi_araddr(1 downto 0) => s00_axi_araddr(3 downto 2),
      s00_axi_aresetn => s00_axi_aresetn,
      s00_axi_arvalid => s00_axi_arvalid,
      s00_axi_awaddr(1 downto 0) => s00_axi_awaddr(3 downto 2),
      s00_axi_awvalid => s00_axi_awvalid,
      s00_axi_bready => s00_axi_bready,
      s00_axi_bvalid => s00_axi_bvalid,
      s00_axi_rdata(31 downto 0) => s00_axi_rdata(31 downto 0),
      s00_axi_rready => s00_axi_rready,
      s00_axi_wdata(31 downto 0) => s00_axi_wdata(31 downto 0),
      s00_axi_wready => s00_axi_wready,
      s00_axi_wstrb(3 downto 0) => s00_axi_wstrb(3 downto 0),
      s00_axi_wvalid => s00_axi_wvalid
    );
end STRUCTURE;
