addi x1 x0 10
ori x2 x0 5
add x3 x1 x2
slli x1 x2 3
sub x5 x1 x30
lw x2 60(x2)
sw x3 60(x3)
sub x4 x1 x2