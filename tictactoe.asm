[org 0x100]

	jmp start
;==============================
;	info pool
;==============================
;each square 3rows 5 cols  3x5
;27 cols on left
;28 cols on right
;3 rows on bottom and top

;grid 19rows n 25 cols   19x25


; midpoints of boxes
;row1:  1154, 1168, 1182, 1196
;row2:  1794, 1808, 1822, 1836
;row3:   2434, 2448, 2462, 2476
;row4:   3074, 3088, 3102, 3116

;______________________________
;col1:  1154, 1794, 2434, 3074
;col2:  1168, 1808, 2448, 3088
;col3:   1182, 1822, 2462, 3102
;col4:   1196, 1836, 2476, 3116

;_______________________________

;diagonal1: 1154, 1808, 2462, 3116
;diagonal2: 3074, 2448, 1822, 1196



;=============================
;	info pool ended
;==============================




;==============================
;	VARIABLES
;==============================

turn: dw 2
position: dw 0			;the user choice
repStatus: dw 0			;1 (if choice repeated) , 0 (if vacant)
place: dw 0			;final offset to place the sign of player
Win: dw 0				; if wins then 1
count: dw 0			;count of same vals in (r,c,d)

player1: dw 'PLAYER ONE HAS WON THE GAME!' 
lenp1: dw 28

player2: dw 'PLAYER TWO HAS WON THE GAME!' 
lenp2: dw 28

draw: dw 'MATCH DRAWN!'
lenD: dw 12

welcome: dw 'WELCOME TO THE GAME'
length01: dw 19

press: dw 'press ANY key to play'
length02: dw 21

gameOver: dw 'GAME OVER!'
length03: dw 10


;==============================
;	VARIABLES ended
;==============================

;===================================================================================================================
;				FIRST SCREEN CODE
;===================================================================================================================


;---------------------------------------------------------

INFINITE:
	pusha
	
	mov cx,40000

lfn:
	sub cx,1
	cmp cx,0
	jne lfn

	popa
	
	ret
;---------------------------------------------------------


;=======================================================================
;				fire ball
;=======================================================================

;_________
fireBall:
;_________

	push es 
 	push ax 
 	push di



	

;----------------------------------------------------------------------------------blue 0001
	mov ax, 0xb800 
 	mov es, ax ; 
 	mov di, 0 

mov ax,0
mov ah,00000001b

mov al,"*"

nextloc1: 
	mov word [es:di], ax
	call INFINITE
 	add di, 320 
 	cmp di, 3840  
	jne nextloc1  

nextloc2: 
	mov word [es:di], ax
	call INFINITE
 	add di, 4 
 	cmp di, 3996  
	jne nextloc2  

	mov word [es:di], ax		;at 3996
	mov di,3838		;
 	
nextloc3: 
	mov word [es:di], ax
	call INFINITE
 	sub di, 320 
 	cmp di, 318  
	jne nextloc3  

	
	mov di,158
nextloc4: 
	mov word [es:di], ax
	call INFINITE
 	sub di, 4 
 	cmp di, 2  
	jne nextloc4  



;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------fireBall!



;--------------------------------------------------------------------------------------------------------------------------------------------------------POPPING 

	pop di
	pop ax
	pop es

	ret 

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ENDOfFIREbALL!


;=======================================================================
;				end of fire ball
;=======================================================================



;=======================================================================
;				the outline
;=======================================================================

printOutline:
	pusha
	
	mov ax, 0xb800 
 	mov es, ax 	; 

mov ax,0
mov ah,01000000b
mov al,0h

	mov di,500
	mov cx,19

po1:
	mov word[es:di],ax
	add di,160
	loop po1

	mov di,618
	mov cx,19

po2:
	mov word[es:di],ax
	add di,160
	loop po2

	mov di,502
	mov cx,58

po3:
	mov word[es:di],ax
	add di,2
	loop po3

	mov di,3382
	mov cx,58

po4:
	mov word[es:di],ax
	add di,2
	loop po4






	popa
	ret

	

;=======================================================================
;				the outline
;=======================================================================








;======================================================================
; 		play first screen
;======================================================================

