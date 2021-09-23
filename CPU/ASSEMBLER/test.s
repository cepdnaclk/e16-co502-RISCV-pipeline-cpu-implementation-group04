addi x1 x0 5
ori x2 x0 5
add x3 x1 x2
beq x1 x2 8
sw x3 4(x0)
bne x1 x3 4
slli x1 x2 3
sub x5 x1 x30
