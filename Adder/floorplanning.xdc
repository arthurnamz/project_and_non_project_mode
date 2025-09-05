startgroup
create_pblock pblock_adder_i
resize_pblock pblock_adder_i -add SLICE_X52Y200:SLICE_X60Y208
add_cells_to_pblock pblock_adder_i [get_cells [list design_1_i/top_0/inst/adder_i]] -clear_locs
endgroup
set_property IS_SOFT 0 [get_pblocks pblock_adder_i]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_adder_i]
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_adder_i]
startgroup
create_pblock pblock_display_a
resize_pblock pblock_display_a -add SLICE_X56Y142:SLICE_X61Y152
add_cells_to_pblock pblock_display_a [get_cells [list design_1_i/top_0/inst/display_a]] -clear_locs
endgroup
set_property IS_SOFT 0 [get_pblocks pblock_display_a]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_display_a]
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_display_a]
startgroup
create_pblock pblock_display_b
resize_pblock pblock_display_b -add SLICE_X53Y95:SLICE_X57Y104
add_cells_to_pblock pblock_display_b [get_cells [list design_1_i/top_0/inst/display_b]] -clear_locs
endgroup
set_property IS_SOFT 0 [get_pblocks pblock_display_b]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_display_b]
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_display_b]
startgroup
create_pblock pblock_display_sum
resize_pblock pblock_display_sum -add SLICE_X73Y132:SLICE_X78Y144
add_cells_to_pblock pblock_display_sum [get_cells [list design_1_i/top_0/inst/display_sum]] -clear_locs
endgroup
set_property IS_SOFT 0 [get_pblocks pblock_display_sum]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_display_sum]
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_display_sum]
