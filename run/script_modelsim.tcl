
vlib work

#set test "eth_frame_tb"
#set test "eth_10base_t_tx_tb"
set test "eth_nlp_tb"

set i0 +incdir+../rtl
set i1 +incdir+../tb

set s0 ../rtl/*.*v
set s1 ../tb/*.*v

vlog $i0 $i1 $s0 $s1

if {$test == "eth_frame_tb"} {
    vsim -novopt work.eth_frame_tb
    add wave -radix hexadecimal -position insertpoint sim:/eth_frame_tb/*
    add wave -radix hexadecimal -position insertpoint sim:/eth_frame_tb/eth_frame_0/*
} elseif {$test == "eth_10base_t_tx_tb"} {
    vsim -novopt work.eth_10base_t_tx_tb
    add wave -radix hexadecimal -position insertpoint sim:/eth_10base_t_tx_tb/*
    add wave -radix hexadecimal -position insertpoint sim:/eth_10base_t_tx_tb/eth_10base_t_tx_0/*
} elseif {$test == "eth_nlp_tb"} {
    vsim -novopt work.eth_nlp_tb
    add wave -radix hexadecimal -position insertpoint sim:/eth_nlp_tb/*
    add wave -radix hexadecimal -position insertpoint sim:/eth_nlp_tb/eth_nlp_0/*
}

run -all

wave zoom full

#quit
