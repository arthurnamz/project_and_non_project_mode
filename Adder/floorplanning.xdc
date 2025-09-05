startgroup
create_pblock pblock_counter_0
resize_pblock pblock_counter_0 -add SLICE_X52Y75:SLICE_X61Y107
add_cells_to_pblock pblock_counter_0 [get_cells [list design_1_i/counter_0]] -clear_locs
endgroup
set_property IS_SOFT 0 [get_pblocks pblock_counter_0]
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_counter_0]
set_property CONTAIN_ROUTING 1 [get_pblocks pblock_counter_0]