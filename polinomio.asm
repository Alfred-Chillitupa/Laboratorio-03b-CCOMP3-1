.text
	.globl __main
	
	__main: 
	
	la $a0, str1 # Imprime "str1"
	li $v0, 4
	syscall
	
	li $v0, 5    # Recibe el grado del polinomio
	syscall
	
	addi $s0,$v0,0 
	
	li $t0, 1
	add $t0, $t0, $s0 
	
	sw $t0,iter
	
	mul $t0, $t0, 32 
	
	li $v0, 9
	move $a0, $t0
	syscall
	
	la $s1,0($v0)#pointers
	add $s2, $s1, $t0
	
	addi $t1, $s1, 0 
	
	loop:
		
		beq $t1,$s2,endloop
		
		la $a0, str2
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		
		move $t2,$v0
		sw $t2, 0($t1)
		addi $t1, $t1, 32
		j loop
	endloop:
	
	lwc1 $f3, zero
	lwc1 $f29,one
	
	la $a0, str3
	li $v0, 4
	syscall
	
	li $v0, 6
	syscall
	
	add.d $f4,$f0,$f4 #valor del teclado en $f4
	
	addi $t0, $s1, 0 
	
	add.s $f7,$f7, $f3 #mult
	add.s $f12,$f12, $f3 #rpta
	
	polynomial:
		
		beq $t0,$s2,endpolynomial
		
		lwc1 $f5,($t0)
		cvt.s.w $f5, $f5
		
		jal pow
		mul.s $f7,$f5,$f6
		add.s $f12,$f12,$f7
		
		addi $t0, $t0, 32
		addi $s0,$s0,-1
		j polynomial
	endpolynomial:
	
	la $a0, str4
	li $v0, 4
	syscall
	
	
	li $v0, 2
	syscall
	
li $v0, 10
syscall

 	pow:
 		li $t1, 1
 		#resultado en f6
 		add.s $f6,$f3,$f29 
 		beqz $s0,endwhile
 		
 		add.s $f6,$f3,$f3
		add.s $f6,$f4,$f3
 		while:
 		beq  $t1,$s0,endwhile
 			
 		mul.s $f6,$f6,$f4
 		add $t1,$t1,1
 		
 		j while
 		endwhile:
 		add.s $f6,$f6,$f3		
 	jr $ra

.data
	str1: .asciiz "Ingrese en grado del polinomio n: "
	str2: .asciiz "Ingrese coeficiente entero: "
	str3: .asciiz "Ingrese el valor de x en formato float: "
	str4: .asciiz "El resultado final es: "
	iter: .word 0
	
	zero: .float 0.0
	one: .float 1.0