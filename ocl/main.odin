package compiletime_ocl

import comp ".."

/* OCL grammar
Program    = ( Statement ( "\n" Statement )* )?
Statement  = Assignment | Call
Assignment = IDENTIFIER "=" Rvalue
Rvalue     = IDENTIFIER | LITERAL | Call
Call       = IDENTIFIER "(" ( IDENTIFIER ( "," IDENTIFIER )* )? ")"

IDENTIFIER = [^=(,)\n]*
LITERAL    = [^=(,)\n]*
*/

Context::struct{
   variables:map[string]f64
}

run::proc(ctx:^Context,$code:string)->(ok:bool){
   _run_program(ctx,code,0) or_return
   return true
}

eval::proc($code:string,allocator:=context.allocator)->(ctx:Context,ok:bool){
   ctx.variables=make(map[string]f64,allocator)
   ok=run(&ctx,code)
   return ctx,ok
}