playFirstScreen:
	pusha

	call clearScreen
	call fireBall
	;call backGround
	call clearScreen

	call printOutline





	mov ax,1810	;starting offset (bp+8)
	push ax
	mov ax, welcome 
 	push ax 
 	push word [length01] 
 	call printstr1


	mov ax,2130	;starting offset (bp+8)
	push ax
	mov ax, press 
 	push ax 
 	push word [length02] 
 	call printstr1

	mov ah,0
	int 16h


	popa
	ret

;======================================================================
; 		play first screen ended
;======================================================================




;##############################################################################################################
;				THE THIRD SCREEN  CODE STARTS HERE
;##############################################################################################################

;____________________________________________________________________________________________________________________

;-------------------------------------------------------------------------------------------------		BLUE LINE################

bottomLine:

	push es 
 	push ax 
 	push di


	mov ax, 0xb800 
 	mov es, ax  

mov ax,0
mov ah,00000000b		;01100000b			;100000001(blue)							

mov al,176


	mov di,2602
complete: 
	mov word [es:di], ax
	;call INFINITE3
	add di,2 
 	cmp di, 2684  
	jne complete

mov ah,01000100b			;01100000b				;01110000b
	mov di,2604
complete3: 
	mov word [es:di], ax
	;call INFINITE3
	add di,8 
 	cmp di, 2684  
	jne complete3

	pop di
	pop ax
	pop es

	ret 



;--------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------		BLUE LINE################

aboveLine:

	push es 
 	push ax 
 	push di


	mov ax, 0xb800 
 	mov es, ax  

mov ax,0
mov ah,00000000b			;01100000b			;100000001(blue)		;01010000b (pink)							

mov al,176


	mov di,1322
complete1: 
	mov word [es:di], ax
	;call INFINITE3
	add di,2 
 	cmp di, 1404  
	jne complete1

mov ah,01000100b				;01110000b
	mov di,1324
complete2: 
	mov word [es:di], ax
	;call INFINITE3
	add di,8 
 	cmp di, 1404  
	jne complete2

	pop di
	pop ax
	pop es

	ret 



;--------------------------------------------------------------------------------------------------

;##############################################################################################################
;				END OF THE THIRD SCREEN  CODE!!!
;##############################################################################################################




























;======================================================================
; 		play end screen
;======================================================================

playEndScreen:
	pusha

	call clearScreen

	;call printOutline

	call aboveLine
	call bottomLine





	mov ax,1830	;starting offset (bp+8)
	push ax
	mov ax, gameOver
 	push ax 
 	push word [length03] 
 	call printstr1



	mov ah,0
	int 16h


	popa
	ret

;======================================================================
; 		play end screen ended
;======================================================================









;===================================================================================================================
;				FIRST SCREEN CODE  ENDED
;===================================================================================================================




;===================================================================
;			PRINT STRING1
;===================================================================

;_______
printstr1: 
;_______

	push bp 
 	mov bp, sp 
	push es 
 	push ax 
 	push cx 
 	push si 
 	push di 

 	mov ax, 0xb800 
 	mov es, ax 
 	mov di, [bp+8] 		;position
 	mov si, [bp+6]  		;string
 	mov cx, [bp+4] 		;length
 	mov ah,00000100b 			;0x07 

nextchars1:
 	mov al, [si] 
 	mov [es:di], ax  
 	add di, 2  
 	add si, 1 
	loop nextchars1 

 	pop di 
 	pop si 
 	pop cx 
 	pop ax 
 	pop es 
 	pop bp 	
	ret 6 



;===================================================================
;			PRINT STRING1 ENDED
;===================================================================




;===================================================================
;			PRINT STRING
;===================================================================

;_______
printstr: 
;_______

	push bp 
 	mov bp, sp 
	push es 
 	push ax 
 	push cx 
 	push si 
 	push di 

 	mov ax, 0xb800 
 	mov es, ax 
 	mov di, [bp+8] 		;position
 	mov si, [bp+6]  		;string
 	mov cx, [bp+4] 		;length
 	mov ah,00110001b 			;0x07 

nextchar:
 	mov al, [si] 
 	mov [es:di], ax  
 	add di, 2  
 	add si, 1 
	loop nextchar  

 	pop di 
 	pop si 
 	pop cx 
 	pop ax 
 	pop es 
 	pop bp 	
	ret 6 



;===================================================================
;			PRINT STRING ENDED
;===================================================================





;===================================================================
;			CLEAR SCREEN
;===================================================================
clearScreen:

	push es 
 	push ax 
 	push di

	mov ax, 0xb800 
 	mov es, ax ; 
 	mov di, 0 

