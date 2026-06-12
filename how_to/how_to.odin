package odin_compiletime_how_to

import comp ".."

how_to__general_notes::proc()->string{
   return #load("../general_notes.md",string)
}

how_to_get_value_from_compiletime_value::proc($compiletime:typeid/comp.Int($v))->int{
   return compiletime.v
}

how_to_get_value_from_compiletime_proc::proc($exp:uint)->int{
   pow2::struct(exp:uint){
      v:comp.Int(1<<exp)
   }
   return comp.v(pow2(exp),"v").v
}

how_to_stringify_value::proc($v:int)->string{
   //PACKAGE::Int(v:$$v)
   full::comp.n(comp.Int(v))
   offset::len(comp.PACKAGE)+len("Int")+7
   return full[offset:len(full)-1]
}

how_to_stringify_u8::proc($v:u8)->string{
   full::comp.n(comp.U8(v))
   return full[comp.U8_OFFSET:len(full)-1]
}

//NOTE(sobex) #assert only accepts constant strings, not compiletime strings, use `when !(condition) { #panic(message) }` instead
how_to_assert::proc($index,$count:int)->string{
   //runtime.bounds_check_error

   index_str_full::comp.n(comp.Int(index))
   index_str_offset::len(comp.PACKAGE)+len("Int")+7
   index_str::index_str_full[index_str_offset:len(index_str_full)-1]

   count_str_full::comp.n(comp.Int(count))
   count_str_offset::len(comp.PACKAGE)+len("Int")+7
   count_str::count_str_full[count_str_offset:len(count_str_full)-1]

   message::"Index "+index_str+" is out of range 0..<"+count_str+"\n"
   return message
}

how_to_buffer::proc($length:uint,$index:uint,$value:u8)->(_buffer:string,_found:uint,_escaped:string){
   buffer::comp.v(comp.Buffer_Make(length),"v").v
   modified::buffer[:index]+comp.RUNES[value]+buffer[index+1:]
   found::comp.v(comp.Buffer_Find(modified,value,0),"v").v
   escaped::"["+comp.v(comp.Buffer_Print(modified),"v").v+"]"
   return modified,found,escaped
}

how_to_fibonacci::proc($i:uint)->u128{
   return comp.v(comp.Fibonacci(i),"v").v
}
