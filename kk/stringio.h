/*
本文实现了一个C库字符串的子集功能，主要是为了方便我们的OS kernel的编码
*/
#include <stdint.h>
extern void printInPos(char* msg,uint16_t len,uint8_t row,uint8_t col);	//为了将来可以在光标处打印内容
extern void putchar(char c);	//输出一个字符
extern char getch();	//

//char tempc

//字符串长度
uint16_t strlen(char *str){
	int count = 0;
	while(str[count++] !='\0');
	return count -1;
}

//比较字符串
uint8_t strcmp(char* str1,char* str2){
	int i=0;
	while(1){
		if(str1[i] =='\0' || str2[i] =='\0'){
			break;			
		}
		if(str1[i] != str2[i])
			break;
		++i;
		
	}
	return str1[i]-str2[i];
	
}

//在光标处显示字符串
void print(char* str){
	for(int i=0,len=strlen(str);i<len;i++){
		putchar(str[i]);
	}	
}

//读取字符串到缓冲区
void readToBuf(char * buffer, uint16_t maxlen){
	int i = 0;
	while(1){
		char tempc = getch();
		if(!(tempc == 0xD || tempc == '\b' || tempc >=32 && tempc <=127)){
			continue;//如果非法字符，直接忽略
		}
		if(i>0 && i<maxlen -1){	//buffer中仍然有字符，那么我们继续读
			if(tempc == 0x0D){
				break;//按下回车，停止读取				
			}
			else if(tempc == '\b'){
				putchar('\b');
				putchar(' ');
				putchar('\b');
				--i;
			}else{
				putchar(tempc);//回显给用户
				buffer[i] = tempc;
				i++;
			}
			
		}else if( i>=maxlen -1){	//达到最大值
				if(tempc == '\b'){
					putchar('\b');
					putchar(' ');
					putchar('\b');
					--i;
				}else if(tempc == 0x0D){
					break;//恰好是回车，那么我们也停止
				}
			
		}else if(i<=0){
				if(tempc == 0x0D){
					break;
				}
				else if( tempc != '\b'){
					putchar(tempc);//回显
					buffer[i] = tempc;
					i++;
				}
		}




	}
	putchar('\r');putchar('\n');
	buffer[i] = '\0';
}

//取得字符串中的第一个单词
void getFirstWord(char* str,char* buf){
		int i= 0;
		while(str[i] && str[i] != ' '){
			buf[i] = str[i];
			i++;
		}
		buf[i] = '\0';	
}
