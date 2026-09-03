package odin_compiletime

PACKAGE::"odin_compiletime"

import "base:intrinsics"

//NOTE(sobex) the return parameter exists so you can use it in global scope like `_:=comp.ERROR("message")`.
ERROR::#force_inline proc"contextless"($MESSAGE:string)->bool{
   #panic("\e[G\e[K"+MESSAGE+"\n")
   return true
}

//NOTE(sobex) this warning only works once due each call having the same Source_Code_Location.
//            if you want multiple warnings copy this snippet for every message you want to display.
//            ```odin
//               WARNING_N::proc"contextless"(){
//                  MESSAGE::"Warning: warning"
//                  @(deprecated="\e[G\e[K"+MESSAGE+"\n")_WARNING::#force_inline proc"contextless"(){}
//                  #force_inline _WARNING()
//               }
//            ```
//            the return parameter exists so you can use it in global scope like `_:=comp.WARNING("message")`.
WARNING::#force_inline proc"contextless"($MESSAGE:string)->bool{
   @(deprecated="\e[G\e[K"+MESSAGE+"\n")_WARNING::#force_inline proc"contextless"(){}
   _WARNING()
   return true
}

v::intrinsics.type_field_type
p::intrinsics.procedure_of
r::intrinsics.type_proc_return_type
n::intrinsics.type_canonical_name

//None::struct(v:void){}
None::struct{}

Bool::struct(v:bool){}
B8::struct(v:b8){}
B16::struct(v:b16){}
B32::struct(v:b32){}
B64::struct(v:b64){}

I8::struct(v:i8){}
U8::struct(v:u8){}
I16::struct(v:i16){}
U16::struct(v:u16){}
I32::struct(v:i32){}
U32::struct(v:u32){}
I64::struct(v:i64){}
U64::struct(v:u64){}
I128::struct(v:i128){}
U128::struct(v:u128){}

Rune::struct(v:rune){}

F16::struct(v:f16){}
F32::struct(v:f32){}
F64::struct(v:f64){}

Complex32::struct(v:complex32){}
Complex64::struct(v:complex64){}
Complex128::struct(v:complex128){}

Quaternion64::struct(v:quaternion64){}
Quaternion128::struct(v:quaternion128){}
Quaternion256::struct(v:quaternion256){}

Int::struct(v:int){}
Uint::struct(v:uint){}
Uintptr::struct(v:uintptr){}
Rawptr::struct(v:rawptr){}

String::struct(v:string){}
Cstring::struct(v:cstring){}

String16::struct(v:string16){}
Cstring16::struct(v:cstring16){}

//Any::struct(v:any){}
Any::struct(v:typeid){}

Typeid::struct(v:typeid){}

I16le::struct(v:i16le){}
U16le::struct(v:u16le){}
I32le::struct(v:i32le){}
U32le::struct(v:u32le){}
I64le::struct(v:i64le){}
U64le::struct(v:u64le){}
I128le::struct(v:i128le){}
U128le::struct(v:u128le){}

I16be::struct(v:i16be){}
U16be::struct(v:u16be){}
I32be::struct(v:i32be){}
U32be::struct(v:u32be){}
I64be::struct(v:i64be){}
U64be::struct(v:u64be){}
I128be::struct(v:i128be){}
U128be::struct(v:u128be){}

F16le::struct(v:f16le){}
F32le::struct(v:f32le){}
F64le::struct(v:f64le){}

F16be::struct(v:f16be){}
F32be::struct(v:f32be){}
F64be::struct(v:f64be){}

Byte::struct(v:byte){}

Mul::struct(l,r:/*I128*/typeid){
   v:I128(l.v*r.v)
}

Pow::struct(m:/*I128*/typeid,exp:uint){
   v:/*I128*/(
      (
         I128(1)
      )when exp==0 else(
         m
      )when exp==1 else(
         v(Pow(v(Mul(m,m),"v"),exp/2),"v")
      )when exp%2==0 else(
         v(Mul(v(Pow(m,exp/2),"v"),v(Pow(m,(exp+1)/2),"v")),"v")
      )
   )
}

