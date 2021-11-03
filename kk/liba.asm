BITS 16
[global printInPos]	;为了将来可以在光标处打印内容
[global putchar]	;输出一个字符
[global getch]		;获得键盘的输入
[global clearScreen]
[global powerOFF]
[global systime]
[global drawPic]

drawPic:
	pusha
	popa
         mov ah,0fh
         int 10h
         mov ah,0 
         mov al,3
         int 10h
         mov cx,1                 ;字符数量
         mov ah,2
         mov dh,5                 ;5行开始
         mov dl,25                ;25列开始
         int 10h
;*****光标向下动********
line:    mov ah,2
         int 10h
         mov al,15
         mov ah,9
         mov bl,0e0h            ;字符黄色
         int 10h
         inc dh                 ;行增加 
         cmp dh,20               ;20行
         jne line 
         jmp line1
;****光标向右动*****
line1:   mov ah,2
         int 10h
         mov al,15
         mov ah,9
         mov bl,0e0h                ;字符为黄色
         int 10h
         inc dl                  ;列增加
         cmp dl,55                 ;55列
         jne line1
         jmp line2
;*****光标向上动*********
line2:   mov ah,2
         int 10h  
         mov al,15
         mov ah,9
         mov bl,0e0h               ;字符为黄色
         int 10h
         dec dh
         cmp dh,5
         jne line2
         jmp line3  
;***光标向左动***
line3:   mov ah,2
         int 10h
         mov al,15
         mov ah,9
         mov bl,0e0h ;字符为黄色
         int 10h
         dec dl 
         cmp dl,25
         jne line3
l00:     mov ah,7
         mov al,14
         mov bh,20h  ;绿色
         mov ch,6 
         mov cl,26
         mov dh,19
         mov dl,54
         int 10h
;*****时间控制*****
l01:    mov ah,0
        int 1ah
        cmp dl,10
        jnz l01
l1:     mov ah,6
        mov al,14
        mov bh,0f0h ;白色
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l2:     mov ah,0
        int 1ah
        cmp dl,15
        jnz l2
l3:     mov ah,7
        mov al,14
        mov bh,40h ;红色
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l4:     mov ah,0
        int 1ah
        cmp dl,30
        jnz l4
l5:     mov ah,6
        mov al,14
        mov bh,0d0h ;品红
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l004:   mov ah,0
        int 1ah
        cmp dl,10
        jnz l004
l005:   mov ah,7
        mov al,14
        mov bh,30h ;青
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
l006:   mov ah,0
        int 1ah
        cmp dl,10
        jnz l006
l02:    mov ah,7
        mov al,14
        mov bh,20h ;绿色
        mov ch,6
        mov cl,26
        mov dh,19
        mov dl,54
        int 10h
;****时间控制****

  mov ah,2
       mov dh,23
       mov dl,0
       int 10h
      
	retf
systime:
	pusha
	mov al,4	;hour
	out 70h,al
	in  al,71h
	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b
	add ah,30h
	add al,30h

	mov dx,ax
	mov al,dh
	mov bh,0
	mov ah,0Eh
	int 10h
	
	mov al,dl
	mov bh,0
	mov ah,0Eh
	int 10h
	
	mov al, ':'
	mov bh,0
	mov ah,0Eh
	int 10h
	
	;-------minute--------

	mov al,2	;minute
	out 70h,al
	in  al,71h
	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b
	add ah,30h
	add al,30h

	mov dx,ax
	mov al,dh
	mov bh,0
	mov ah,0Eh
	int 10h
	
	mov al,dl
	mov bh,0
	mov ah,0Eh
	int 10h
	
	mov al, ':'
	mov ah,0Eh
	int 10h
;-------------------seconde
	
	mov al,0	;minute
	out 70h,al
	in  al,71h
	mov ah,al
	mov cl,4
	shr ah,cl
	and al,00001111b
	add ah,30h
	add al,30h

	mov dx,ax
	mov al,dh
	mov bh,0
	mov ah,0Eh
	int 10h
	
	mov al,dl
	mov bh,0
	mov ah,0Eh
	int 10h
	
	mov al,0Ah
	mov bh,0
	mov ah,0Eh
	int 10h
	
	mov al,0Dh
	mov bh,0
	mov ah,0Eh
	int 10h
	
	popa
	retf
powerOFF:
	mov ax,5307h
	mov bx,0001h
	mov cx,0003h
	int 15h

clearScreen:
	push ax
	mov ax,0003h
	int 10h
	pop ax
	retf
getch:				;这是一个函数，我们从键盘中读取一个字符到tempc的变量，使用的是16号中断
	mov ah,0	;功能号
	int 16h
	mov ah,0	;读取字符，al存的是读到字符，同时置ah为0，为返回值作准备
	retf
	
putchar:			;在光标处打印一个字符到屏幕，用的bios的10号中断
	pusha
	mov bp,sp
	add bp,16+4		;参数地址
	mov al,[bp]		;al=要打印的字符
	mov bh,0		;bh=页码
	mov ah,0Eh		;0Eh是中断
	int 10h
	popa
	retf
	
printInPos:			;在指定的位置显示字符串
	pusha
	mov si, sp		;在我们的printInPos中，我们用到了bp，所以我们用si来为参数寻址
	add si,16+4		;首个参数的地址
	mov ax, cs
	mov ds, ax
	mov bp,[si]		;BP指向了当前串的偏移地址
	mov ax, ds		;ES：BP=串地址
	mov es,	ax		;置ES= DS
	mov cx,[si+4]	;cx，=串长
	mov ax,1301h	;AH=13(功能号)，AL=01h表示字符串显示完毕之后，光标应当置于串的末尾
	mov bx,0007h	;bh=0,表示0号页，bl=07，表示黑底白字
	mov dh, [si+8]	;行号=0
	mov dl,[si+12]	;列号=0
	int 10h			;使用BIOS的10h，显示一行字符
	popa
	retf
