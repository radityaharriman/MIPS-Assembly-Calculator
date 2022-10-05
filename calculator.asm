.data
	prompt1: .asciiz "\nChoose an operation by entering the corresponding number:\n1. Add\n2. Subtract\n3. Multiplication\n4. Division\n5. Modulo\n6. Factorial\n7. Sum\n8. Bin2Dec\n0. End\n"
	prompt2: .asciiz "Enter the first integer:\n"
	prompt3: .asciiz "Enter the second integer:\n"
	result: .asciiz "Result: "
	prompt4: .asciiz "Enter an integer:\n"
	prompt5: .asciiz "Enter a binary number:\n"
	prompt6: .asciiz "You have succesfully exited or an error has occured"
	space: .space 16 	

	
.text
.globl main
main:
	li $v0, 4
    	la $a0, prompt1
    	syscall
    	
    	li $v0, 5
    	syscall
    	move $s0, $v0 #has the operation number
    	
    	#if doesnt need more than 1 integer
    	li $t5, 6 #factorial
    	li $t7, 8 #binary   	    	    	    	
    	
    	beq $t5, $s0, factorial 
    	beq $t7, $s0, bin2dec
    	beq $zero, $s0, end	
    	
    	li $v0, 4
    	la $a0, prompt2
    	syscall
    	
    	li $v0, 5
    	syscall
    	move $s1, $v0 #get first integer
    	
    	li $v0, 4
    	la $a0, prompt3
    	syscall
    	
    	li $v0, 5
    	syscall
    	move $s2, $v0 #get second integer
    	    	
    	li $t0, 1
    	li $t1, 2
    	li $t2, 3
    	li $t3, 4
    	li $t4, 5
    	li $t6, 7

    	beq $t0, $s0, addition
	beq $t1, $s0, subtraction
	beq $t2, $s0, multiplication
	beq $t3, $s0, division
	beq $t4, $s0, modulo
	beq $t6, $s0, sum

	
addition:
	add $s1, $s1, $s2
	
	li $v0, 4
	la $a0, result
	syscall 
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	j main

subtraction:
	sub $s1, $s1, $s2
	
	li $v0, 4
	la $a0, result
	syscall 
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	j main	
	
 multiplication:
 	mul $s1, $s1, $s2
	
	li $v0, 4
	la $a0, result
	syscall 
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	j main	
	
division:
 	div $s1, $s1, $s2
	
	li $v0, 4
	la $a0, result
	syscall 
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	j main	

modulo:
	div $s1, $s1, $s2
	mfhi $s3
	
	li $v0, 4
	la $a0, result
	syscall 
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	j main	

factorial:
    	li $v0, 4
    	la $a0, prompt4 #ask integer
    	syscall
    	
    	li $v0, 5
    	syscall
    	move $s1, $v0 #move integer to $s1

	li $s3, 1 #load 1 to $s3
	li $s4, 1
	loop:
		ble $s1, 1, exit
		mul $s3, $s3, $s1 #mult 1 with the entered integer
		subi $s1, $s1, 1 #decrement entered integer
		j loop
		
	exit:
		li $v0, 4
		la $a0, result
		syscall
	
		li $v0, 1
		move $a0, $s3
		syscall
	
		j main
	
sum:	
	blt $s2, $s1, end
	li $s4, 0 #upper bound
	add $s4, $s4, $s1
	loop1:
		beq $s4, $s2, exit1 #is upper bound met yet?
		addi $s4, $s4, 1 #increment upper bound
		add $s1, $s1, $s4 #add upper bound and lower bound
		j loop1
	exit1:
		li $v0, 4
		la $a0, result
		syscall
	
		li $v0, 1
		move $a0, $s1
		syscall
	
		j main
		
bin2dec:
	getNum:
		li $v0, 4
    		la $a0, prompt5
    		syscall
    	
    		la $a0, space
    		li $a1, 16	#max is 16
    		li $v0, 8 	#string call 8
    		syscall
    	
    		li $s4, 0 	#load sum to 0
    	
    	startConvert:
    		la $s5, space
    		li $t9, 16
    	firstByte:
    		lb $a0, ($s5)
    		blt $a0, 48, printSum
    		addi $s5, $s5, 1
    		subi $a0, $a0, 48
    		subi $t9, $t9, 1
    		beq $a0, 0, isZero
    		beq $a0, 1, isOne
    		j convert
    	isZero:
    		j firstByte
    	isOne:
    		li $t8, 1
    		sllv $s6, $t8, $t9
    		add $s4, $s4, $s6
    		
    		j firstByte
    	convert:
    	printSum:
    		srlv $s4, $s4, $t9
    		move $a0, $s4      # load sum
 		li $v0, 1      # print int
 		syscall
 		j main
	
end:	
	li $v0, 4
    	la $a0, prompt6
    	syscall
    	
	li $v0, 10
	syscall
	
	