RUNES::[256]string{
   0x00="\x00",
   0x01="\x01",
   0x02="\x02",
   0x03="\x03",
   0x04="\x04",
   0x05="\x05",
   0x06="\x06",
   0x07="\x07",
   0x08="\x08",
   0x09="\x09",
   0x0A="\x0A",
   0x0B="\x0B",
   0x0C="\x0C",
   0x0D="\x0D",
   0x0E="\x0E",
   0x0F="\x0F",
   0x10="\x10",
   0x11="\x11",
   0x12="\x12",
   0x13="\x13",
   0x14="\x14",
   0x15="\x15",
   0x16="\x16",
   0x17="\x17",
   0x18="\x18",
   0x19="\x19",
   0x1A="\x1A",
   0x1B="\x1B",
   0x1C="\x1C",
   0x1D="\x1D",
   0x1E="\x1E",
   0x1F="\x1F",
   0x20="\x20",
   0x21="\x21",
   0x22="\x22",
   0x23="\x23",
   0x24="\x24",
   0x25="\x25",
   0x26="\x26",
   0x27="\x27",
   0x28="\x28",
   0x29="\x29",
   0x2A="\x2A",
   0x2B="\x2B",
   0x2C="\x2C",
   0x2D="\x2D",
   0x2E="\x2E",
   0x2F="\x2F",
   0x30="\x30",
   0x31="\x31",
   0x32="\x32",
   0x33="\x33",
   0x34="\x34",
   0x35="\x35",
   0x36="\x36",
   0x37="\x37",
   0x38="\x38",
   0x39="\x39",
   0x3A="\x3A",
   0x3B="\x3B",
   0x3C="\x3C",
   0x3D="\x3D",
   0x3E="\x3E",
   0x3F="\x3F",
   0x40="\x40",
   0x41="\x41",
   0x42="\x42",
   0x43="\x43",
   0x44="\x44",
   0x45="\x45",
   0x46="\x46",
   0x47="\x47",
   0x48="\x48",
   0x49="\x49",
   0x4A="\x4A",
   0x4B="\x4B",
   0x4C="\x4C",
   0x4D="\x4D",
   0x4E="\x4E",
   0x4F="\x4F",
   0x50="\x50",
   0x51="\x51",
   0x52="\x52",
   0x53="\x53",
   0x54="\x54",
   0x55="\x55",
   0x56="\x56",
   0x57="\x57",
   0x58="\x58",
   0x59="\x59",
   0x5A="\x5A",
   0x5B="\x5B",
   0x5C="\x5C",
   0x5D="\x5D",
   0x5E="\x5E",
   0x5F="\x5F",
   0x60="\x60",
   0x61="\x61",
   0x62="\x62",
   0x63="\x63",
   0x64="\x64",
   0x65="\x65",
   0x66="\x66",
   0x67="\x67",
   0x68="\x68",
   0x69="\x69",
   0x6A="\x6A",
   0x6B="\x6B",
   0x6C="\x6C",
   0x6D="\x6D",
   0x6E="\x6E",
   0x6F="\x6F",
   0x70="\x70",
   0x71="\x71",
   0x72="\x72",
   0x73="\x73",
   0x74="\x74",
   0x75="\x75",
   0x76="\x76",
   0x77="\x77",
   0x78="\x78",
   0x79="\x79",
   0x7A="\x7A",
   0x7B="\x7B",
   0x7C="\x7C",
   0x7D="\x7D",
   0x7E="\x7E",
   0x7F="\x7F",
   0x80="\x80",
   0x81="\x81",
   0x82="\x82",
   0x83="\x83",
   0x84="\x84",
   0x85="\x85",
   0x86="\x86",
   0x87="\x87",
   0x88="\x88",
   0x89="\x89",
   0x8A="\x8A",
   0x8B="\x8B",
   0x8C="\x8C",
   0x8D="\x8D",
   0x8E="\x8E",
   0x8F="\x8F",
   0x90="\x90",
   0x91="\x91",
   0x92="\x92",
   0x93="\x93",
   0x94="\x94",
   0x95="\x95",
   0x96="\x96",
   0x97="\x97",
   0x98="\x98",
   0x99="\x99",
   0x9A="\x9A",
   0x9B="\x9B",
   0x9C="\x9C",
   0x9D="\x9D",
   0x9E="\x9E",
   0x9F="\x9F",
   0xA0="\xA0",
   0xA1="\xA1",
   0xA2="\xA2",
   0xA3="\xA3",
   0xA4="\xA4",
   0xA5="\xA5",
   0xA6="\xA6",
   0xA7="\xA7",
   0xA8="\xA8",
   0xA9="\xA9",
   0xAA="\xAA",
   0xAB="\xAB",
   0xAC="\xAC",
   0xAD="\xAD",
   0xAE="\xAE",
   0xAF="\xAF",
   0xB0="\xB0",
   0xB1="\xB1",
   0xB2="\xB2",
   0xB3="\xB3",
   0xB4="\xB4",
   0xB5="\xB5",
   0xB6="\xB6",
   0xB7="\xB7",
   0xB8="\xB8",
   0xB9="\xB9",
   0xBA="\xBA",
   0xBB="\xBB",
   0xBC="\xBC",
   0xBD="\xBD",
   0xBE="\xBE",
   0xBF="\xBF",
   0xC0="\xC0",
   0xC1="\xC1",
   0xC2="\xC2",
   0xC3="\xC3",
   0xC4="\xC4",
   0xC5="\xC5",
   0xC6="\xC6",
   0xC7="\xC7",
   0xC8="\xC8",
   0xC9="\xC9",
   0xCA="\xCA",
   0xCB="\xCB",
   0xCC="\xCC",
   0xCD="\xCD",
   0xCE="\xCE",
   0xCF="\xCF",
   0xD0="\xD0",
   0xD1="\xD1",
   0xD2="\xD2",
   0xD3="\xD3",
   0xD4="\xD4",
   0xD5="\xD5",
   0xD6="\xD6",
   0xD7="\xD7",
   0xD8="\xD8",
   0xD9="\xD9",
   0xDA="\xDA",
   0xDB="\xDB",
   0xDC="\xDC",
   0xDD="\xDD",
   0xDE="\xDE",
   0xDF="\xDF",
   0xE0="\xE0",
   0xE1="\xE1",
   0xE2="\xE2",
   0xE3="\xE3",
   0xE4="\xE4",
   0xE5="\xE5",
   0xE6="\xE6",
   0xE7="\xE7",
   0xE8="\xE8",
   0xE9="\xE9",
   0xEA="\xEA",
   0xEB="\xEB",
   0xEC="\xEC",
   0xED="\xED",
   0xEE="\xEE",
   0xEF="\xEF",
   0xF0="\xF0",
   0xF1="\xF1",
   0xF2="\xF2",
   0xF3="\xF3",
   0xF4="\xF4",
   0xF5="\xF5",
   0xF6="\xF6",
   0xF7="\xF7",
   0xF8="\xF8",
   0xF9="\xF9",
   0xFA="\xFA",
   0xFB="\xFB",
   0xFC="\xFC",
   0xFD="\xFD",
   0xFE="\xFE",
   0xFF="\xFF"
}

