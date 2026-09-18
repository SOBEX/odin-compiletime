package compiletime_ocl

import comp ".."

import "core:strconv"

//TODO additionally to context add a `v:^$T` param that i can use for args with `intrinsics.type_has_field` etc
//or template context with defaulting to `Context(struct{})`

//TODO argc could probably be compiletime checked, maybe compress/expand_values and template argc, or directly calling _get_args in the call
_Args::[dynamic;8]f64

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
   when next_open==max(int)||next_close==max(int){
      #panic("no matching opening and closing brace found in call (\""+call+"\")")
   }else{
      when next_close<next_open{
         #panic("closing brace at "+comp.v(comp.Stringify_Int(next_close),"v").v+" found before opening brace at "+comp.v(comp.Stringify_Int(next_open),"v").v+" in call (\""+call+"\")")
      }
      next_next_open::comp.v(comp.Buffer_Find(call[next_open+1:],'(',next_open +1),"v").v
      when next_next_open!=max(int){
         #panic("multiple opening braces found in call at "+comp.v(comp.Stringify_Int(next_open),"v").v+" and "+comp.v(comp.Stringify_Int(next_next_open),"v").v+" (\""+call+"\")")
      }
      next_next_close::comp.v(comp.Buffer_Find(call[next_close+1:],')',next_close+1),"v").v
      when next_next_close!=max(int){
         #panic("multiple closing braces found in call at "+comp.v(comp.Stringify_Int(next_close),"v").v+" and "+comp.v(comp.Stringify_Int(next_next_close),"v").v+" (\""+call+"\")")
      }
      function::call[:next_open]
      args_list::call[next_open+1:next_close]
      args:_Args
      #force_inline _get_args(ctx,&args,args_list) or_return
      result=#force_inline _do_call(ctx,function,args) or_return
      return result,true
   }
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
   when next_equals==max(int){
      #panic("no equals sign found in assignment (\""+assignment+"\")")
   }else{
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
}

_run_statement::#force_inline proc(ctx:^Context,$statement:string)->(ok:bool){
   //TODO maybe trim a trailing \r
   next_equals::comp.v(comp.Buffer_Find(statement,'=',0),"v").v
   when next_equals!=max(int){
      #force_inline _run_assignment(ctx,statement) or_return
   }else{
      #force_inline _run_call(ctx,statement) or_return
   }
   return true
}

_run_program::proc(ctx:^Context,$program:string,$i:int)->(ok:bool){
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
