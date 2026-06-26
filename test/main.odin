package odin_compiletime_test

import comp ".."
import how "../how_to"

import "base:intrinsics"
import "core:fmt"
import "core:log"
import "core:testing"

//NOTE(sobex) some tests arent designed to run on the default windows 1MB stacksize, this enables them and assumes `/STACK:8388608,1048576`
BIG_STACK::bool(#config(BIG_STACK,ODIN_OS!=.Windows))

@test test_how_to_get_value_from_compiletime_value::proc(t:^testing.T){
   testing.expect_value(t,how.how_to_get_value_from_compiletime_value(comp.Int(1234567890)),1234567890)
}

@test test_how_to_get_value_from_compiletime_proc::proc(t:^testing.T){
   testing.expect_value(t,how.how_to_get_value_from_compiletime_proc(29),1<<29)
}

@test test_how_to_stringify_value::proc(t:^testing.T){
   testing.expect_value(t,how.how_to_stringify_value(1234567890),"1234567890")
}

@test test_how_to_stringify_u8::proc(t:^testing.T){
   testing.expect_value(t,how.how_to_stringify_u8(127),"127")
}

@test test_how_to_assert::proc(t:^testing.T){
   testing.expect_value(t,how.how_to_assert(1234567890,123456789),"Index 1234567890 is out of range 0..<123456789\n")
}

@test test_how_to_buffer::proc(t:^testing.T){
   buffer,found,escaped:=how.how_to_buffer(31,15,'!')
   testing.expect_value(t,buffer,"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00!\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")
   testing.expect_value(t,found,15)
   testing.expect_value(t,escaped,"[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]")
}

@test test_how_to_fibonacci::proc(t:^testing.T){
   testing.expect_value(t,how.how_to_fibonacci(185),205697230343233228174223751303346572685)
}

@test test_how_to_globals::proc(t:^testing.T){
   src::`package odin_compiletime_test_globals

import "core:fmt"

print::proc(name:string,value:any){
   fmt.printfln("%s: %#w",name,value)
}

main::proc(){
   var:=5
   print("my var",var)
}
`
   expected::`package odin_compiletime_test_globals

import "core:fmt"

print::proc(name:string,value:any){...}

main::proc(){...}
`
   result,finished:=how.how_to_globals(src,2)
   testing.expect_value(t,finished,true)
   testing.expect_value(t,result,expected)
}

@test test_how_to_calculator::proc(t:^testing.T){
   when BIG_STACK{
      //TODO calculator test
      testing.expect_value(t,BIG_STACK,true)
   }
}

@test test_how_to_assemble::proc(t:^testing.T){
   COUNT::2
   EXPRESSION::"21+21*-"

   correct_calc::proc(a,b:int)->int{
      return (a*b)-(a+b)
   }

   _,assembly:=how.how_to_assemble(COUNT,EXPRESSION,0,0)

   for a in -10..=10{
      for b in -10..=10{
         result,_:=how.how_to_assemble(COUNT,EXPRESSION,a,b)
         expected:=correct_calc(a,b)
         testing.expect_value(t,result,expected)
      }
   }
}

when !ODIN_TEST{
   main::#force_no_inline proc(){
      console_logger:=log.create_console_logger()
      defer log.destroy_console_logger(context.logger)

      context.logger=log.Logger{
         procedure=proc(data:rawptr,level:log.Level,text:string,options:log.Options,location:=#caller_location){
            logger:=cast(^log.Logger)data
            logger.procedure(logger.data,level,text,options,location)
            when ODIN_DEBUG{
               intrinsics.debug_trap()
            }
         },
         data=&console_logger,
         lowest_level=console_logger.lowest_level,
         options=console_logger.options
      }

      fmt.println(how.how_to__general_notes())

      when true{{
         result,finished:=how.how_to_globals(#load("../main.odin",string),4)
         fmt.print(result)
         if finished{
            fmt.println(" <Finished successfully>")
         }else{
            fmt.println("<Aborted due to reaching iteration limit>")
         }
      }}

      test_how_to_get_value_from_compiletime_value(nil)
      test_how_to_get_value_from_compiletime_proc(nil)
      test_how_to_stringify_value(nil)
      test_how_to_stringify_u8(nil)
      test_how_to_assert(nil)
      test_how_to_buffer(nil)
      test_how_to_fibonacci(nil)
      test_how_to_globals(nil)
      test_how_to_calculator(nil)
      test_how_to_assemble(nil)

      fmt.println(comp.v(comp.Calculator_Calculator(
         comp.Calculator_Node_Division(.Division,
            comp.Calculator_Node_Number(.Number,0.000000000000000025,true),
            comp.Calculator_Node_Number(.Number,1e307,true)
         )
      ),"v").n)
      expression::"1+2*3"
      result::comp.v(comp.Calculator(expression),"v").n
      fmt.println(expression,result)
   }
}