mov ax,0
mov ah,00000000b;
mov al,0h

nextloc: 
	mov word [es:di],ax		;0x0720 
 	add di, 2 
 	cmp di, 4000  
	jne nextloc  
 

	pop di
	pop ax
	pop es

	ret 

;===================================================================
;			CLEAR SCREEN ENDED
;===================================================================




;===================================================================
;			PRINT EACH BOX
;===================================================================
printEachBox:

	push bp
	mov bp,sp
	


mov ax,0xb800
mov es,ax

mov cx,5
mov di,word[bp+4]			;starting position (top left)

mov ax,0
mov ah,byte[bp+7]			;color
mov al,0h

l1:
	mov [es:di],ax
	add di,2
	loop l1

mov cx,5
add di,150
l2:
	mov [es:di],ax
	add di,2
	loop l2


mov cx,5
add di,150
l3:
	mov [es:di],ax
	add di,2
	loop l3




	pop bp
	ret 4
;===================================================================
;			PRINT EACH BOX ENDED
;===================================================================






;===================================================================
;			PRINT BOXES
;===================================================================

printBoxes:
;---------------


mov ah,00110000b
mov al,0h
push ax
	mov ax,990
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,1630
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,2270
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,2910
	push ax
	call printEachBox
;____________________________________________
mov ah,00110000b
mov al,0h
push ax

	mov ax,1004
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,1644
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,2284
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,2924
	push ax
	call printEachBox
;____________________________________________

mov ah,00110000b
mov al,0h
push ax
	mov ax,1018
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,1658
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,2298
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,2938
	push ax
	call printEachBox
;____________________________________________

mov ah,00110000b
mov al,0h
push ax


	mov ax,1032
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax


	mov ax,1672
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax


	mov ax,2312
	push ax
	call printEachBox

mov ah,00110000b
mov al,0h
push ax

	mov ax,2952
	push ax
	call printEachBox



;-------------------------------------------------
	ret


;===================================================================
;			PRINT BOXES ENDED
;===================================================================




;===================================================================
;			NEXT TURN
;===================================================================

;-------------------------------------------------------------------------------------------
nextTurn:

	pusha

	mov ax,word[turn]
	cmp ax,1
	jne twoo

	mov word[turn],2
	jmp go


twoo:
	mov word[turn],1



go:

	popa
	ret
;---------------------------------------------------------------------


;===================================================================
;			NEXT TURN ENDED
;===================================================================



;===================================================================
;			INPUT
;===================================================================


Input:

	pusha

;-----------------------------------------------------------------------------------------
askForKeyPress:	


	mov ah,0
	int 16h
;----------------------------------------------------------------------------

	cmp ah,0x0B		;0
	jne ONE
	mov word[position],0
	jmp matched
;__________________________________________


ONE:
	cmp ah,0x02		;1
	jne TWO
	mov word[position],1
	jmp matched
;__________________________________________
TWO:
	cmp ah,0x03		;2
	jne THREE
	mov word[position],2
	jmp matched
;__________________________________________
THREE:
	cmp ah,0x04		;3
	jne FOUR
	mov word[position],3
	jmp matched
;__________________________________________
FOUR:
	cmp ah,0x05		;4
	jne FIVE
	mov word[position],4
	jmp matched
;__________________________________________

FIVE:
	cmp ah,0x06		;5
	jne SIX
	mov word[position],5
	jmp matched
;__________________________________________
SIX:
	cmp ah,0x07		;6
	jne SEVEN
	mov word[position],6
	jmp matched
;__________________________________________
SEVEN:
	cmp ah,0x08		;7
	jne EIGHT
	mov word[position],7
	jmp matched
;__________________________________________
EIGHT:
	cmp ah,0x09		;8
	jne NINE
	mov word[position],8
	jmp matched
;__________________________________________
NINE:
	cmp ah,0x0A		;9
	jne A
	mov word[position],9
	jmp matched
;__________________________________________


;__________________________________________
A:
	cmp ah,0x1E		;A
	jne B
	mov word[position],10
	jmp matched
;__________________________________________
B:
	cmp ah,0x30		;B
	jne C
	mov word[position],11
	jmp matched
;__________________________________________
C:
	cmp ah,0x2E		;C
	jne D
	mov word[position],12
	jmp matched