U8_PREFIX::PACKAGE+"::U8(v:$$"
U8_OFFSET::len(U8_PREFIX)
Stringify_U8::struct(value:u8){
   v:String(n(U8(value))[U8_OFFSET:len(n(U8(value)))-1])
}

U128_PREFIX::PACKAGE+"::U128(v:$$"
U128_OFFSET::len(U128_PREFIX)
Stringify_U128::struct(value:u128){
   v:String(n(U128(value))[U128_OFFSET:len(n(U128(value)))-1])
}

F64_PREFIX::PACKAGE+"::F64(v:$$"
F64_OFFSET::len(F64_PREFIX)
Stringify_F64::struct(value:f64){
   v:String(n(F64(value))[F64_OFFSET:len(n(F64(value)))-1])
}

INT_PREFIX::PACKAGE+"::Int(v:$$"
INT_OFFSET::len(INT_PREFIX)
Stringify_Int::struct(value:int){
   v:String(n(Int(value))[INT_OFFSET:len(n(Int(value)))-1])
}

UINT_PREFIX::PACKAGE+"::Uint(v:$$"
UINT_OFFSET::len(UINT_PREFIX)
Stringify_Uint::struct(value:uint){
   v:String(n(Uint(value))[UINT_OFFSET:len(n(Uint(value)))-1])
}

Normalize_Type::struct(Type:typeid){
   /*TODO
      if struct with 0 fields := struct{}
      if struct with 1 fields := struct{v0:T}
      if struct with more fields := type_of(compress_values(expand_values(Struct_Type{})))
      else type
   */
}

