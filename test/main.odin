package odin_compiletime_test

import comp ".."

import "base:intrinsics"
import "core:fmt"
import "core:log"
import "core:testing"

@test test_how_to_get_value_from_compiletime_value::proc(t:^testing.T){
   testing.expect_value(t,comp.how_to_get_value_from_compiletime_value(comp.Int(1234567890)),1234567890)
}

@test test_how_to_get_value_from_compiletime_proc::proc(t:^testing.T){
   testing.expect_value(t,comp.how_to_get_value_from_compiletime_proc(29),1<<29)
}

@test test_how_to_stringify_value::proc(t:^testing.T){
   testing.expect_value(t,comp.how_to_stringify_value(1234567890),"1234567890")
}

@test test_how_to_stringify_u8::proc(t:^testing.T){
   testing.expect_value(t,comp.how_to_stringify_u8(127),"127")
}

@test test_how_to_assert::proc(t:^testing.T){
   testing.expect_value(t,comp.how_to_assert(1234567890,123456789),"Index 1234567890 is out of range 0..<123456789\n")
}

@test test_how_to_buffer::proc(t:^testing.T){
   buffer,found,escaped:=comp.how_to_buffer(31,15,'!')
   testing.expect_value(t,buffer,"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00!\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00")
   testing.expect_value(t,found,15)
   testing.expect_value(t,escaped,"[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,33,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]")
}

@test test_how_to_fibonacci::proc(t:^testing.T){
   testing.expect_value(t,comp.how_to_fibonacci(185),205697230343233228174223751303346572685)
}

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

   fmt.println(comp.how_to__general_notes())

   test_how_to_get_value_from_compiletime_value(nil)
   test_how_to_get_value_from_compiletime_proc(nil)
   test_how_to_stringify_value(nil)
   test_how_to_stringify_u8(nil)
   test_how_to_assert(nil)
   test_how_to_buffer(nil)
   test_how_to_fibonacci(nil)
}