;__________________________________________
D:
	cmp ah,0x20		;D
	jne E
	mov word[position],13
	jmp matched
;__________________________________________
E:
	cmp ah,0x12		;E
	jne F
	mov word[position],14
	jmp matched
;__________________________________________
F:
	cmp ah,0x21		;F
	jne invalidKey
	mov word[position],15
	jmp matched
;__________________________________________




invalidKey:

	jmp askForKeyPress



matched:


	popa
	ret


;===================================================================
;			INPUT ENDED
;===================================================================





;===================================================================
;			REPETITION 
;===================================================================

Repetition:

	pusha


	cmp word[position],0
	jne one
	mov di,1154
	jmp checkBox
;___________________________
one:
	cmp word[position],1
	jne two
	mov di,1168
	jmp checkBox
;___________________________
two:
	cmp word[position],2
	jne three
	mov di,1182
	jmp checkBox
;___________________________
three:
	cmp word[position],3
	jne four
	mov di,1196
	jmp checkBox
;___________________________
four:
	cmp word[position],4
	jne five
	mov di,1794
	jmp checkBox
;___________________________
five:
	cmp word[position],5
	jne six
	mov di,1808
	jmp checkBox
;___________________________
six:
	cmp word[position],6
	jne seven
	mov di,1822
	jmp checkBox
;___________________________
seven:
	cmp word[position],7
	jne eight
	mov di,1836
	jmp checkBox
;___________________________
eight:
	cmp word[position],8
	jne nine
	mov di,2434
	jmp checkBox
;___________________________
nine:
	cmp word[position],9
	jne ten
	mov di,2448
	jmp checkBox
;___________________________
ten:
	cmp word[position],10
	jne eleven
	mov di,2462
	jmp checkBox
;___________________________
eleven:
	cmp word[position],11
	jne twelve
	mov di,2476
	jmp checkBox
;___________________________
twelve:
	cmp word[position],12
	jne thirteen
	mov di,3074
	jmp checkBox
;___________________________
thirteen:
	cmp word[position],13
	jne fourteen
	mov di,3088
	jmp checkBox
;___________________________
fourteen:
	cmp word[position],14
	jne fifteen
	mov di,3102
	jmp checkBox
;___________________________
fifteen:
	cmp word[position],15
	mov di,3116

;___________________________

	
;___________________________

	

checkBox:
	mov ax,0xb800
	mov es,ax

;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:di],bx		;1if one is placed there
	jne cb2
	mov word[repStatus],1	;it means box is already filled
	jmp BACK
	

cb2:
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	
	cmp word[es:di],bx		;2 if two is placed there
	jne  noRep
	mov word[repStatus],1	;it means box is already filled
	jmp BACK
	
noRep:
	mov word[repStatus],0	;it means box is not filled


BACK:
	mov word[place],di		;we have to place sign on this offset

	popa
	ret



;===================================================================
;			REPETITION ENDED
;===================================================================



;row1:  1154, 1168, 1182, 1196
;row2:  1794, 1808, 1822, 1836
;row3:   2434, 2448, 2462, 2476
;row4:   3074, 3088, 3102, 3116

;===================================================================
;			OUTPUT
;===================================================================

output:
	pusha
;___________________________

	mov di,word[place]		;"place" holds the offset of the valid output
	
	mov ax,0xb800
	mov es,ax
mov ah,00110000b				;01110000b

	cmp word[turn],1
	jne twooo
	mov al,"1"
	jmp fp

twooo:	

	mov al,"2"

fp:
	mov word[es:di],ax		;finally placing the value on screen


;___________________________

	popa
	ret


;===================================================================
;			OUTPUT ENDED
;===================================================================



;===================================================================
;			ROW#1 for "1"
;===================================================================
;row1:  1154, 1168, 1182, 1196
ROW1for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:1154],bx
	jne row1Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:1168],bx
	jne row1Fail1
	add word[count],1


	cmp word[es:1182],bx
	jne row1Fail1
	add word[count],1


	cmp word[es:1196],bx
	jne row1Fail1
	add word[count],1			;it means count is 4 now
	jmp row1Win1
	
	



row1Fail1:
	mov word[count],0			;set to default value
	jmp r1p1

row1Win1:
	mov word[Win],1			;by default it is zero
