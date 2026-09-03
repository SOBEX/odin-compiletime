package odin_compiletime_scratch

import comp ".."

Assembly::struct(
   asm_string:string,
   constraints_string:string
){}

_Assembler::struct(count:u8,expression:string,registers:string,stack:string,asm_string:string,constraints_string:string,clobbers:bool){
   v:/*Assembly*/(
      (
         Assembly(asm_string+"mov $0, "+registers[3*stack[0]:3*(stack[0]+1)],constraints_string when !clobbers else constraints_string+",~{cc}")
      )when len(expression)==0 else(
         comp.v(_Assembler(count+1,expression[1:],registers,comp.RUNES[count]+stack[2:],asm_string+"mov "+registers[3*count:3*(count+1)]+", "+registers[3*stack[0]:3*(stack[0]+1)]+"\nimul "+registers[3*count:3*(count+1)]+", "+registers[3*stack[1]:3*(stack[1]+1)]+"\n",constraints_string+",~{"+registers[3*count:3*(count+1)]+"}",true),"v")
      )when expression[0]=='*' else(
         comp.v(_Assembler(count+1,expression[1:],registers,comp.RUNES[count]+stack[2:],asm_string+"lea "+registers[3*count:3*(count+1)]+", ["+registers[3*stack[0]:3*(stack[0]+1)]+" + "+registers[3*stack[1]:3*(stack[1]+1)]+"]\n",constraints_string+",~{"+registers[3*count:3*(count+1)]+"}",clobbers),"v")
      )when expression[0]=='+' else(
         comp.v(_Assembler(count+1,expression[1:],registers,comp.RUNES[count]+stack[2:],asm_string+"mov "+registers[3*count:3*(count+1)]+", "+registers[3*stack[0]:3*(stack[0]+1)]+"\nsub "+registers[3*count:3*(count+1)]+", "+registers[3*stack[1]:3*(stack[1]+1)]+"\n",constraints_string+",~{"+registers[3*count:3*(count+1)]+"}",clobbers),"v")
      )when expression[0]=='-' else(
         comp.v(_Assembler(count,expression[1:],registers,comp.RUNES[expression[0]-'0']+stack,asm_string,constraints_string,clobbers),"v")
      )when expression[0]=='0'||expression[0]=='1'||expression[0]=='2'||expression[0]=='3'||expression[0]=='4'||expression[0]=='5'||expression[0]=='6'||expression[0]=='7'||expression[0]=='8'||expression[0]=='9' else(
         comp.v(_Assembler(count,expression[1:],registers,stack,asm_string,constraints_string,clobbers),"v")
      )
   )
}

Assembler_Scratch::"r8 r9 r10r11r12r13r14r15"

Assembler::struct(count:uint,expression:string){
   v:/*Assembly*/(
      (
         comp.v(_Assembler(1,expression,"$0 "+Assembler_Scratch,"","","=r",false),"v")
      )when count==0 else(
         comp.v(_Assembler(2,expression,"$0 $1 "+Assembler_Scratch,"","","=r,r",false),"v")
      )when count==1 else(
         comp.v(_Assembler(3,expression,"$0 $1 $2 "+Assembler_Scratch,"","","=r,r,r",false),"v")
      )when count==2 else(
         comp.v(_Assembler(4,expression,"$0 $1 $2 $3 "+Assembler_Scratch,"","","=r,r,r,r",false),"v")
      )when count==3 else(
         comp.v(_Assembler(5,expression,"$0 $1 $2 $3 $4 "+Assembler_Scratch,"","","=r,r,r,r,r",false),"v")
      )when count==4 else(
         #panic("more than 4 inputs not yet supported, but feel free to add the single line you need here")
      )
   )
}
