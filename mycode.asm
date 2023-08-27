assume cs:code,ds:data

data segment
arr db 10 dup(0)
data ends

code segment
start:
    mov ax,data
    mov ds,ax
    
    mov bx,0        ;����ָ��
    mov cx,0ah      ;ѭ������
    
data_input:
    mov ah,1
    int 21h 
    
    sub al,30h;�ַ�תΪ����
    mov [bx],al
    inc bx    
    loop data_input ;ע��loopָ��ʱ��ִ�� cx--,���ж�cx == 0
    
InsertionSort:
    mov cx,0ah 
    mov ax,1 ; ax������i����
out_loop:    
    mov si,ax
    mov dl,[si]  ;dl �� temp = arr[i]
    jmp inner  
    
out_loop_next: 
    inc bx   
    mov [bx],dl
    mov ch,0     
    inc ax 
    loop out_loop     
    
    jmp next    ;ѭ������
    
inner:
    mov bx,ax    ;��bx���� j,�˿� j = i 
    
inner_loop:
    dec bx       ;�˿�bx = j - 1
    cmp bx,0
    jl out_loop_next        ;�з���������ת j-1 < 0
    
    mov ch,[bx]  ;ch = arr[j-1]
    cmp dl,ch    ;temp - arr[j-1]
    jna out_loop_next   ;temp arr[j] ������ arr[j-1]
    
    inc bx       ;bx�ָ���j
    mov [bx],ch
    dec bx
    jmp inner_loop  
    
next:
    mov ax,4c00h
    int 21h
    
code ends
end start