;______________________
r1p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#1 for "1"  ENDED
;===================================================================





;===================================================================
;			ROW#1 for "2"
;===================================================================
;row1:  1154, 1168, 1182, 1196
ROW1for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:1154],bx
	jne row1Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:1168],bx
	jne row1Fail2
	add word[count],1


	cmp word[es:1182],bx
	jne row1Fail2
	add word[count],1


	cmp word[es:1196],bx
	jne row1Fail2
	add word[count],1			;it means count is 4 now
	jmp row1Win2
	
	



row1Fail2:
	mov word[count],0			;set to default value
	jmp r1p2

row1Win2:
	mov word[Win],1			;by default it is zero
;______________________
r1p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#1 for "2"  ENDED
;===================================================================





;===================================================================
;			ROW#2 for "1"
;===================================================================
;row2:  1794, 1808, 1822, 1836
ROW2for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:1794],bx
	jne row2Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:1808],bx
	jne row2Fail1
	add word[count],1


	cmp word[es:1822],bx
	jne row2Fail1
	add word[count],1


	cmp word[es:1836],bx
	jne row2Fail1
	add word[count],1			;it means count is 4 now
	jmp row2Win1
	
	



row2Fail1:
	mov word[count],0			;set to default value
	jmp r2p1

row2Win1:
	mov word[Win],1			;by default it is zero
;______________________
r2p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#2 for "1"  ENDED
;===================================================================



;===================================================================
;			ROW#2 for "2"
;===================================================================
;row2:  1794, 1808, 1822, 1836
ROW2for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:1794],bx
	jne row2Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:1808],bx
	jne row2Fail2
	add word[count],1


	cmp word[es:1822],bx
	jne row2Fail2
	add word[count],1


	cmp word[es:1836],bx
	jne row2Fail2
	add word[count],1			;it means count is 4 now
	jmp row2Win2
	
	



row2Fail2:
	mov word[count],0			;set to default value
	jmp r2p2

row2Win2:
	mov word[Win],1			;by default it is zero
;______________________
r2p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#2 for "2"  ENDED
;===================================================================





;===================================================================
;			ROW#3 for "1"
;===================================================================
;row3:   2434, 2448, 2462, 2476
ROW3for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:2434],bx
	jne row3Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:2448],bx
	jne row3Fail1
	add word[count],1


	cmp word[es:2462],bx
	jne row3Fail1
	add word[count],1


	cmp word[es:2476],bx
	jne row3Fail1
	add word[count],1			;it means count is 4 now
	jmp row3Win1
	
	



row3Fail1:
	mov word[count],0			;set to default value
	jmp r3p1

row3Win1:
	mov word[Win],1			;by default it is zero
;______________________
r3p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#3 for "1"  ENDED
;===================================================================





;===================================================================
;			ROW#3 for "2"
;===================================================================
;row3:   2434, 2448, 2462, 2476
ROW3for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:2434],bx
	jne row3Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:2448],bx
	jne row3Fail2
	add word[count],1


	cmp word[es:2462],bx
	jne row3Fail2
	add word[count],1


	cmp word[es:2476],bx
	jne row3Fail2
	add word[count],1			;it means count is 4 now
	jmp row3Win2
	
	



row3Fail2:
	mov word[count],0			;set to default value
	jmp r3p2

row3Win2:
	mov word[Win],1			;by default it is zero
;______________________
r3p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#3 for "2"  ENDED
;===================================================================







;===================================================================
;			ROW#4 for "1"
;===================================================================
;row4:   3074, 3088, 3102, 3116
ROW4for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:3074],bx
	jne row4Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:3088],bx
	jne row4Fail1
	add word[count],1


	cmp word[es:3102],bx
	jne row4Fail1
	add word[count],1


	cmp word[es:3116],bx
	jne row4Fail1
	add word[count],1			;it means count is 4 now
	jmp row4Win1
	
	



row4Fail1:
	mov word[count],0			;set to default value
	jmp r4p1

row4Win1:
	mov word[Win],1			;by default it is zero
;______________________
r4p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#4 for "1"  ENDED
;===================================================================



;===================================================================
;			ROW#4 for "2"
;===================================================================
;row4:   3074, 3088, 3102, 3116
ROW4for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:3074],bx
	jne row4Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:3088],bx
	jne row4Fail2
	add word[count],1


	cmp word[es:3102],bx
	jne row4Fail2
	add word[count],1


	cmp word[es:3116],bx
	jne row4Fail2
	add word[count],1			;it means count is 4 now
	jmp row4Win2
	
	



