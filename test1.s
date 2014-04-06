#include<iregdef.h>
.data
strstuden:
.asciiz " Studen : Phan Thi Thao \n Class : Viet Nhat 6A \n\n\n Content miniProject\n"
stringintroductory:
.asciiz " (7). Write a program to: \n - Input the number of students in class.\n - Input the name and mark of students in class.\n - List students haven’t passed the exam (their mark less than 4).\n\n "
strinputnumber:
.asciiz " Input the number of student in class :\n (If want to end input the number, input not digit) \n"
strinputname:
.asciiz " Input the name of student \n"
strspacename:	.space 128
strinputmark:
.asciiz " \n Input the mark of student \n"
strinputmarkagain: 
.asciiz " Input the mark of student again (0<= mark <=10)! \n"
stringnumber:
.asciiz " %d "
strnsnp:
.asciiz "List students haven’t passed the exam (their mark less than 4)\n \n"
strnoresult:
.asciiz "There is no student who failed ! :)) \n"
strend:
.asciiz "\n \n Program the end??? \n" 

.text
.set noreorder
.globl start
.ent start

start:
	//jal strinputnumberstudent
	nop
	nop

	la a0, strstuden
	jal printf
	nop
	la a0, stringintroductory
	jal printf
	nop
	
	la a0, strinputnumber
	nop
	jal printf
	nop
	
Loopnumber1:
	jal inputnumber
	nop
	addi t0, v0, 1
	bne  t0, zero, Continue1	
	nop
	nop
	j Loopnumber1
	nop
	nop
Continue1:
	jal inputnamemark
	nop
	nop
	la a0, strend
	jal printf
	nop
	nop
	nop
	nop	
.end start

####################*********#######################
# Input the number of students in class.
# Return v0 = number of student in class
/*
.ent inputnumberstudent
inputnumberstudent:
		addi sp, sp, -8
		sw   a0, 0(sp)
		sw	 a1, 4(sp)

		la a0, inputnumberstudent
		jal printf
		nop
		nop	
		
		
		lw a0, 0(sp)
		lw a1, 0(sp)
		addi sp, sp , 8
	

.end inputnumberstudent
*/
####################*********#######################
#input string 
# v0 save integer input


.ent inputnumber
inputnumber:
		addi sp, sp, -8
		sw  a0, 0(sp)
		sw  ra, 4(sp)
			
		li t1,-1		
loopinputnumber:
		jal	 getchar
		nop
		addi a0,v0,0
		
		addi t2, a0, -48
		nop
		bltz t2, exitnumber		#t2<0 ki tu nhap vao ko phai la chu so
		nop
		slti t0, t2,10		#t2>10 ki tu nhap vao ko phai la chu so => t0=0
		nop
		beq  t0, zero, exitnumber
		nop
		jal  putchar				
		nop	
		slti t5, t1, 0	
		beq  t5, zero, Continuenumber	# branch if t5 = 0 => t1>=0
		nop 
		addi t1, t1, 1
Continuenumber:
		sll  t3,t1,3	# t3=8*a	 
		sll  t4,t1,1 	# t4=2*a
		add  t1,t3,t4	# t1=10*a     
		add  t1,t1,t2	# a=a+ t2 (abcd... => ((((0*10 + a)*10 + b)*10 +c)*10 +d).....		
		j    loopinputnumber
		nop				
exitnumber:	
		la  a0, '\n'
		jal putchar
		nop	
		addi v0, t1, 0
	
		nop										
		lw   a0, 0(sp)
		lw   ra, 4(sp)
		addi sp, sp, 8
		jr ra
		nop

.end inputnumber

####################*********#######################

#input name
# v0 : address
# v1 : lengh name
.ent inputname 
inputname:
	addi sp, sp, -8
	sw	a0, 0(sp)
	sw	ra, 4(sp)

	la t0, strspacename
	li v1, 0
	li t1, ' '	# t1 = "space"
	li t2, '\n'	# t2 = "\n"
		
	la  a0, strinputname
	jal printf
	nop	
