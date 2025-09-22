
#!/bin/sh
./clean.sh
# ./simulate.sh mem1_tb 
# ./simulate.sh mem2_tb
# ./simulate.sh mem_reader_tb
# ./simulate.sh dotProduct_tb
# ./simulate.sh mem_writer_tb
# ./simulate.sh mem3_tb


# ./simulate.sh input_memory_wrapper_tb
# ./simulate.sh output_memory_wrapper_tb  
./simulate.sh top_level_tb