row4Fail2:
	mov word[count],0			;set to default value
	jmp r4p2

row4Win2:
	mov word[Win],1			;by default it is zero
;______________________
r4p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			ROW#4 for "2"  ENDED
;===================================================================



;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;			ROW WISE WINNING CONDITIONS DONE
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


;===================================================================
;			COL#1 for "1"
;===================================================================
;col1:  1154, 1794, 2434, 3074
COL1for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:1154],bx
	jne col1Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:1794],bx
	jne col1Fail1
	add word[count],1


	cmp word[es:2434],bx
	jne col1Fail1
	add word[count],1


	cmp word[es:3074],bx
	jne col1Fail1
	add word[count],1			;it means count is 4 now
	jmp col1Win1
	
	



col1Fail1:
	mov word[count],0			;set to default value
	jmp c1p1

col1Win1:
	mov word[Win],1			;by default it is zero
;______________________
c1p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#1 for "1"  ENDED
;===================================================================




;===================================================================
;			COL#1 for "2"
;===================================================================
;col1:  1154, 1794, 2434, 3074
COL1for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:1154],bx
	jne col1Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:1794],bx
	jne col1Fail2
	add word[count],1


	cmp word[es:2434],bx
	jne col1Fail2
	add word[count],1


	cmp word[es:3074],bx
	jne col1Fail2
	add word[count],1			;it means count is 4 now
	jmp col1Win2
	
	



col1Fail2:
	mov word[count],0			;set to default value
	jmp c1p2

col1Win2:
	mov word[Win],1			;by default it is zero
;______________________
c1p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#1 for "2"  ENDED
;===================================================================






;===================================================================
;			COL#2 for "1"
;===================================================================
;col2:  1168, 1808, 2448, 3088
COL2for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:1168],bx
	jne col2Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:1808],bx
	jne col2Fail1
	add word[count],1


	cmp word[es:2448],bx
	jne col2Fail1
	add word[count],1


	cmp word[es:3088],bx
	jne col2Fail1
	add word[count],1			;it means count is 4 now
	jmp col2Win1
	
	



col2Fail1:
	mov word[count],0			;set to default value
	jmp c2p1

col2Win1:
	mov word[Win],1			;by default it is zero
;______________________
c2p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#2 for "1"  ENDED
;===================================================================






;===================================================================
;			COL#2 for "2"
;===================================================================
;col2:  1168, 1808, 2448, 3088
COL2for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:1168],bx
	jne col2Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:1808],bx
	jne col2Fail2
	add word[count],1


	cmp word[es:2448],bx
	jne col2Fail2
	add word[count],1


	cmp word[es:3088],bx
	jne col2Fail2
	add word[count],1			;it means count is 4 now
	jmp col2Win2
	
	



col2Fail2:
	mov word[count],0			;set to default value
	jmp c2p1

col2Win2:
	mov word[Win],1			;by default it is zero
;______________________
c2p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#2 for "2"  ENDED
;===================================================================






;===================================================================
;			COL#3 for "1"
;===================================================================
;col3:   1182, 1822, 2462, 3102
COL3for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:1182],bx
	jne col3Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:1822],bx
	jne col3Fail1
	add word[count],1


	cmp word[es:2462],bx
	jne col3Fail1
	add word[count],1


	cmp word[es:3102],bx
	jne col3Fail1
	add word[count],1			;it means count is 4 now
	jmp col3Win1
	
	



col3Fail1:
	mov word[count],0			;set to default value
	jmp c3p1

col3Win1:
	mov word[Win],1			;by default it is zero
;______________________
c3p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#3 for "1"  ENDED
;===================================================================




;===================================================================
;			COL#3 for "2"
;===================================================================
;col3:   1182, 1822, 2462, 3102
COL3for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:1182],bx
	jne col3Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:1822],bx
	jne col3Fail2
	add word[count],1


	cmp word[es:2462],bx
	jne col3Fail2
	add word[count],1


	cmp word[es:3102],bx
	jne col3Fail2
	add word[count],1			;it means count is 4 now
	jmp col3Win2
	
	



col3Fail2:
	mov word[count],0			;set to default value
	jmp c3p2

col3Win2:
	mov word[Win],1			;by default it is zero
