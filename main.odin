package odin_compiletime

PACKAGE::"odin_compiletime"

import "base:intrinsics"

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

RUNES::[256]string{
     0="\x00",
     1="\x01",
     2="\x02",
     3="\x03",
     4="\x04",
     5="\x05",
     6="\x06",
     7="\x07",
     8="\x08",
     9="\x09",
    10="\x0A",
    11="\x0B",
    12="\x0C",
    13="\x0D",
    14="\x0E",
    15="\x0F",
    16="\x10",
    17="\x11",
    18="\x12",
    19="\x13",
    20="\x14",
    21="\x15",
    22="\x16",
    23="\x17",
    24="\x18",
    25="\x19",
    26="\x1A",
    27="\x1B",
    28="\x1C",
    29="\x1D",
    30="\x1E",
    31="\x1F",
    32="\x20",
    33="\x21",
    34="\x22",
    35="\x23",
    36="\x24",
    37="\x25",
    38="\x26",
    39="\x27",
    40="\x28",
    41="\x29",
    42="\x2A",
    43="\x2B",
    44="\x2C",
    45="\x2D",
    46="\x2E",
    47="\x2F",
    48="\x30",
    49="\x31",
    50="\x32",
    51="\x33",
    52="\x34",
    53="\x35",
    54="\x36",
    55="\x37",
    56="\x38",
    57="\x39",
    58="\x3A",
    59="\x3B",
    60="\x3C",
    61="\x3D",
    62="\x3E",
    63="\x3F",
    64="\x40",
    65="\x41",
    66="\x42",
    67="\x43",
    68="\x44",
    69="\x45",
    70="\x46",
    71="\x47",
    72="\x48",
    73="\x49",
    74="\x4A",
    75="\x4B",
    76="\x4C",
    77="\x4D",
    78="\x4E",
    79="\x4F",
    80="\x50",
    81="\x51",
    82="\x52",
    83="\x53",
    84="\x54",
    85="\x55",
    86="\x56",
    87="\x57",
    88="\x58",
    89="\x59",
    90="\x5A",
    91="\x5B",
    92="\x5C",
    93="\x5D",
    94="\x5E",
    95="\x5F",
    96="\x60",
    97="\x61",
    98="\x62",
    99="\x63",
   100="\x64",
   101="\x65",
   102="\x66",
   103="\x67",
   104="\x68",
   105="\x69",
   106="\x6A",
   107="\x6B",
   108="\x6C",
   109="\x6D",
   110="\x6E",
   111="\x6F",
   112="\x70",
   113="\x71",
   114="\x72",
   115="\x73",
   116="\x74",
   117="\x75",
   118="\x76",
   119="\x77",
   120="\x78",
   121="\x79",
   122="\x7A",
   123="\x7B",
   124="\x7C",
   125="\x7D",
   126="\x7E",
   127="\x7F",
   128="\x80",
   129="\x81",
   130="\x82",
   131="\x83",
   132="\x84",
   133="\x85",
   134="\x86",
   135="\x87",
   136="\x88",
   137="\x89",
   138="\x8A",
   139="\x8B",
   140="\x8C",
   141="\x8D",
   142="\x8E",
   143="\x8F",
   144="\x90",
   145="\x91",
   146="\x92",
   147="\x93",
   148="\x94",
   149="\x95",
   150="\x96",
   151="\x97",
   152="\x98",
   153="\x99",
   154="\x9A",
   155="\x9B",
   156="\x9C",
   157="\x9D",
   158="\x9E",
   159="\x9F",
   160="\xA0",
   161="\xA1",
   162="\xA2",
   163="\xA3",
   164="\xA4",
   165="\xA5",
   166="\xA6",
   167="\xA7",
   168="\xA8",
   169="\xA9",
   170="\xAA",
   171="\xAB",
   172="\xAC",
   173="\xAD",
   174="\xAE",
   175="\xAF",
   176="\xB0",
   177="\xB1",
   178="\xB2",
   179="\xB3",
   180="\xB4",
   181="\xB5",
   182="\xB6",
   183="\xB7",
   184="\xB8",
   185="\xB9",
   186="\xBA",
   187="\xBB",
   188="\xBC",
   189="\xBD",
   190="\xBE",
   191="\xBF",
   192="\xC0",
   193="\xC1",
   194="\xC2",
   195="\xC3",
   196="\xC4",
   197="\xC5",
   198="\xC6",
   199="\xC7",
   200="\xC8",
   201="\xC9",
   202="\xCA",
   203="\xCB",
   204="\xCC",
   205="\xCD",
   206="\xCE",
   207="\xCF",
   208="\xD0",
   209="\xD1",
   210="\xD2",
   211="\xD3",
   212="\xD4",
   213="\xD5",
   214="\xD6",
   215="\xD7",
   216="\xD8",
   217="\xD9",
   218="\xDA",
   219="\xDB",
   220="\xDC",
   221="\xDD",
   222="\xDE",
   223="\xDF",
   224="\xE0",
   225="\xE1",
   226="\xE2",
   227="\xE3",
   228="\xE4",
   229="\xE5",
   230="\xE6",
   231="\xE7",
   232="\xE8",
   233="\xE9",
   234="\xEA",
   235="\xEB",
   236="\xEC",
   237="\xED",
   238="\xEE",
   239="\xEF",
   240="\xF0",
   241="\xF1",
   242="\xF2",
   243="\xF3",
   244="\xF4",
   245="\xF5",
   246="\xF6",
   247="\xF7",
   248="\xF8",
   249="\xF9",
   250="\xFA",
   251="\xFB",
   252="\xFC",
   253="\xFD",
   254="\xFE",
   255="\xFF"
}

