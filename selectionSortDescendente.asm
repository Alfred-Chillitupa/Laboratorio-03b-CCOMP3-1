.text
	.globl __main

	__main:
	
	la $a0, array
	addi $a1,$a0,28
	
	sort: 
		beq $a0,$a1,done # single-element list is sorted
		jal max # call the max procedure
		lw $t0,0($a1) # load last element into $t0
		sw $t0,0($v0) # copy the last element to max loc
		sw $v1,0($a1) # copy max value to last element
		addi $a1,$a1,-4 # decrement pointer to last element
		j sort # repeat sort for smaller list
	done:
	
	la $a0, strArr
	li $v0, 4
	syscall
	addi $t0, $zero, 0
	
	print:
		beq $t0, 32, end
		lw $t6, array($t0)
		addi $t0, $t0, 4
		
		li $v0, 1
		move $a0, $t6
		syscall
		
		la $a0,space
		li $v0,4
		syscall
		
		j print
	end:
	
 li $v0, 10
 syscall
	
	
	max: 
		li $t3, 0     # counter 0
		lw $t2, array # max
		la $v0, array # address max
		loop:
			addi $t3,$t3,4 # counter += 4
			add $t1, $a0, $t3 # INI ++
		
			slt $t5,$a1,$t1 # ini > FIN
			beq $t5,1,endloop
			
			lw $t4, 0($t1) #next element
		
			slt $t5, $t2, $t4 # max < ini
			beq $t5, 1 , loop #1 para descendente
			
			add $t2, $t4 , 0 # max = ini
			la $v0,array+0($t3)
			j loop
		endloop:
		
		addi $v1,$t2,0
		
		jr $ra

.data
	array: .word 2,3,1,5,7,1,8,4
	strArr: .asciiz "Arreglo ordenado: "
	space: .asciiz "  "
