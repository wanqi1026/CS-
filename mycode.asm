assume cs:code,ds:data

data segment
arr db 10 dup(0)
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    
    mov bx,0        ;数组指针
    mov cx,0ah      ;循环次数
    
data_input:
    mov ah,1
    int 21h 
    
    sub al,30h;字符转为数字
    mov [bx],al
    inc bx    
    loop data_input ;注意loop指令时先执行 cx--,再判断cx == 0
    
InsertionSort:
    mov cx,0ah 
    mov ax,1 ; ax看做是i变量
out_loop:    
    mov si,ax
    mov dl,[si]  ;dl 作 temp = arr[i]
    jmp inner  
    
out_loop_next: 
    inc bx   
    mov [bx],dl
    mov ch,0     
    inc ax 
    loop out_loop     
    
    jmp next    ;循环结束
    
inner:
    mov bx,ax    ;将bx看作 j,此刻 j = i 
    
inner_loop:
    dec bx       ;此刻bx = j - 1
    cmp bx,0
    jl out_loop_next        ;有符号数的跳转 j-1 < 0
    
    mov ch,[bx]  ;ch = arr[j-1]
    cmp dl,ch    ;temp - arr[j-1]
    jna out_loop_next   ;temp arr[j] 不大于 arr[j-1]
    
    inc bx       ;bx恢复成j
    mov [bx],ch
    dec bx
    jmp inner_loop  
    
next:
    mov ax,4c00h
    int 21h
    
code ends
end start