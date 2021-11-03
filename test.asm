;小动画
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
      