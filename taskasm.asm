assume cs:code,ds:data

data segment
    db 10 dup(0)
data ends

;R0->si
;R1->al
;R2->di
;R3->cl

code segment 
start:
    mov ax,data
    mov ds,ax
      
    mov si,00h  ;数组指针 
    
data_input:
    mov ah,1
    int 21h 
    
    sub al,30h;字符转为数字
    mov [si],al
    inc si
    mov ax,0ah
    cmp si,ax
    jb data_input
    
sort:
    mov si,1    ;将si看作是i
    
out_loop:
    mov  al,byte ptr ds:[si] ;al存arr[i] ax作temp
        
inner:
	mov di, si  ;di看作j,执行j=i
    
inner_loop:
    dec di      ;j=j-1
    mov cx,0    ;cx看作R3
    cmp di,cx   ;j-1 >= 0    j=(0-1)->FFFF
    jl out_loop_next  ;如果j-1<0就退出内层循环  
    
    mov cl,byte ptr ds:[di]  ;cx存arr[j-1]
    cmp al,cl      ;arr[j]-arr[j-1]       
    jb out_loop_next   ;如果arr[j]小于arr[j-1] 就跳出循环 
    
    inc di           ;di恢复j
    mov byte ptr ds:[di],cl   ;执行arr[j]=arr[j-1]
    dec di           ;j--
    jmp inner_loop
    
out_loop_next:
    inc di
    mov byte ptr ds:[di],al   ;arr[j] = temp
    inc si           ;i++
    
    mov cx,0ah
    cmp si,cx
    jb out_loop
    
    mov ax,4c00h
    int 21h
code ends
end start