loopinputname:
	jal getchar
	nop
	addi a0, v0, 0
	beq	 a0, t2, endname			# branch if enter input
	nop
	beq  a0, t1, addcharinname		# branch if space input
	nop	
	slti t4, a0, 65	
	bne  t4, zero, endname			# branch if charter input not letter		
	nop	
	slti t4, a0, 91				
	bne  t4, zero, addcharinname	# branch if charter input is letter
	nop
	slti t4, a0, 97
	bne	 t4, zero, endname			# branch if charter input not letter
	nop
	slti t4, a0, 122			
	bne  t4, zero, addcharinname	# branch if charter input is letter
	nop
	j endname
	nop
	
addcharinname:
	jal  putchar
	nop
	add  t3, t0, v1
	sb   a0, 0(t3)
	nop
	addi v1, v1, 1
	j loopinputname
	nop	
	
endname:
	addi v0, t0, 0			# return address name for v0
	add	 t3, t0, v1
	sb   t2, 0(t3)
	nop
	addi v1, v1, 1
	lw a0, 0(v0)
	lw ra, 4(sp)
	addi sp, sp, 8
	jr ra
	nop 
	nop
.end inputname

####################*********#######################

# input mark 
# return v0
.ent inputmark
inputmark:
	addi sp, sp, -8
	sw a0, 0(sp)
	sw ra, 4(sp)
	
	la	a0, strinputmark
	jal printf
	nop
	jal inputnumber
	nop

Loopmark:
	li t0, -1
	beq v0,t0, Continuemark			# branch if mark < 0
	nop
	slti t1, v0, 11
	bne t1, zero, endmark			# branch if mark <= 10 => thoa man
	nop
Continuemark:
	la a0, strinputmarkagain
	jal printf
	nop
	jal inputnumber
	nop
	
	j Loopmark
	nop
		
endmark:	

	lw a0, 0(sp)
	lw ra, 4(sp)
	addi sp, sp, 8
	jr ra
	nop
.end inputmark


####################*********#######################
#inputnamemark: 
#v0 = the number of student in class


.ent inputnamemark
inputnamemark:
	addi sp, sp, -24
	sw a0, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw v0, 16(sp)
	sw ra, 20(sp)
	
	addi fp,sp, 0
	
	addi s2, v0, 0			# s2 = number of student

Loopinputnm:
	jal inputname
	nop
	
/*	addi a1, s2 ,0 
	la a0,stringnumber
	nop
	jal printf*/
	nop
	addi s0, v0, 0			#t3 = address string name
	addi s1, v1, 0			#t4 = lengh string name	
	nop 
	nop
	jal inputmark
	nop
	addi t2, v0, 0				 #t2 = mark input
	slti t3, t2, 4			 	 # t3= 1 if mark < 4
	beq  t3, zero, Endinputnm	 # branch if t3 = 0 =>mark >= 4 
	nop
	addi a0, s0, 0				 # address of name
//	jal printf
	nop

	addi   t0, s1, 0
addstackname:
	add  t1, t0, a0				 # address of name
	lb   t1, 0(t1)				 # take each letter
	nop	  
	addi sp, sp, -1
	sb	 t1, 0(sp)
	nop
	
	beq  t0, zero, Endinputnm		# branch if t0 =0 => store completed
	nop
	addi t0, t0, -1						
	j	 addstackname
	nop
	nop

	
Endinputnm:
	addi s2, s2, -1 
	nop
	beq  s2, zero, Exitinputnm	 # branch if s2=0 => du so luong n sinh vien
	nop					
	j Loopinputnm
	nop

Exitinputnm:
	la a0, strnsnp
	jal printf
	nop
	bne sp, fp, readnsnp
	nop
	la a0, strnoresult
	jal printf
	nop
	j endreadnsnp 
	nop
readnsnp:					
	lb a0, 0(sp)
	jal putchar
	nop
	addi sp, sp , 1
	sub  t5, sp, fp
	beq  t5, zero ,endreadnsnp 			# branch if sp chi xuong day cua stack
	nop
	j  readnsnp
	nop
	
endreadnsnp:	 		


	lw a0, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw v0, 16(sp)
	lw ra, 20(sp)
	addi sp, sp, 24 
	jr ra
	nop
.end inputnamemark




 