;______________________
c3p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#3 for "2"  ENDED
;===================================================================




;===================================================================
;			COL#4 for "1"
;===================================================================
;col4:   1196, 1836, 2476, 3116
COL4for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:1196],bx
	jne col4Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:1836],bx
	jne col4Fail1
	add word[count],1


	cmp word[es:2476],bx
	jne col4Fail1
	add word[count],1


	cmp word[es:3116],bx
	jne col4Fail1
	add word[count],1			;it means count is 4 now
	jmp col4Win1
	
	



col4Fail1:
	mov word[count],0			;set to default value
	jmp c3p1

col4Win1:
	mov word[Win],1			;by default it is zero
;______________________
c4p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#4 for "1"  ENDED
;===================================================================






;===================================================================
;			COL#4 for "2"
;===================================================================
;col4:   1196, 1836, 2476, 3116
COL4for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:1196],bx
	jne col4Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:1836],bx
	jne col4Fail2
	add word[count],1


	cmp word[es:2476],bx
	jne col4Fail2
	add word[count],1


	cmp word[es:3116],bx
	jne col4Fail2
	add word[count],1			;it means count is 4 now
	jmp col4Win2
	
	



col4Fail2:
	mov word[count],0			;set to default value
	jmp c3p2

col4Win2:
	mov word[Win],1			;by default it is zero
;______________________
c4p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			COL#4 for "2"  ENDED
;===================================================================


;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;			COLUMN WISE WINNING CONDITIONS DONE
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++





;===================================================================
;			DIAGONAL#1 for "1"
;===================================================================
;diagonal1: 1154, 1808, 2462, 3116
DIAGONAL1for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:1154],bx
	jne dgn1Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:1808],bx
	jne dgn1Fail1
	add word[count],1


	cmp word[es:2462],bx
	jne dgn1Fail1
	add word[count],1


	cmp word[es:3116],bx
	jne dgn1Fail1
	add word[count],1			;it means count is 4 now
	jmp dgn1Win1
	
	



dgn1Fail1:
	mov word[count],0			;set to default value
	jmp d1p1

dgn1Win1:
	mov word[Win],1			;by default it is zero
;______________________
d1p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			DIAGONAL#1 for "1"  ENDED
;===================================================================


;===================================================================
;			DIAGONAL#1 for "2"
;===================================================================
;diagonal1: 1154, 1808, 2462, 3116
DIAGONAL1for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:1154],bx
	jne dgn1Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:1808],bx
	jne dgn1Fail2
	add word[count],1


	cmp word[es:2462],bx
	jne dgn1Fail2
	add word[count],1


	cmp word[es:3116],bx
	jne dgn1Fail2
	add word[count],1			;it means count is 4 now
	jmp dgn1Win2
	
	



dgn1Fail2:
	mov word[count],0			;set to default value
	jmp d1p2

dgn1Win2:
	mov word[Win],1			;by default it is zero
;______________________
d1p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			DIAGONAL#1 for "2"  ENDED
;===================================================================




;===================================================================
;			DIAGONAL#2 for "1"
;===================================================================
;diagonal2: 3074, 2448, 1822, 1196
DIAGONAL2for1:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"1"

;------------------------------------
	cmp word[es:3074],bx
	jne dgn2Fail1	
	mov word[count],1			;by default it is zero


	cmp word[es:2448],bx
	jne dgn2Fail1
	add word[count],1


	cmp word[es:1822],bx
	jne dgn2Fail1
	add word[count],1


	cmp word[es:1196],bx
	jne dgn2Fail1
	add word[count],1			;it means count is 4 now
	jmp dgn2Win1
	
	



dgn2Fail1:
	mov word[count],0			;set to default value
	jmp d2p1

dgn2Win1:
	mov word[Win],1			;by default it is zero
;______________________
d2p1:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			DIAGONAL#2 for "1"  ENDED
;===================================================================





;===================================================================
;			DIAGONAL#2 for "2"
;===================================================================
;diagonal2: 3074, 2448, 1822, 1196
DIAGONAL2for2:

	pusha
;_______________________
mov ax,0xb800
mov es,ax
;-------------------------------------
mov bx,0
mov bh,00110000b
mov bl,"2"

