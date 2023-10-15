transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Jiova/OneDrive/04.\ University\ of\ Washington\ Career/04-Fourth\ Year/Quarter\ 1/EE\ 371/Labs/EE371-Labs/Lab\ 2/Lab\ 2 {C:/Users/Jiova/OneDrive/04. University of Washington Career/04-Fourth Year/Quarter 1/EE 371/Labs/EE371-Labs/Lab 2/Lab 2/ram32x3.v}
vlog -sv -work work +incdir+C:/Users/Jiova/OneDrive/04.\ University\ of\ Washington\ Career/04-Fourth\ Year/Quarter\ 1/EE\ 371/Labs/EE371-Labs/Lab\ 2/Lab\ 2 {C:/Users/Jiova/OneDrive/04. University of Washington Career/04-Fourth Year/Quarter 1/EE 371/Labs/EE371-Labs/Lab 2/Lab 2/task1.sv}