Field_Type_By_Index::struct(Struct_Type:typeid,index:uint)where intrinsics.type_is_struct(Type){
   v:(
      (
         #panic(intrinsics.type_canonical_name(Struct_Type)+" has too few fields")
      )when index>=intrinsics.type_struct_field_count(Struct_Type) else(
         type_of(compress_values(expand_values(Struct_Type{})))
      )when intrinsics.type_struct_field_count(Struct_Type)==1 else(
         intrinsics.type_field_type(type_of(compress_values(expand_values(Struct_Type{}))),"v"+v(Stringify_Uint(index),"v").v)
      )
   )
}

Pad_Left::struct(str:string,space:string,width:uint){
   v:String(
      (
         #panic("string longer than width")
      )when len(str)>width else(
         v(Buffer_Make_Value((width-len(str))/len(space),space),"v").v+space[:(width-len(str))%%len(space)]+str
      )
   )
}

Pad_Right::struct(str:string,space:string,width:uint){
   v:String(
      (
         #panic("string longer than width")
      )when len(str)>width else(
         str+v(Buffer_Make_Value((width-len(str))/len(space),space),"v").v+space[:(width-len(str))%%len(space)]
      )
   )
}

//NOTE(sobex) [N]u8 needs exponentially long to typecheck
Buffer::struct(v:string){}

Buffer_Make_Value::struct(count:uint,value:string){
   v:Buffer(
      (
         ""
      )when count==0 else(
         value
      )when count==1 else(
         value+value
      )when count==2 else(
         value+value+value
      )when count==3 else(
         value+value+value+value
      )when count==4 else(
         value+value+value+value+value
      )when count==5 else(
         value+value+value+value+value+value
      )when count==6 else(
         value+value+value+value+value+value+value
      )when count==7 else(
         value+value+value+value+value+value+value+value
      )when count==8 else(
         value+value+value+value+value+value+value+value+value
      )when count==9 else(
         value+value+value+value+value+value+value+value+value+value
      )when count==10 else(
         value+value+value+value+value+value+value+value+value+value+value
      )when count==11 else(
         value+value+value+value+value+value+value+value+value+value+value+value
      )when count==12 else(
         value+value+value+value+value+value+value+value+value+value+value+value+value
      )when count==13 else(
         value+value+value+value+value+value+value+value+value+value+value+value+value+value
      )when count==14 else(
         value+value+value+value+value+value+value+value+value+value+value+value+value+value+value
      )when count==15 else(
         value+value+value+value+value+value+value+value+value+value+value+value+value+value+value+value
      )when count==16 else(
         v(Buffer_Make_Value(count/2,value),"v").v+v(Buffer_Make_Value((count+1)/2,value),"v").v
      )
   )
}

Buffer_Make::struct(length:uint){
   v:v(Buffer_Make_Value(length,"\x00"),"v")
}

Buffer_Find::struct(buffer:string,value:u8,offset:int){
   v:Int(
      (
         max(int)
      )when len(buffer)==0 else(
         offset when buffer[0]==value else max(int)
      )when len(buffer)==1 else(
         min(v(Buffer_Find(buffer[:len(buffer)/2],value,offset),"v").v,v(Buffer_Find(buffer[len(buffer)/2:],value,offset+len(buffer)/2),"v").v)
      )
   )
}

Buffer_Find_Last::struct(buffer:string,value:u8,offset:int){
   v:Int(
      (
         min(int)
      )when len(buffer)==0 else(
         offset when buffer[0]==value else min(int)
      )when len(buffer)==1 else(
         max(v(Buffer_Find_Last(buffer[:len(buffer)/2],value,offset),"v").v,v(Buffer_Find_Last(buffer[len(buffer)/2:],value,offset+len(buffer)/2),"v").v)
      )
   )
}

Buffer_Find_Matching_Parens_Option::enum{
   Round,Square,Curly,Angled
}

//maybe it could switch over the current char and detect what im looking for, have this be a wrapper over _Buffer_Find...
Buffer_Find_Closing_Matching_Parens::struct(buffer:string,index:int,option:Buffer_Find_Matching_Parens_Option){
   /*TODO*/v:Int(0)
}

Buffer_Find_Opening_Matching_Parens::struct(buffer:string,index:int,option:Buffer_Find_Matching_Parens_Option){
   /*TODO*/v:Int(0)
}