;------------------------------------
	cmp word[es:3074],bx
	jne dgn2Fail2	
	mov word[count],1			;by default it is zero


	cmp word[es:2448],bx
	jne dgn2Fail2
	add word[count],1


	cmp word[es:1822],bx
	jne dgn2Fail2
	add word[count],1


	cmp word[es:1196],bx
	jne dgn2Fail2
	add word[count],1			;it means count is 4 now
	jmp dgn2Win2
	
	



dgn2Fail2:
	mov word[count],0			;set to default value
	jmp d2p2

dgn2Win2:
	mov word[Win],1			;by default it is zero
;______________________
d2p2:
	mov word[count],0			;set to default value
	popa
	ret


;===================================================================
;			DIAGONAL#2 for "2"  ENDED
;===================================================================


;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;			DIAGONAL WISE WINNING CONDITIONS DONE
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




;==================================================================================
;			CHECK ALL WINNING CONDITIONS
;==================================================================================

checkAllWinningConditions:

	pusha
;___________________________

;*********************************************************
	call ROW1for1
	cmp word[Win],1
	je  checkWonR

	call ROW1for2
	cmp word[Win],1
	jz  checkWonR

	call ROW2for1
	cmp word[Win],1
	je  checkWonR

	call ROW2for2
	cmp word[Win],1
	je  checkWonR

	call ROW3for1
	cmp word[Win],1
	je  checkWonR

	call ROW3for2
	cmp word[Win],1
	je  checkWonR

	call ROW4for1
	cmp word[Win],1
	je  checkWonR

	call ROW4for2
	cmp word[Win],1
	je  checkWonR
;*********************************************************
	jmp colsCompare

checkWonR:
	jmp checkWon


colsCompare:
;*********************************************************
	call COL1for1
	cmp word[Win],1
	je  checkWon

	call COL1for2
	cmp word[Win],1
	je  checkWon

	call COL2for1
	cmp word[Win],1
	je  checkWon

	call COL2for2
	cmp word[Win],1
	je  checkWon

	call COL3for1
	cmp word[Win],1
	je  checkWon

	call COL3for2
	cmp word[Win],1
	je  checkWon

	call COL4for1
	cmp word[Win],1
	je  checkWon

	call COL4for2
	cmp word[Win],1
	je  checkWon
;*********************************************************


;*********************************************************
	call DIAGONAL1for1
	cmp word[Win],1
	je  checkWon

	call DIAGONAL1for2
	cmp word[Win],1
	je  checkWon

	call DIAGONAL2for1
	cmp word[Win],1
	je  checkWon

	call DIAGONAL2for2
	cmp word[Win],1
	je  checkWon
;*********************************************************

	

;____________________________
checkWon:
;____________________________
	popa
	ret


;==================================================================================
;			CHECK ALL WINNING CONDITIONS DONE
;==================================================================================




;===================================================================
;			START
;===================================================================

;---------------------------------------------------------------------


start:



	call playFirstScreen
	call clearScreen
	call printBoxes

	mov cx,16		;16 boxes

;________________________________________________
;________________________________________________
myLoop:

	call nextTurn

mL1:
	call Input
	call Repetition
	
	cmp word[repStatus],1
	je mL1

	call output

	call checkAllWinningConditions
	cmp word[Win],1
	je  end



	loop myLoop
;_________________________________________________
;_________________________________________________


end:
	cmp word[Win],0
	je matchDraw
	

	cmp word[turn],1
	je playerOneWon

	jmp playerTwoWon



playerOneWon:	
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;		PLAYER ONE HAS WON
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	mov ax,180	;starting offset (bp+8)
	push ax
	mov ax, player1 
 	push ax 
 	push word [lenp1] 
 	call printstr

	jmp terminate

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



playerTwoWon:
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;		PLAYER TWO HAS WON
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	mov ax,180	;starting offset (bp+8)
	push ax
	mov ax, player2 
 	push ax 
 	push word [lenp2] 
 	call printstr

	jmp terminate

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


matchDraw:
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;			MATCH DRAWN
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

	mov ax,180	;starting offset (bp+8)
	push ax
	mov ax, draw 
 	push ax 
 	push word [lenD] 
 	call printstr

;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



terminate:

		mov ah,0
		int 16h

		call playEndScreen
		call clearScreen

		mov ah,0
		int 16h
;==============================
;	TERMINATION
;==============================
;---------------------------------------------------------------------
mov ax,0x4c00
int 21h
