package odin_compiletime_brainfuck

PACKAGE::"odin_compiletime_brainfuck"

import comp "odin-compiletime"

import "core:fmt"
import "core:strings"

Backtrack::struct(brainfuck:string,ip:uint,depth:uint){
   v:/*comp.Uint*/(
      (
         (
            comp.Uint(ip+1)
         )when depth==1 else(
            comp.v(Backtrack(brainfuck,ip-1,depth-1),"v")
         )
      )when brainfuck[ip]=='[' else(
         comp.v(Backtrack(brainfuck,ip-1,depth+1),"v")
      )when brainfuck[ip]==']' else(
         comp.v(Backtrack(brainfuck,ip-1,depth),"v")
      )
   )
}

Brainfuck_State::struct(brainfuck:string,ip:uint,backtracking:uint,data:string,ptr:uint,finished:bool,steps:uint,result:string){}

BRAINFUCK_DEBUG::false

BRAINFUCK_ITERATIONS_NEEDED::4

Brainfuck_Core::struct(brainfuck:string,ip:uint,backtracking:uint,data:string,ptr:uint,finished:bool,steps:uint,result:string,iterations_left:uint){
   v:/*Brainfuck_State*/(
      (
         Brainfuck_State(brainfuck,ip,backtracking,data,ptr,true,steps,result)
      )when ip==len(brainfuck) else(
         Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,result)
      )when iterations_left<BRAINFUCK_ITERATIONS_NEEDED else(
         (
            (
               comp.v(Brainfuck_Core(brainfuck,ip+1,0,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
            )when backtracking==1 else(
               comp.v(Brainfuck_Core(brainfuck,ip-1,backtracking-1,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
            )
         )when brainfuck[ip]=='[' else(
            comp.v(Brainfuck_Core(brainfuck,ip-1,backtracking+1,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
         )when brainfuck[ip]==']' else(
            comp.v(Brainfuck_Core(brainfuck,ip-1,backtracking,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
         )
      )when backtracking>=1 else(
         comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data,ptr+1 when ptr!=len(data)-1 else 0,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]=='>' else(
         comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data,ptr-1 when ptr!=0 else len(data)-1,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]=='<' else(
         comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data[:ptr]+comp.RUNES[(i16(data[ptr])+1)%%256]+data[ptr+1:],ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]=='+' else(
         comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data[:ptr]+comp.RUNES[(i16(data[ptr])-1)%%256]+data[ptr+1:],ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]=='-' else(
         /*TODO , idc*/comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]==',' else(
         comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data,ptr,finished,steps+1,(result+comp.RUNES[data[ptr]]) when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]=='.' else(
         /*ignore [*/comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]=='[' else(
         /*TODO backtrack multiple at once?*/comp.v(Brainfuck_Core(brainfuck,ip-1 when data[ptr]!=0 else ip+1,1 when data[ptr]!=0 else backtracking,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )when brainfuck[ip]==']' else(
         /*ignore anything else*/comp.v(Brainfuck_Core(brainfuck,ip+1,backtracking,data,ptr,finished,steps+1,result when !BRAINFUCK_DEBUG else (result+(comp.n(Brainfuck_State(brainfuck,ip,backtracking,data,ptr,finished,steps,""))+"\n")),iterations_left-1),"v")
      )
   )
}

Brainfuck_1::struct(s:/*Brainfuck_State*/typeid,iterations_left:uint){
   v:/*Brainfuck_State*/(
      (
         s
      )when iterations_left<BRAINFUCK_ITERATIONS_NEEDED+1 else(
         s
      )when s.finished else(
         comp.v(Brainfuck_1(comp.v(Brainfuck_Core(s.brainfuck,s.ip,s.backtracking,s.data,s.ptr,s.finished,s.steps,s.result,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Brainfuck_2::struct(s:/*Brainfuck_State*/typeid,iterations_left:uint){
   v:/*Brainfuck_State*/(
      (
         s
      )when iterations_left<BRAINFUCK_ITERATIONS_NEEDED+2 else(
         s
      )when s.finished else(
         comp.v(Brainfuck_2(comp.v(Brainfuck_1(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Brainfuck_3::struct(s:/*Brainfuck_State*/typeid,iterations_left:uint){
   v:/*Brainfuck_State*/(
      (
         s
      )when iterations_left<BRAINFUCK_ITERATIONS_NEEDED+3 else(
         s
      )when s.finished else(
         comp.v(Brainfuck_3(comp.v(Brainfuck_2(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Brainfuck_4::struct(s:/*Brainfuck_State*/typeid,iterations_left:uint){
   v:/*Brainfuck_State*/(
      (
         s
      )when iterations_left<BRAINFUCK_ITERATIONS_NEEDED+4 else(
         s
      )when s.finished else(
         comp.v(Brainfuck_4(comp.v(Brainfuck_3(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Brainfuck_5::struct(s:/*Brainfuck_State*/typeid,iterations_left:uint){
   v:/*Brainfuck_State*/(
      (
         s
      )when iterations_left<BRAINFUCK_ITERATIONS_NEEDED+5 else(
         s
      )when s.finished else(
         comp.v(Brainfuck_5(comp.v(Brainfuck_4(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

brainfuck::#force_inline proc($brainfuck:string,$depth:int)->(_result:string,_escaped:string,_steps:uint,_finished:bool){
   ITERATION_LIMIT::27
   INIT::Brainfuck_State(brainfuck,0,0,comp.v(comp.Buffer_Make(128),"v").v,0,false,0,"")
   when depth==0{
      result::comp.v(Brainfuck_Core(INIT,ITERATION_LIMIT),"v")
   }else when depth==1{
      result::comp.v(Brainfuck_1(INIT,ITERATION_LIMIT),"v")
   }else when depth==2{
      result::comp.v(Brainfuck_2(INIT,ITERATION_LIMIT),"v")
   }else when depth==3{
      result::comp.v(Brainfuck_3(INIT,ITERATION_LIMIT),"v")
   }else when depth==4{
      result::comp.v(Brainfuck_4(INIT,ITERATION_LIMIT),"v")
   }else when depth==5{
      result::comp.v(Brainfuck_5(INIT,ITERATION_LIMIT),"v")
   }else{
      #panic("Invalid depth")
   }
   escaped::"["+comp.v(comp.Buffer_Print(result.result),"v").v+"]"
   return result.result,escaped,result.steps,result.finished
}

compile_at_runtime::proc(brainfuck:string,name:string,short:=false)->(assembly:string,constraints:string,ok:bool){
   sb:=strings.builder_make()
   defer if !ok do strings.builder_destroy(&sb)
   loop_stack:=make([dynamic][ASSEMBLER_LABEL_WIDTH]u8)
   defer delete(loop_stack)
   label_counter:=0

   for c in transmute([]u8)brainfuck{
      switch c{
      case '>':
         if short{
            fmt.sbprintfln(&sb,"\tinc rdx")
            fmt.sbprintfln(&sb,"\tcmp rdx, $3")
            fmt.sbprintfln(&sb,"\tcmove rdx, $2")
         }else{
            fmt.sbprintfln(&sb,"\tadd rdx, 1")
            fmt.sbprintfln(&sb,"\tcmp rdx, $3")
            fmt.sbprintfln(&sb,"\tcmove rdx, $2")
         }
      case '<':
         if short{
            fmt.sbprintfln(&sb,"\tcmp rdx, $2")
            fmt.sbprintfln(&sb,"\tcmove rdx, $3")
            fmt.sbprintfln(&sb,"\tdec rdx")
         }else{
            fmt.sbprintfln(&sb,"\tcmp rdx, $2")
            fmt.sbprintfln(&sb,"\tcmove rdx, $3")
            fmt.sbprintfln(&sb,"\tsub rdx, 1")
         }
      case '+':
         if short{
            fmt.sbprintfln(&sb,"\tinc byte ptr [rdx]")
         }else{
            fmt.sbprintfln(&sb,"\tmovzx eax, byte ptr [rdx]")
            fmt.sbprintfln(&sb,"\tadd eax, 1")
            fmt.sbprintfln(&sb,"\tmov byte ptr [rdx], al")
         }
      case '-':
         if short{
            fmt.sbprintfln(&sb,"\tdec byte ptr [rdx]")
         }else{
            fmt.sbprintfln(&sb,"\tmovzx eax, byte ptr [rdx]")
            fmt.sbprintfln(&sb,"\tsub eax, 1")
            fmt.sbprintfln(&sb,"\tmov byte ptr [rdx], al")
         }
      case '.':
         if short{
            fmt.sbprintfln(&sb,"\tcmp rdi, $5")
            fmt.sbprintfln(&sb,"\tjae L_%s_oob",name)
            fmt.sbprintfln(&sb,"\tmov al, byte ptr [rdx]")
            fmt.sbprintfln(&sb,"\tmov byte ptr [rdi], al")
            fmt.sbprintfln(&sb,"\tinc rdi")
         }else{
            fmt.sbprintfln(&sb,"\tcmp rdi, $5")
            fmt.sbprintfln(&sb,"\tjae L_%s_oob",name)
            fmt.sbprintfln(&sb,"\tmovzx eax, byte ptr [rdx]")
            fmt.sbprintfln(&sb,"\tmov byte ptr [rdi], al")
            fmt.sbprintfln(&sb,"\tadd rdi, 1")
         }
      case ',':
         label:=label_counter
         label_counter+=1
         if short{
            fmt.sbprintfln(&sb,"\tcmp rsi, $7")
            fmt.sbprintfln(&sb,"\tjae L_%s_%d_eof",name,label)
            fmt.sbprintfln(&sb,"\tmov al, byte ptr [rsi]")
            fmt.sbprintfln(&sb,"\tinc rsi")
            fmt.sbprintfln(&sb,"\tjmp L_%s_%d_done",name,label)
            fmt.sbprintfln(&sb,"\tL_%s_%d_eof:",name,label)
            fmt.sbprintfln(&sb,"\tmov al 0")
            fmt.sbprintfln(&sb,"\tL_%s_%d_done:",name,label)
            fmt.sbprintfln(&sb,"\tmov byte ptr [rdx], al")
         }else{
            fmt.sbprintfln(&sb,"\tcmp rsi, $7")
            fmt.sbprintfln(&sb,"\tjae L_%s_%d_eof",name,label)
            fmt.sbprintfln(&sb,"\tmovzx eax, byte ptr [rsi]")
            fmt.sbprintfln(&sb,"\tadd rsi, 1")
            fmt.sbprintfln(&sb,"\tjmp L_%s_%d_done",name,label)
            fmt.sbprintfln(&sb,"\tL_%s_%d_eof:",name,label)
            fmt.sbprintfln(&sb,"\txor eax, eax")
            fmt.sbprintfln(&sb,"\tL_%s_%d_done:",name,label)
            fmt.sbprintfln(&sb,"\tmov byte ptr [rdx], al")
         }
      case '[':
         labeli:=label_counter
         label_counter+=1
         _label:[ASSEMBLER_LABEL_WIDTH+1]u8
         label:=fmt.bprintf(_label[:],"% *d",ASSEMBLER_LABEL_WIDTH,labeli)
         if len(label)!=ASSEMBLER_LABEL_WIDTH{
            return "","",false
         }
         for i in 0..<len(label){
            if _label[i]==' '{
               _label[i]='_'
            }
         }
         append(&loop_stack,_label.xyzw)
         if short{
            fmt.sbprintfln(&sb,"\tL_%s_%s_start:",name,label)
            fmt.sbprintfln(&sb,"\tcmp byte ptr [rdx], 0")
            fmt.sbprintfln(&sb,"\tje L_%s_%s_end",name,label)
         }else{
            fmt.sbprintfln(&sb,"\tjmp L_%s_%s_check",name,label)
            fmt.sbprintfln(&sb,"\tL_%s_%s_start:",name,label)
         }
      case ']':
         if len(loop_stack)==0{
            return "","",false
         }
         _label:=pop(&loop_stack)
         label:=string(_label[:])
         if short{
            fmt.sbprintfln(&sb,"\tjmp L_%s_%s_start",name,label)
            fmt.sbprintfln(&sb,"\tL_%s_%s_end:",name,label)
         }else{
            fmt.sbprintfln(&sb,"\tL_%s_%s_check:",name,label)
            fmt.sbprintfln(&sb,"\tcmp byte ptr [rdx], 0")
            fmt.sbprintfln(&sb,"\tjne L_%s_%s_start",name,label)
         }
      }
   }

   if len(loop_stack)!=0{
      return "","",false
   }

   if short{
      fmt.sbprintfln(&sb,"\tmov al, 0")
      fmt.sbprintfln(&sb,"\tjmp L_%s_exit", name)
      fmt.sbprintfln(&sb,"\tL_%s_oob:", name)
      fmt.sbprintfln(&sb,"\tmov al, 1")
      fmt.sbprintfln(&sb,"\tL_%s_exit:", name)
   }else{
      fmt.sbprintfln(&sb,"\txor eax, eax")
      fmt.sbprintfln(&sb,"\tjmp L_%s_exit", name)
      fmt.sbprintfln(&sb,"\tL_%s_oob:", name)
      fmt.sbprintfln(&sb,"\tmov eax, 1")
      fmt.sbprintfln(&sb,"\tL_%s_exit:", name)
   }

   return strings.to_string(sb),"={eax},{rdx},{r8},{r9},{rdi},{r10},{rsi},{r11},~{cc},~{memory}",true
}

Run::#type proc"contextless"(tape,output,input:[]u8)->(err:bool)

Assembler_State::struct(brainfuck:string,name:string,loop_stack:string,label_counter:uint,assembly:string,finished:bool){}

ASSEMBLER_LABEL_WIDTH::4

Assembler_0::struct(brainfuck:string,name:string,loop_stack:string,label_counter:uint,assembly:string,finished:bool,iterations_left:uint){
   v:/*Assembler_State*/(
      (
         Assembler_State(brainfuck,name,loop_stack,label_counter,assembly,finished)
      )when iterations_left<=0 else(
         Assembler_State(brainfuck,name,loop_stack,label_counter,assembly,finished)
      )when finished else(
         (
            #panic("loop_stack not empty, unbalanced square brackets")
         )when len(loop_stack)!=0 else(
            Assembler_State(brainfuck,name,loop_stack,label_counter,assembly+"\txor eax, eax\n\tjmp L_"+name+"_exit\n\tL_"+name+"_oob:\n\tmov eax, 1\n\tL_"+name+"_exit:\n",true)
         )
      )when len(brainfuck)==0 else(
         comp.v(Assembler_0(brainfuck[1:],name,loop_stack,label_counter,assembly+"\tadd rdx, 1\n\tcmp rdx, $3\n\tcmove rdx, $2\n",finished,iterations_left-1),"v")
      )when brainfuck[0]=='>' else(
         comp.v(Assembler_0(brainfuck[1:],name,loop_stack,label_counter,assembly+"\tcmp rdx, $2\n\tcmove rdx, $3\n\tsub rdx, 1\n",finished,iterations_left-1),"v")
      )when brainfuck[0]=='<' else(
         comp.v(Assembler_0(brainfuck[1:],name,loop_stack,label_counter,assembly+"\tmovzx eax, byte ptr [rdx]\n\tadd eax, 1\n\tmov byte ptr [rdx], al\n",finished,iterations_left-1),"v")
      )when brainfuck[0]=='+' else(
         comp.v(Assembler_0(brainfuck[1:],name,loop_stack,label_counter,assembly+"\tmovzx eax, byte ptr [rdx]\n\tsub eax, 1\n\tmov byte ptr [rdx], al\n",finished,iterations_left-1),"v")
      )when brainfuck[0]=='-' else(
         comp.v(Assembler_0(brainfuck[1:],name,loop_stack,label_counter,assembly+"\tcmp rdi, $5\n\tjae L_"+name+"_oob\n\tmovzx eax, byte ptr [rdx]\n\tmov byte ptr [rdi], al\n\tadd rdi, 1\n",finished,iterations_left-1),"v")
      )when brainfuck[0]=='.' else(
         comp.v(Assembler_0(brainfuck[1:],name,loop_stack,label_counter+1,assembly+"\tcmp rsi, $7\n\tjae L_"+name+"_"+comp.v(comp.Stringify_Uint(label_counter),"v").v+"_eof\n\tmovzx eax, byte ptr [rsi]\n\tadd rsi, 1\n\tjmp L_"+name+"_"+comp.v(comp.Stringify_Uint(label_counter),"v").v+"_done\n\tL_"+name+"_"+comp.v(comp.Stringify_Uint(label_counter),"v").v+"_eof:\n\txor eax, eax\n\tL_"+name+"_"+comp.v(comp.Stringify_Uint(label_counter),"v").v+"_done:\n\tmov byte ptr [rdx], al\n",finished,iterations_left-1),"v")
      )when brainfuck[0]==',' else(
         comp.v(Assembler_0(brainfuck[1:],name,comp.v(comp.Pad_Left(comp.v(comp.Stringify_Uint(label_counter),"v").v,"_",ASSEMBLER_LABEL_WIDTH),"v").v+loop_stack,label_counter+1,assembly+"\tjmp L_"+name+"_"+comp.v(comp.Pad_Left(comp.v(comp.Stringify_Uint(label_counter),"v").v,"_",ASSEMBLER_LABEL_WIDTH),"v").v+"_check\n\tL_"+name+"_"+comp.v(comp.Pad_Left(comp.v(comp.Stringify_Uint(label_counter),"v").v,"_",ASSEMBLER_LABEL_WIDTH),"v").v+"_start:\n",finished,iterations_left-1),"v")
      )when brainfuck[0]=='[' else(
         (
            #panic("loop_stack empty, unbalanced square brackets")
         )when len(loop_stack)<ASSEMBLER_LABEL_WIDTH else(
            comp.v(Assembler_0(brainfuck[1:],name,loop_stack[ASSEMBLER_LABEL_WIDTH:],label_counter,assembly+"\tL_"+name+"_"+loop_stack[:ASSEMBLER_LABEL_WIDTH]+"_check:\n\tcmp byte ptr [rdx], 0\n\tjne L_"+name+"_"+loop_stack[:ASSEMBLER_LABEL_WIDTH]+"_start\n",finished,iterations_left-1),"v")
         )
      )when brainfuck[0]==']' else(
         comp.v(Assembler_0(brainfuck[1:],name,loop_stack,label_counter,assembly,finished,iterations_left-1),"v")
      )
   )
}

Assembler_1::struct(s:/*Assembler_State*/typeid,iterations_left:uint){
   v:/*Assembler_State*/(
      (
         s
      )when iterations_left<=1 else(
         s
      )when s.finished else(
         comp.v(Assembler_1(comp.v(Assembler_0(s.brainfuck,s.name,s.loop_stack,s.label_counter,s.assembly,s.finished,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Assembler_2::struct(s:/*Assembler_State*/typeid,iterations_left:uint){
   v:/*Assembler_State*/(
      (
         s
      )when iterations_left<=1 else(
         s
      )when s.finished else(
         comp.v(Assembler_2(comp.v(Assembler_1(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Assembler_3::struct(s:/*Assembler_State*/typeid,iterations_left:uint){
   v:/*Assembler_State*/(
      (
         s
      )when iterations_left<=1 else(
         s
      )when s.finished else(
         comp.v(Assembler_3(comp.v(Assembler_2(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

compile::proc($brainfuck:string,$name:string)->Run{
   assembly::comp.v(Assembler_3(Assembler_State(brainfuck,name,"",0,"",false),22),"v")
   #assert(assembly.finished,"Brainfuck too long, try higher recursion evasion")
   //llvm says its illegal to write to inputs and moving them from `r` to registers also crashes with optimizations so we can just disable them since the asm isnt touched anyway
   @(optimization_mode="none")run:Run:proc"contextless"(tape,output,input:[]u8)->(err:bool){
      tape_begin:=raw_data(tape)
      tape_end:=tape_begin[len(tape):]
      /*rdx*/tape_current:=tape_begin
      output_begin:=raw_data(output)
      output_end:=output_begin[len(output):]
      /*rdi*/output_current:=output_begin
      input_begin:=raw_data(input)
      input_end:=input_begin[len(input):]
      /*rsi*/input_current:=input_begin
      /*eax*/error:=asm([^]u8,[^]u8,[^]u8,[^]u8,[^]u8,[^]u8,[^]u8)->b32 #intel{
         assembly.assembly,
         "={eax},{rdx},{r8},{r9},{rdi},{r10},{rsi},{r11},~{cc},~{memory}"
      }(tape_current,tape_begin,tape_end,output_current,output_end,input_current,input_end)
      return bool(error)
   }
   return run
}

main::proc(){
   hello_world::">++++++++[<+++++++++>-]<.>++++[<+++++++>-]<+.+++++++..+++.>>++++++[<+++++++>-]<++.------------.>++++++[<+++++++++>-]<+.<.+++.------.--------.>>>++++[<++++++++>-]<+."

   //from https://esolangs.org/wiki/Brainfuck
   hello_world_1::"+++++++++++[>++++++>+++++++++>++++++++>++++>+++>+<<<<<<-]>++++++.>++.+++++++..+++.>>.>-.<<-.<.+++.------.--------.>>>+.>-."
   hello_world_2::"<+>+>+>+>+>+>+>+>+>+>+ <<<<<<<<<<>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++.>-.>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++."
   hello_world_3::"++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++."
   hello_world_4::">++++++++[-<+++++++++>]<.>>+>-[+]++>++>+++[>[->+++<<+++>]<<]>-----.>->+++..+++.>-.<<+[>[+>+]>>]<--------------.>>.+++.------.--------.>+.>+."
   hello_world_5::"+[-->-[>>+>-----<<]<--<---]>-.>>>+.>>..+++[.>]<<<<.+++.------.<<-.>>>>+."
   hello_world_6::"--<-<<+[+[<+>--->->->-<<<]>]<<--.<++++++.<<-..<<.<+.>>.>>.<<<.+++.>>.>>-.<<<+."

   quine::"-->+++>+>+>+>+++++>++>++>->+++>++>+>>>>>>>>>>>>>>>>->++++>>>>->+++>+++>+++>+++>+++>+++>+>+>>>->->>++++>+>>>>->>++++>+>+>>->->++>++>++>++++>+>++>->++>++++>+>+>++>++>->->++>++>++++>+>+>>>>>->>->>++++>++>++>++++>>>>>->>>>>+++>->++++>->->->+++>>>+>+>+++>+>++++>>+++>->>>>>->>>++++>++>++>+>+++>->++++>>->->+++>+>+++>+>++++>>>+++>->++++>>->->++>++++>++>++++>>++[-[->>+[>]++[<]<]>>+[>]<--[++>++++>]+[<]<<++]>>>[>]++++>++++[--[+>+>++++<<[-->>--<<[->-<[--->>+<<[+>+++<[+>>++<<]]]]]]>+++[>+++++++++++++++<-]>--.<<<]"

   /*
      - 0:    24 steps
      - 1:   276 steps
      - 2:  2024 steps in  1 second
      - 3: 10626 steps in  1 minute
      - 4: 42504 steps in 50 minutes (before core speedup)
   */
   SELECTION::7
   COMPILE::true
   DEPTH::2

   when SELECTION==0{
      SOURCE::hello_world
      NAME::"hello_world"
   }else when SELECTION==1{
      SOURCE::hello_world_1
      NAME::"hello_world_1"
   }else when SELECTION==2{
      SOURCE::hello_world_2
      NAME::"hello_world_2"
   }else when SELECTION==3{
      SOURCE::hello_world_3
      NAME::"hello_world_3"
   }else when SELECTION==4{
      SOURCE::hello_world_4
      NAME::"hello_world_4"
   }else when SELECTION==5{
      SOURCE::hello_world_5
      NAME::"hello_world_5"
   }else when SELECTION==6{
      SOURCE::hello_world_6
      NAME::"hello_world_6"
   }else when SELECTION==7{
      SOURCE::quine
      NAME::"quine"
   }else{
      #panic("Invalid selection")
   }

   when COMPILE{
      runtime,constraints,ok:=compile_at_runtime(SOURCE,NAME)
      if !ok{
         fmt.println("Error compiling "+NAME)
         return
      }
      defer delete(runtime)

      lines:=runtime
      prev_line,line_ok:=strings.split_lines_iterator(&lines)
      if line_ok{
         for line in strings.split_lines_iterator(&lines){
            fmt.printfln("   \"%s\\n\"+",prev_line)
            prev_line=line
         }
         fmt.printfln("   \"%s\",",prev_line)
      }

      compiletime::comp.v(Assembler_3(Assembler_State(SOURCE,NAME,"",0,"",false),22),"v").assembly
      fmt.println(runtime==compiletime)

      run:=compile(SOURCE,NAME)
      tape:=make([]u8,30000)
      defer delete(tape)
      input:="testing wait this does\x00work"
      output:[1024]u8
      err:=run(tape,output[:len(output)-1],transmute([]u8)input)
      if err{
         fmt.println("did not finish successfully")
      }
      fmt.printfln("Result: %q",strings.unsafe_string_to_cstring(string(output[:])))
      fmt.printfln("Tape: %x",tape[:16])
   }else{
      result,escaped,steps,finished:=brainfuck(SOURCE,DEPTH)
      fmt.println("Name: "+NAME)
      fmt.println("Finished:",finished)
      fmt.println("Steps:",steps)
      fmt.printfln("Result: %q",result)
      fmt.println("Escaped:",escaped)
   }
}
