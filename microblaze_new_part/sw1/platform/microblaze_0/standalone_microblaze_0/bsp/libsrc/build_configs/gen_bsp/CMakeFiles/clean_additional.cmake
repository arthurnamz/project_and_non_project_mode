# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "")
  file(REMOVE_RECURSE
  "/home/arthur/Documents/FPGA_master_class/project_and_non_project_mode/microblaze_new_part/sw1/platform/microblaze_0/standalone_microblaze_0/bsp/include/sleep.h"
  "/home/arthur/Documents/FPGA_master_class/project_and_non_project_mode/microblaze_new_part/sw1/platform/microblaze_0/standalone_microblaze_0/bsp/include/xiltimer.h"
  "/home/arthur/Documents/FPGA_master_class/project_and_non_project_mode/microblaze_new_part/sw1/platform/microblaze_0/standalone_microblaze_0/bsp/include/xtimer_config.h"
  "/home/arthur/Documents/FPGA_master_class/project_and_non_project_mode/microblaze_new_part/sw1/platform/microblaze_0/standalone_microblaze_0/bsp/lib/libxiltimer.a"
  )
endif()
