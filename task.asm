/*
	IN, OUT, 
	MOV, RM_MOV, MR_MOV, RR_MOV,	
	JB, JMP, JA, JL
	INC, DEC, CMP
*/

START:	
	MOV R0,00H		//数组指针

/*输入数据*/
DATA_INPUT:
	IN R1			//输入数据到 R1(在这里 R1 作临时存储变量)
	RM_MOV R1,[R0]	//将 R1 的值传入 R0指针 指向的内存单元	
	INC R0			//R0指针++
	MOV R2,0AH
	CMP R0,R2	
	JB DATA_INPUT		//如果R0还没到0AH,继续循环输入

/*插入排序*/
SORT:
	MOV R0,1 	 		//R0看做 i

/*外层循环*/
OUT_LOOP:
	MR_MOV [R0],R1 		//R1看作TEMP,存储arr[i]

/*进入内层循环*/
INNER:
	RR_MOV R0,R2		//R2看作j 执行j = i

/*内层循环主体*/
INNER_LOOP:
	DEC R2				//执行j=j-1操作 此时R2是j-1 注意R2的值的变化 0-FFH
	MOV R3,00H
	CMP R2,R3			//判断j-1 >= 0 ？
	JL OUT_LOOP_NEXT	//若j-1 < 0 退出内层循环 执行有符号数的跳转操作
	
	MR_MOV [R2],R3		//R3 临时存储 arr[j-1]
	CMP R1,R3			//执行 arr[j]-arr[j-1] 
	JB OUT_LOOP_NEXT	//arr[j] < arr[j-1] ,退出内层循环

	INC R2			//R2 恢复成 j
	RM_MOV R3,[R2]	//执行 arr[j] = arr[j-1]
	DEC R2			//执行内层循环中的j--
	JMP INNER_LOOP	

/*外层循环收尾*/
OUT_LOOP_NEXT:		
	INC R2			//因为在内层循环跳转前将R2赋值为j-1,所以先恢复R2=j
	RM_MOV R1,[R2]	//这里执行 arr[j] = temp
	INC R0			//这里执行 i++ 操作
	
	MOV R3,0AH
	CMP R0, R3		//执行i - arr.length
	JB OUT_LOOP		//i < arr.length 继续执行外层循环

/*打印输出*/
PRINT:
	MOV R0,00H		//R0指针

PRINT_LOOP:
	MR_MOV [R0],R1	//将指针所指向内存单元的内容赋值到R1中
	OUT R1			//输出R1的内容
	INC R0			//指针指向下一个内存单元
	
	MOV R3,0AH
	CMP R0,R3		
	JB PRINT_LOOP

	JMP PRINT			//循环输出

