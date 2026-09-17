package odin_compiletime_eval

import comp ".."

import "core:fmt"
import "core:strconv"

/*
Program    ::= ( Statement ( "\n" Statement )* )?
Statement  ::= Assignment | Call
Assignment ::= IDENTIFIER "=" Rvalue
Rvalue     ::= IDENTIFIER | LITERAL | Call
Call       ::= IDENTIFIER "(" ( IDENTIFIER ( "," IDENTIFIER )* )? ")"

IDENTIFIER ::= [^=(,)\n]*
LITERAL    ::= [^=(,)\n]*
*/

Context::struct{
   variables:map[string]f64
}

//TODO argc could probably be compiletime checked, maybe compress/expand_values and template argc, or directly calling _get_args in the call
_Args::[dynamic;8]f64

__add::#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   //TODO improve error handling wrong argc
   if len(args)!=2{
      return 0,false
   }
   result=args[0]+args[1]
   return result,true
}

__print::#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   if len(args)==1{
      result=f64(fmt.println(args[0]))
   }else{
      result=f64(fmt.println(args))
   }
   return result,true
}

_get_arg::#force_inline proc(ctx:^Context,$arg:string)->(result:f64,ok:bool){
   //TODO instead of runtime checking i could pass down a newline(?) separated list of declared variables
   if arg in ctx.variables{
      result=ctx.variables[arg] or_return
   }else{
      result=strconv.parse_f64(arg) or_return
   }
   return result,true
}

_get_args::#force_inline proc(ctx:^Context,result:^_Args,$args:string)->(ok:bool){
   next_comma::comp.v(comp.Buffer_Find(args,',',0),"v").v
   when next_comma!=max(int){
      arg::args[:next_comma]
      has_more_args::true
   }else{
      arg::args
      has_more_args::false
   }
   when arg!=""{
      arg_result:=#force_inline _get_arg(ctx,arg) or_return
      n_appended:=append(result,arg_result)
      if n_appended==0{
         return false
      }
   }
   when has_more_args{
      #force_inline _get_args(ctx,result,args[next_comma+1:]) or_return
   }
   return true
}

_run_call::#force_inline proc(ctx:^Context,$call:string)->(result:f64,ok:bool){
   next_open::comp.v(comp.Buffer_Find(call,'(',0),"v").v
   next_close::comp.v(comp.Buffer_Find(call,')',0),"v").v
   when next_close<next_open{
      #panic("TODO closing brace at X found before opening brace at X in call (\"X\")")
   }
   next_next_open::comp.v(comp.Buffer_Find(call[next_open +1:],'(',next_open +1),"v").v
   when next_next_open!=max(int){
      #panic("TODO multiple opening braces found in call at X and X (\"X\")")
   }
   next_next_close::comp.v(comp.Buffer_Find(call[next_close+1:],')',next_close+1),"v").v
   when next_next_close!=max(int){
      #panic("TODO multiple closing braces found in call at X and X (\"X\")")
   }
   function::call[:next_open]
   args_list::call[next_open+1:next_close]
   args:_Args
   #force_inline _get_args(ctx,&args,args_list) or_return
   when function=="add"{
      result=#force_inline __add(ctx,args) or_return
   }else when function=="print"{
      result=#force_inline __print(ctx,args) or_return
   }else{
      #panic("function \""+function+"\" not recognized")
   }
   return result,true
}

_run_rvalue::#force_inline proc(ctx:^Context,$rvalue:string)->(result:f64,ok:bool){
   next_open ::comp.v(comp.Buffer_Find(rvalue,'(',0),"v").v
   when next_open!=max(int){
      result=#force_inline _run_call(ctx,rvalue) or_return
   }else{
      result=#force_inline _get_arg(ctx,rvalue) or_return
   }
   return result,true
}

_run_assignment::#force_inline proc(ctx:^Context,$assignment:string)->(ok:bool){
   next_equals::comp.v(comp.Buffer_Find(assignment,'=',0),"v").v
   next_next_equals::comp.v(comp.Buffer_Find(assignment[next_equals+1:],'=',next_equals+1),"v").v
   when next_next_equals!=max(int){
      #panic("multiple equals signs found in assignment at "+comp.v(comp.Stringify_Int(next_equals),"v").v+" and "+comp.v(comp.Stringify_Int(next_next_equals),"v").v+" (\""+assignment+"\")")
   }
   identifier::assignment[:next_equals]
   rvalue::assignment[next_equals+1:]
   value:=#force_inline _run_rvalue(ctx,rvalue) or_return
   ctx.variables[identifier]=value
   return true
}

_run_statement::#force_inline proc(ctx:^Context,$statement:string)->(ok:bool){
   next_equals::comp.v(comp.Buffer_Find(statement,'=',0),"v").v
   when next_equals!=max(int){
      #force_inline _run_assignment(ctx,statement) or_return
   }else{
      #force_inline _run_call(ctx,statement) or_return
   }
   return true
}

_run_program::#force_inline proc(ctx:^Context,$program:string,$i:int)->(ok:bool){
   //NOTE(sobex) not slicing `program` here so we dont make string copies
   next_newline::comp.v(comp.Buffer_Find(program[i:],'\n',i),"v").v
   when next_newline!=max(int){
      statement::program[i:next_newline]
      has_more_statements::true
   }else{
      statement::program[i:]
      has_more_statements::false
   }
   when statement!=""{
      #force_inline _run_statement(ctx,statement) or_return
   }
   when has_more_statements{
      #force_inline _run_program(ctx,program,next_newline+1) or_return
   }
   return true
}

eval::proc($code:string,allocator:=context.allocator)->(ctx:Context,ok:bool){
   ctx.variables=make(map[string]f64,allocator)
   #force_inline _run_program(&ctx,code,0) or_return
   return ctx,true
}

import comp_eval "."

main::proc(){
   code::```
         a=0.1

         2=0.2
         b=2

         print(a)
         a=add(a,b)
         print(a)
         ```
   ctx,ok:=comp_eval.eval(code)
   //fmt.printfln("%q",code)
   fmt.println(ok,ctx)
}
