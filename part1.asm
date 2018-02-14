# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# C S E 3 3 1  -  C O M P U T E R   O R G A N I Z A T I O N
# P R O J E C T  I 
# P A R T  I
# 
# written by Ahmet Mert Gulbahce
# 			 141044015	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# --------------------------------------------------------------------- 
# M A I N
# --------------------------------------------------------------------- 
				.globl main
				.text
main:	
				# READ 1ST INT
				li		$v0, 5		# read int
				syscall
				move 	$s0, $v0	
				
				# READ 2ND INT
				li		$v0, 5		# read int
				syscall
				move 	$s2, $v0
				
				# READ SIGN
				li 		$v0, 8 		# read char
				la 		$a0, sign	
				li 		$a1, 4		
				move 	$t0, $a0 	
				syscall
				
				# READ 1ST INT
				li		$v0, 5		# read int
				syscall
				move 	$s1, $v0
				
				# READ 2ND INT
				li		$v0, 5		# read int
				syscall
				move 	$s3, $v0
				
				lb		$t3, sign				
				beq		$t3, '+', addition			# if(sign == '+') -> addition
				beq		$t3, '-', subtraction		# if(sign == '-') -> subtraction
				beq		$t3, '*', multiplication	# if(sign == '*') -> multiplication
				
				j		exit

# --------------------------------------------------------------------- 
# A D D I T I O N
# --------------------------------------------------------------------- 
# Used Registers
# ----------------
# $s0 <- a1
# $s1 <- a2
# $s2 <- b1
# $s3 <- b2	
# $s4 <- power difference
# $s5 <- maxDigit
# $s6 <- totalDigit2	
# $s7 <- totalDigit1
# ---------------------------------------------------------------------
addition:
				move	$a0, $s2			# $a0 = b1
				move	$a1, $zero			# (digit counter) = 0
				jal		digit				# jump digit and return
				move	$s7, $a1			# $s7 <- totalDigit1
				
				move	$a0, $s3			# $a0 = b2
				move	$a1, $zero			# (digit counter) = 0
				jal		digit				# jump digit and return
				move	$s6, $a1			# $s6 <- totalDigit2
				
				bgt		$s7, $s6, greatA	# if($s7 > $s6) -> greatA
				blt		$s7, $s6, lessA		# if($s7 < $s6) -> lessA
				j		greatA
			
	greatA: 
				add		$t7, $s0, $s1		# $t7 = a1 + a2
				
				move 	$s5, $s7			# $s5(Max)  = $s7
				sub 	$s4, $s7, $s6		# Diff = Dig1-Dig2
				move 	$a0, $s4			# $a0 <- pow (diff)
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				mult 	$s3, $a2			# b2*10^diff
				mflo 	$s3					# b2 = b2*10^diff
				add 	$t6, $s2, $s3       # $t6 = $s2 + $s3 (temp sum)
				
				move 	$a0, $s5			# $a0 <- max
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				move 	$t1, $a2			# $t1 = result (10^max)
				
		
				blt		$t6, $t1, pA		# if(temp sum < 10^max)
				addi	$t7, 1				# $t7 + 1
				sub		$t6, $t6, $t1		# $t4 10^max - temp sum
				j		pA
			
	lessA: 
				add		$t7, $s0, $s1		# $t7 = a1 + a2
				
				move 	$s5, $s6			# $s5(Max)  = $s6
				sub 	$s4, $s6, $s7		# Diff = Dig1-Dig2
				move 	$a0, $s4			# $a0 <- pow (diff)
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				mult 	$s2, $a2			# b2*10^diff
				mflo 	$s2					# b2 = b2*10^diff
				add 	$t6, $s3, $s2       # $t6 = $s3 + $s2 (temp sum)
				
				move 	$a0, $s5			# $a0 <- max
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				move 	$t1, $a2			# $t1 = result (10^max)
				
		
				blt		$t6, $t1, pA		# if(temp sum < 10^max)
				addi	$t7, 1				# $t7 + 1
				sub		$t6, $t6, $t1		# $t6 = 10^max - temp sum
				j		pA
			
		pA:									# print result
				li		$v0, 1				# print int
				move	$a0, $t7
				syscall
				li		$v0, 4				# print comma
				la		$a0, comma
				syscall
				li		$v0, 1				# print int
				move	$a0, $t6
				syscall
				j 		exit
		
	
			