Buffer_Print::struct(buffer:string){
   v:String(
      (
         ""
      )when len(buffer)==0 else(
         n(U8(buffer[0]))[U8_OFFSET:len(n(U8(buffer[0])))-1]
      )when len(buffer)==1 else(
         v(Buffer_Print(buffer[:len(buffer)/2]),"v").v+","+v(Buffer_Print(buffer[len(buffer)/2:]),"v").v
      )
   )
}

Pack::struct(size:uint,value:u128){
   v:Buffer(
      (
         RUNES[value&0xFF]
      )when size==1 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]
      )when size==2 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]
      )when size==3 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]
      )when size==4 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]
      )when size==5 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]
      )when size==6 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]
      )when size==7 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]
      )when size==8 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]
      )when size==9 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]+RUNES[(value>>72)&0xFF]
      )when size==10 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]+RUNES[(value>>72)&0xFF]+RUNES[(value>>80)&0xFF]
      )when size==11 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]+RUNES[(value>>72)&0xFF]+RUNES[(value>>80)&0xFF]+RUNES[(value>>88)&0xFF]
      )when size==12 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]+RUNES[(value>>72)&0xFF]+RUNES[(value>>80)&0xFF]+RUNES[(value>>88)&0xFF]+RUNES[(value>>96)&0xFF]
      )when size==13 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]+RUNES[(value>>72)&0xFF]+RUNES[(value>>80)&0xFF]+RUNES[(value>>88)&0xFF]+RUNES[(value>>96)&0xFF]+RUNES[(value>>104)&0xFF]
      )when size==14 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]+RUNES[(value>>72)&0xFF]+RUNES[(value>>80)&0xFF]+RUNES[(value>>88)&0xFF]+RUNES[(value>>96)&0xFF]+RUNES[(value>>104)&0xFF]+RUNES[(value>>112)&0xFF]
      )when size==15 else(
         RUNES[value&0xFF]+RUNES[(value>>8)&0xFF]+RUNES[(value>>16)&0xFF]+RUNES[(value>>24)&0xFF]+RUNES[(value>>32)&0xFF]+RUNES[(value>>40)&0xFF]+RUNES[(value>>48)&0xFF]+RUNES[(value>>56)&0xFF]+RUNES[(value>>64)&0xFF]+RUNES[(value>>72)&0xFF]+RUNES[(value>>80)&0xFF]+RUNES[(value>>88)&0xFF]+RUNES[(value>>96)&0xFF]+RUNES[(value>>104)&0xFF]+RUNES[(value>>112)&0xFF]+RUNES[(value>>120)&0xFF]
      )when size==16 else(
         #panic("pack size "+n(Uint(size))[UINT_OFFSET:len(n(Uint(size)))-1]+" > 16")
      )
   )
}

Unpack::struct(size:uint,buffer:string){
   v:U128(
      (
         #panic("buffer \""+buffer+"\" shorter than requested size "+n(Uint(size))[UINT_OFFSET:len(n(Uint(size)))-1])
      )when len(buffer)<size else(
         u128(buffer[0])
      )when size==1 else(
         u128(buffer[0])+u128(buffer[1])<<8
      )when size==2 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16
      )when size==3 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24
      )when size==4 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32
      )when size==5 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40
      )when size==6 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48
      )when size==7 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56
      )when size==8 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64
      )when size==9 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64+u128(buffer[9])<<72
      )when size==10 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64+u128(buffer[9])<<72+u128(buffer[10])<<80
      )when size==11 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64+u128(buffer[9])<<72+u128(buffer[10])<<80+u128(buffer[11])<<88
      )when size==12 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64+u128(buffer[9])<<72+u128(buffer[10])<<80+u128(buffer[11])<<88+u128(buffer[12])<<96
      )when size==13 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64+u128(buffer[9])<<72+u128(buffer[10])<<80+u128(buffer[11])<<88+u128(buffer[12])<<96+u128(buffer[13])<<104
      )when size==14 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64+u128(buffer[9])<<72+u128(buffer[10])<<80+u128(buffer[11])<<88+u128(buffer[12])<<96+u128(buffer[13])<<104+u128(buffer[14])<<112
      )when size==15 else(
         u128(buffer[0])+u128(buffer[1])<<8+u128(buffer[2])<<16+u128(buffer[3])<<24+u128(buffer[4])<<32+u128(buffer[5])<<40+u128(buffer[6])<<48+u128(buffer[7])<<56+u128(buffer[8])<<64+u128(buffer[9])<<72+u128(buffer[10])<<80+u128(buffer[11])<<88+u128(buffer[12])<<96+u128(buffer[13])<<104+u128(buffer[14])<<112+u128(buffer[15])<<120
      )when size==16 else(
         #panic("unpack size "+n(Uint(size))[UINT_OFFSET:len(n(Uint(size)))-1]+" > 16")
      )
   )
}