U8_PREFIX::PACKAGE+"::U8(v:$$"
U8_OFFSET::len(U8_PREFIX)

U128_PREFIX::PACKAGE+"::U128(v:$$"
U128_OFFSET::len(U128_PREFIX)

F64_PREFIX::PACKAGE+"::F64(v:$$"
F64_OFFSET::len(F64_PREFIX)

INT_PREFIX::PACKAGE+"::Int(v:$$"
INT_OFFSET::len(INT_PREFIX)

UINT_PREFIX::PACKAGE+"::Uint(v:$$"
UINT_OFFSET::len(UINT_PREFIX)

//NOTE(sobex) [N]u8 needs exponentially long to typecheck
Buffer::struct(v:string){}

Buffer_Make::struct(length:uint){
   v:Buffer(
      (
         ""
      )when length==0 else(
         "\x00"
      )when length==1 else(
         v(Buffer_Make(length/2),"v").v+v(Buffer_Make((length+1)/2),"v").v
      )
   )
}

Buffer_Find::struct(buffer:string,value:u8,offset:uint){
   v:Uint(
      (
         max(uint)
      )when len(buffer)==0 else(
         offset when buffer[0]==value else max(uint)
      )when len(buffer)==1 else(
         min(v(Buffer_Find(buffer[:len(buffer)/2],value,offset),"v").v,v(Buffer_Find(buffer[len(buffer)/2:],value,offset+len(buffer)/2),"v").v)
      )
   )
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

Fibonacci_Matrix_2x2::struct(v:[2][2]u128){}

Fibonacci_Matrix_2x2_Identity::Fibonacci_Matrix_2x2({{1,0},{0,1}})

Fibonacci_Matrix_2x2_Mul::struct(l,r:/*Fibonacci_Matrix_2x2*/typeid){
   v:Fibonacci_Matrix_2x2(
      {
         {
            l.v[0][0]*r.v[0][0]+l.v[0][1]*r.v[1][0],
            l.v[0][0]*r.v[0][1]+l.v[0][1]*r.v[1][1]
         },
         {
            l.v[1][0]*r.v[0][0]+l.v[1][1]*r.v[1][0],
            l.v[1][0]*r.v[0][1]+l.v[1][1]*r.v[1][1]
         }
      }
   )
}

Fibonacci_Matrix_2x2_Pow::struct(m:/*Fibonacci_Matrix_2x2*/typeid,exp:uint){
   v:/*Fibonacci_Matrix_2x2*/(
      (
         Fibonacci_Matrix_2x2_Identity
      )when exp==0 else(
         m
      )when exp==1 else(
         v(Fibonacci_Matrix_2x2_Pow(v(Fibonacci_Matrix_2x2_Mul(m,m),"v"),exp/2),"v")
      )when exp%2==0 else(
         v(Fibonacci_Matrix_2x2_Mul(v(Fibonacci_Matrix_2x2_Pow(m,exp/2),"v"),v(Fibonacci_Matrix_2x2_Pow(m,(exp+1)/2),"v")),"v")
      )
   )
}

Fibonacci_Base::Fibonacci_Matrix_2x2({{1,1},{1,0}})

Fibonacci::struct(i:uint){
   v:U128(v(Fibonacci_Matrix_2x2_Pow(Fibonacci_Base,i),"v").v[0][1])
}

Globals_State::struct(remaining:string,depth:uint,result:string,steps:uint,finished:bool){}

//this is a bad implementation and doesnt check if a curly brace is in a comment or string, but shows off iterative state machines and how to avoid hitting the recursion limit
Globals_Core::struct(s:/*Globals_State*/typeid,iterations_left:uint){
   v:/*Globals_State*/(
      (
         s
      )when iterations_left<=0 else(
         s
      )when s.finished else(
         (
            Globals_State(s.remaining,s.depth,s.result,s.steps+1,true)
         )when s.depth==0 else(
            Globals_State(s.remaining,s.depth,s.result+"<EOF reached before End of Global>",s.steps+1,true)
         )
      )when len(s.remaining)==0 else(
         (
            v(Globals_Core(Globals_State(s.remaining[1:],s.depth+1,s.result when s.depth!=0 else (s.result+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[0]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               v(Globals_Core(Globals_State(s.remaining[1:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[0]=='}' else(
            v(Globals_Core(Globals_State(s.remaining[2:],s.depth+1,s.result when s.depth!=0 else (s.result+s.remaining[:1]+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[1]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               v(Globals_Core(Globals_State(s.remaining[2:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[1]=='}' else(
            v(Globals_Core(Globals_State(s.remaining[3:],s.depth+1,s.result when s.depth!=0 else (s.result+s.remaining[:2]+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[2]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               v(Globals_Core(Globals_State(s.remaining[3:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[2]=='}' else(
            v(Globals_Core(Globals_State(s.remaining[4:],s.depth+1,s.result when s.depth!=0 else (s.result+s.remaining[:3]+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[3]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               v(Globals_Core(Globals_State(s.remaining[4:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[3]=='}' else(
            v(Globals_Core(Globals_State(s.remaining[4:],s.depth,s.result when s.depth!=0 else (s.result+s.remaining[:4]),s.steps+1,s.finished),iterations_left-1),"v")
         )
      //NOTE(sobex) compiletime `&&` seems to not short circuit so `when len(s.remaining)>3&&s.remaining[3]=='X'` fails
      )when len(s.remaining)>=4 else(
         (
            v(Globals_Core(Globals_State(s.remaining[1:],s.depth+1,s.result when s.depth!=0 else (s.result+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[0]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               v(Globals_Core(Globals_State(s.remaining[1:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[0]=='}' else(
            v(Globals_Core(Globals_State(s.remaining[1:],s.depth,s.result when s.depth!=0 else (s.result+s.remaining[:1]),s.steps+1,s.finished),iterations_left-1),"v")
         )
      )
   )
}

Globals_1::struct(s:/*Globals_State*/typeid,iterations_left:uint){
   v:/*Globals_State*/(
      (
         s
      )when iterations_left<=1 else(
         s
      )when s.finished else(
         v(Globals_1(v(Globals_Core(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Globals_2::struct(s:/*Globals_State*/typeid,iterations_left:uint){
   v:/*Globals_State*/(
      (
         s
      )when iterations_left<=2 else(
         s
      )when s.finished else(
         v(Globals_2(v(Globals_1(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Globals_3::struct(s:/*Globals_State*/typeid,iterations_left:uint){
   v:/*Globals_State*/(
      (
         s
      )when iterations_left<=3 else(
         s
      )when s.finished else(
         v(Globals_3(v(Globals_2(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Globals_4::struct(s:/*Globals_State*/typeid,iterations_left:uint){
   v:/*Globals_State*/(
      (
         s
      )when iterations_left<=4 else(
         s
      )when s.finished else(
         v(Globals_4(v(Globals_3(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}

Calculator_Node_Type::enum{
   Invalid,
   Multiplication,
   Division,
   Addition,
   Subtraction,
   Number
}

Calculator_Node::struct(type:Calculator_Node_Type){}

Calculator_Node_Invalid::struct(type:Calculator_Node_Type){}

Calculator_Node_Multiplication::struct(type:Calculator_Node_Type,ml,mr:typeid){}

Calculator_Node_Division::struct(type:Calculator_Node_Type,dl,dr:typeid){}

Calculator_Node_Addition::struct(type:Calculator_Node_Type,al,ar:typeid){}

Calculator_Node_Subtraction::struct(type:Calculator_Node_Type,sl,sr:typeid){}

Calculator_Node_Number::struct(type:Calculator_Node_Type,n:f64,ok:bool){}

//NOTE(sobex) Division needs the f64 cast https://github.com/odin-lang/Odin/issues/6866
Calculator_Calculator::struct(node:/*Calculator_Node*/typeid){
   v:/*Calculator_Node_Number*/(
      (
         /*TODO do we need invalid?*/Calculator_Node_Number(.Number,0,false)
      )when node.type==.Invalid else(
         Calculator_Node_Number(.Number,v(Calculator_Calculator(node.ml),"v").n*v(Calculator_Calculator(node.mr),"v").n,true)
      )when node.type==.Multiplication else(
         Calculator_Node_Number(.Number,f64(v(Calculator_Calculator(node.dl),"v").n)/v(Calculator_Calculator(node.dr),"v").n,true)
      )when node.type==.Division else(
         Calculator_Node_Number(.Number,v(Calculator_Calculator(node.al),"v").n+v(Calculator_Calculator(node.ar),"v").n,true)
      )when node.type==.Addition else(
         Calculator_Node_Number(.Number,v(Calculator_Calculator(node.sl),"v").n-v(Calculator_Calculator(node.sr),"v").n,true)
      )when node.type==.Subtraction else(
         node
      )
   )
}

Calculator_Parser_Digits::[?]f64{0.1,0.01,0.001,0.0001,0.0001,0.00001,0.000001,0.0000001,0.00000001}

Calculator_Parser_State::struct(expression:string,number:uint,seen_dot:bool,float:uint){}

Calculator_Parser::struct(expression:string,number:uint,seen_dot:bool,float:uint,float_digits:uint,result:typeid){
   v:/*Calculator_Node*/(
      (
         /*TODO finish number and add to left*/Calculator_Node_Number(.Number,0,false)
      )when len(expression)==0 else(
         /*TODO add digit to number*/Calculator_Node_Number(.Number,0,false)
      )when !seen_dot&&(expression[0]=='0'||expression[0]=='1'||expression[0]=='2'||expression[0]=='3'||expression[0]=='4'||expression[0]=='5'||expression[0]=='6'||expression[0]=='7'||expression[0]=='8'||expression[0]=='9') else(
         /*TODO add digit to float maybe add a fraction that i/=10 each step*/Calculator_Node_Number(.Number,0,false)
      )when seen_dot&&(expression[0]=='0'||expression[0]=='1'||expression[0]=='2'||expression[0]=='3'||expression[0]=='4'||expression[0]=='5'||expression[0]=='6'||expression[0]=='7'||expression[0]=='8'||expression[0]=='9') else(
         /*TODO set seen_dot*/Calculator_Node_Number(.Number,0,false)
      )when !seen_dot&&expression[0]=='.' else(
         /*TODO error*/Calculator_Node_Number(.Number,0,false)
      )when seen_dot&&expression[0]=='.' else(
         /*TODO finish number and add to left*/Calculator_Node_Number(.Number,0,false)
      )when expression[0]=='*' else(
         /*TODO finish number and add to left*/Calculator_Node_Number(.Number,0,false)
      )when expression[0]=='/' else(
         /*TODO finish number and add to left if its type isnt mul or div*/Calculator_Node_Number(.Number,0,false)
      )when expression[0]=='+' else(
         /*TODO finish number and add to left if its type isnt mul or div*/Calculator_Node_Number(.Number,0,false)
      )when expression[0]=='-' else(
         /*TODO skip whitespace and others*/Calculator_Node_Number(.Number,0,false)
      )
   )
}

Calculator::struct(expression:string){
   v:v(Calculator_Calculator(v(Calculator_Parser(expression,0,false,0,0,Calculator_Node_Invalid(.Invalid)),"v")),"v")
}

Assembly::struct(
   asm_string:string,
   constraints_string:string
){}

_Assembler::struct(count:u8,expression:string,registers:string,stack:string,asm_string:string,constraints_string:string,clobbers:bool){
   v:/*Assembly*/(
      (
         Assembly(asm_string+"mov $0, "+registers[3*stack[0]:3*(stack[0]+1)],constraints_string when !clobbers else constraints_string+",~{cc}")
      )when len(expression)==0 else(
         v(_Assembler(count+1,expression[1:],registers,RUNES[count]+stack[2:],asm_string+"mov "+registers[3*count:3*(count+1)]+", "+registers[3*stack[0]:3*(stack[0]+1)]+"\nimul "+registers[3*count:3*(count+1)]+", "+registers[3*stack[1]:3*(stack[1]+1)]+"\n",constraints_string+",~{"+registers[3*count:3*(count+1)]+"}",true),"v")
      )when expression[0]=='*' else(
         v(_Assembler(count+1,expression[1:],registers,RUNES[count]+stack[2:],asm_string+"lea "+registers[3*count:3*(count+1)]+", ["+registers[3*stack[0]:3*(stack[0]+1)]+" + "+registers[3*stack[1]:3*(stack[1]+1)]+"]\n",constraints_string+",~{"+registers[3*count:3*(count+1)]+"}",clobbers),"v")
      )when expression[0]=='+' else(
         v(_Assembler(count+1,expression[1:],registers,RUNES[count]+stack[2:],asm_string+"mov "+registers[3*count:3*(count+1)]+", "+registers[3*stack[0]:3*(stack[0]+1)]+"\nsub "+registers[3*count:3*(count+1)]+", "+registers[3*stack[1]:3*(stack[1]+1)]+"\n",constraints_string+",~{"+registers[3*count:3*(count+1)]+"}",clobbers),"v")
      )when expression[0]=='-' else(
         v(_Assembler(count,expression[1:],registers,RUNES[expression[0]-'0']+stack,asm_string,constraints_string,clobbers),"v")
      )when expression[0]=='0'||expression[0]=='1'||expression[0]=='2'||expression[0]=='3'||expression[0]=='4'||expression[0]=='5'||expression[0]=='6'||expression[0]=='7'||expression[0]=='8'||expression[0]=='9' else(
         v(_Assembler(count,expression[1:],registers,stack,asm_string,constraints_string,clobbers),"v")
      )
   )
}

Assembler_Scratch::"r8 r9 r10r11r12r13r14r15"

Assembler::struct(count:uint,expression:string){
   v:/*Assembly*/(
      (
         v(_Assembler(1,expression,"$0 "+Assembler_Scratch,"","","=r",false),"v")
      )when count==0 else(
         v(_Assembler(2,expression,"$0 $1 "+Assembler_Scratch,"","","=r,r",false),"v")
      )when count==1 else(
         v(_Assembler(3,expression,"$0 $1 $2 "+Assembler_Scratch,"","","=r,r,r",false),"v")
      )when count==2 else(
         v(_Assembler(4,expression,"$0 $1 $2 $3 "+Assembler_Scratch,"","","=r,r,r,r",false),"v")
      )when count==3 else(
         v(_Assembler(5,expression,"$0 $1 $2 $3 $4 "+Assembler_Scratch,"","","=r,r,r,r,r",false),"v")
      )when count==4 else(
         #panic("more than 4 inputs not yet supported, but feel free to add the single line you need here")
      )
   )
}

_MAGEBILL::"\e[0m\n"+
           "\e[40m           \e[44m        \e[40m           \e[0m\n"+
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

_MAGEBILLASCII::"\e[0m\n"+
                "\e[30m           \e[34m,-----..\e[30m           \e[0m\n"+
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
   #panic(_MAGEBILL)
}else when #config(MAGEBILLASCII,false){
   #panic(_MAGEBILLASCII)
}