# --------------------------------------------------------------------- 
# S U B T R A C T I O N
# --------------------------------------------------------------------- 
# Used Registers
# ----------------
# $s0 <- a1
# $s1 <- a2
# $s2 <- b1
# $s3 <- b2	
# $s4 <- power difference
# $s5 <- maxDigit
# $s6 <- totalDigit2	
# $s7 <- totalDigit1
# ---------------------------------------------------------------------
subtraction:
				move	$a0, $s2			# $a0 = b1
				move	$a1, $zero			# (digit counter) = 0
				jal		digit				# jump digit and return
				move	$s7, $a1			# $s7 <- totalDigit1
				
				move	$a0, $s3			# $a0 = b2
				move	$a1, $zero			# (digit counter) = 0
				jal		digit				# jump digit and return
				move	$s6, $a1			# $s6 <- totalDigit2
				
				bgt		$s7, $s6, greatS	# if($s7 > $s6) -> greatS
				blt		$s7, $s6, lessS		# if($s7 < $s6) -> lessS
				j		greatS
			
	greatS: 
				sub		$t7, $s0, $s1		# $t7 = a1 - a2
				
				move 	$s5, $s7			# $s5(Max)  = $s7
				sub 	$s4, $s7, $s6		# Diff = Dig1-Dig2
				move 	$a0, $s4			# $a0 <- pow (diff)
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				mult 	$s3, $a2			# b2*10^diff
				mflo 	$s3					# b2 = b2*10^diff
				sub 	$t6, $s2, $s3       # $t6 = $s2 - $s3 (temp sub)
				
				move 	$a0, $s5			# $a0 <- max
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				move 	$t1, $a2			# $t1 = result (10^max)
				
		
				bge		$t6, $zero, pS		# if(temp sub >= 0)
				sub		$t7, $t7, 1			# $t7 - 1
				add		$t6, $t6, $t1		# $t6 = 10^max + temp sum
				j		pS
			
	lessS: 
				sub		$t7, $s0, $s1		# $t7 = a1 - a2
				
				move 	$s5, $s6			# $s5(Max)  = $s6
				sub 	$s4, $s6, $s7		# Diff = Dig1-Dig2
				move 	$a0, $s4			# $a0 <- pow (diff)
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				mult 	$s2, $a2			# b2*10^diff
				mflo 	$s2					# b2 = b2*10^diff
				sub 	$t6, $s2, $s3       # $t6 = $s2 - $s3 (temp sub)
				
				move 	$a0, $s5			# $a0 <- max
				li 		$a1, 10				# $a1 <- num (10)
				li		$a2 1				# $a2(result) = 1 
				jal 	power
				move 	$t1, $a2			# $t1 = result (10^max)
				
		
				bge		$t6, $zero, pS		# if(temp sub >= 0)
				sub		$t7, $t7, 1			# $t7 - 1
				add		$t6, $t6, $t1		# $t6 = 10^max + temp sum
				j		pS
			
		pS:									# print result
				li		$v0, 1				# print int
				move	$a0, $t7
				syscall
				li		$v0, 4				# print comma
				la		$a0, comma
				syscall
				
				move	$a0, $t6			# $a0 = b2
				move	$a1, $zero			# (digit counter) = 0
				jal		digit				# jump digit and return
				move	$s6, $a1			# $s6 <- totalDigit
				
				bgt		$s6, $s5, pSS
				sub 	$s6, $s5, $s6
			AA: beq		$s6, $zero, pSS
				li		$v0, 1				# print int
				move	$a0, $zero
				syscall
				li		$s5, 1
				sub 	$s6, $s6, $s5
				j		AA
				
				
			pSS:
				li		$v0, 1				# print int
				move	$a0, $t6
				syscall
				j 		exit
			
# --------------------------------------------------------------------- 
# M U L T I P L I C A T I O N
# ---------------------------------------------------------------------
multiplication:
				j 		exit
				
				
	


# --------------------------------------------------------------------- 
# D I G I T
# ---------------------------------------------------------------------
# Parameters
# -------------
# $a0 <- number
# $a1 <- digit counter
# ---------------------------------------------------------------------
digit:
			beq		$a0, $zero, return
			li		$t0, 10				# $t0 = 10
			div 	$a0, $t0			# $a0 / 10
			mflo	$a0					# $a0 = $a0 / 10
			addi	$a1, 1				# (digit counter)++
			j		digit				# loop


# --------------------------------------------------------------------- 
# P O W E R
# ---------------------------------------------------------------------
# Parameters
# -------------
# $a0 <- exponent
# $a1 <- number
# ---------------------------------------------------------------------
power:	
			beq 	$a0, $zero, return	# if(exponent == 0) -> return
			mult	$a2, $a1			# result*number
			mflo	$a2					# result = result*number
			li		$t0, 1				# $t0 = 1;
			sub		$a0, $a0, $t0		# $a0 = $a0 - $t0
			j		power				# loop
			
# --------------------------------------------------------------------- 
# R E T U R N
# ---------------------------------------------------------------------
return:
			jr		$ra

# --------------------------------------------------------------------- 
# E X I T
# ---------------------------------------------------------------------
exit:		
			li      $v0, 10				# terminate program run and
			syscall						# Exit 
			

# --------------------------------------------------------------------- 
# D A TA
# ---------------------------------------------------------------------
			.data
comma:		.asciiz		","
sign:		.byte		4