_MAGEBILL::"\e[40m           \e[44m        \e[40m           \e[0m\n"+
           "\e[40m          \e[44m          \e[40m          \e[0m\n"+
           "\e[40m         \e[44m         \e[40m            \e[0m\n"+
           "\e[40m     \e[44m    \e[45m         \e[44m     \e[40m       \e[0m\n"+
           "\e[40m   \e[44m                      \e[40m     \e[0m\n"+
           "\e[40m  \e[44m     \e[47m           \e[43m   \e[44m     \e[40m    \e[0m\n"+
           "\e[40m  \e[44m     \e[47m           \e[43m   \e[44m  \e[46m     \e[40m  \e[0m\n"+
           "\e[40m   \e[44m    \e[47m           \e[43m   \e[44m \e[46m       \e[40m \e[0m\n"+
           "\e[40m       \e[47m           \e[43m   \e[40m  \e[46m     \e[40m  \e[0m\n"+
           "\e[40m       \e[47m \e[43m       \e[47m  \e[43m   \e[40m    \e[43m   \e[40m   \e[0m\n"+
           "\e[40m       \e[43m  \e[47m     \e[43m    \e[47m  \e[40m    \e[43m   \e[40m   \e[0m\n"+
           "\e[40m       \e[43m          \e[47m   \e[40m    \e[43m   \e[40m   \e[0m\n"+
           "\e[40m        \e[47m            \e[40m    \e[43m   \e[40m   \e[0m\n"+
           "\e[40m      \e[44m  \e[47m            \e[44m   \e[40m \e[43m   \e[40m   \e[0m\n"+
           "\e[40m  \e[44m       \e[47m          \e[44m     \e[43m   \e[40m   \e[0m\n"+
           "\e[40m \e[44m                       \e[43m   \e[40m   \e[0m\n"

_MAGEBILLASCII::"\e[30m           \e[34m,-----..\e[30m           \e[0m\n"+
                "\e[30m          \e[34m:       .'\e[30m          \e[0m\n"+
                "\e[30m         \e[34m:       :\e[30m            \e[0m\n"+
                "\e[30m     \e[34m.--'\e[35m#########\e[34m'---.\e[30m       \e[0m\n"+
                "\e[30m   \e[34m,---.============.---,\e[30m     \e[0m\n"+
                "\e[30m  \e[34m:    \e[37m:          \e[33m###\e[34m    :\e[30m    \e[0m\n"+
                "\e[30m  \e[34m:    \e[37m:          \e[33m###\e[34m  \e[36m.---.\e[30m  \e[0m\n"+
                "\e[30m   \e[34m'---\e[37m:          \e[33m###\e[34m-\e[36m:     :\e[30m \e[0m\n"+
                "\e[30m       \e[37m:          \e[33m###\e[30m  \e[36m:___:\e[30m  \e[0m\n"+
                "\e[30m       \e[37m:\e[33m#######\e[37m  \e[33m##:\e[30m    \e[33m: :\e[30m   \e[0m\n"+
                "\e[30m       \e[33m##\e[37m     \e[33m####\e[37m .\e[30m    \e[33m: :\e[30m   \e[0m\n"+
                "\e[30m       \e[33m'#########\e[37m  :\e[30m    \e[33m: :\e[30m   \e[0m\n"+
                "\e[30m        \e[37m:          .\e[30m    \e[33m: :\e[30m   \e[0m\n"+
                "\e[30m      \e[34m.:\e[37m:          .\e[34m::.\e[30m \e[33m: :\e[30m   \e[0m\n"+
                "\e[30m  \e[34m..-=   \e[37m'--------'\e[34m    =\e[33m: :\e[30m   \e[0m\n"+
                "\e[30m \e[34m:______________________\e[33m:_:\e[30m   \e[0m\n"

when #config(MAGEBILL,false){
   #panic("\e[G\e[K"+_MAGEBILL)
}else when #config(MAGEBILLASCII,false){
   #panic("\e[G\e[K"+_MAGEBILLASCII)
}
