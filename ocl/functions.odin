package compiletime_ocl

import "core:fmt"
import "core:math"
import "core:math/rand"

_Function::#type proc(ctx:^Context,args:_Args)->(result:f64,ok:bool)

CUSTOM_FUNCTION_PREFIX::"custom_"

_do_call::#force_inline proc(ctx:^Context,$function:string,args:_Args)->(result:f64,ok:bool){
   when len(function)==0{
      invalid::true
   }else{
      when function[:min(len(function),len(CUSTOM_FUNCTION_PREFIX))]==CUSTOM_FUNCTION_PREFIX{
         export_name::function[7:]
         foreign _{
            @(link_name=export_name)custom:_Function:proc"odin"(ctx:^Context,args:_Args)->(result:f64,ok:bool) ---
         }
         //NOTE(sobex) this will not neccessarily inline on `-o:minimal` but does on anything higher
         #force_inline custom(ctx,args) or_return
      }else when function[0]=='a'{
         when function=="abs"{
            result=#force_inline __abs(ctx,args) or_return
         }else when function=="add"{
            result=#force_inline __add(ctx,args) or_return
         }else when function=="and"{
            result=#force_inline __and(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='b'{
         invalid::true
      }else when function[0]=='c'{
         when function=="ceil"{
            result=#force_inline __ceil(ctx,args) or_return
         }else when function=="clamp"{
            result=#force_inline __clamp(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='d'{
         when function=="div"{
            result=#force_inline __div(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='e'{
         when function=="eq"{
            result=#force_inline __eq(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='f'{
         when function=="floor"{
            result=#force_inline __floor(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='g'{
         when function=="gt"{
            result=#force_inline __gt(ctx,args) or_return
         }else when function=="gte"{
            result=#force_inline __gte(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='h'{
         invalid::true
      }else when function[0]=='i'{
         when function=="if"{
            result=#force_inline __if(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='j'{
         invalid::true
      }else when function[0]=='k'{
         invalid::true
      }else when function[0]=='l'{
         when function=="lerp"{
            result=#force_inline __lerp(ctx,args) or_return
         }else when function=="lt"{
            result=#force_inline __lt(ctx,args) or_return
         }else when function=="lte"{
            result=#force_inline __lte(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='m'{
         when function=="max"{
            result=#force_inline __max(ctx,args) or_return
         }else when function=="min"{
            result=#force_inline __min(ctx,args) or_return
         }else when function=="mod"{
            result=#force_inline __mod(ctx,args) or_return
         }else when function=="mul"{
            result=#force_inline __mul(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='n'{
         when function=="neg"{
            result=#force_inline __neg(ctx,args) or_return
         }else when function=="neq"{
            result=#force_inline __neq(ctx,args) or_return
         }else when function=="not"{
            result=#force_inline __not(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='o'{
         when function=="or"{
            result=#force_inline __or(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='p'{
         when function=="print"{
            result=#force_inline __print(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='q'{
         invalid::true
      }else when function[0]=='r'{
         when function=="rand"{
            result=#force_inline __rand(ctx,args) or_return
         }else when function=="round"{
            result=#force_inline __round(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='s'{
         when function=="sub"{
            result=#force_inline __sub(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='t'{
         invalid::true
      }else when function[0]=='u'{
         invalid::true
      }else when function[0]=='v'{
         invalid::true
      }else when function[0]=='w'{
         invalid::true
      }else when function[0]=='x'{
         when function=="xor"{
            result=#force_inline __xor(ctx,args) or_return
         }else{
            invalid::true
         }
      }else when function[0]=='y'{
         invalid::true
      }else when function[0]=='z'{
         invalid::true
      }else{
         invalid::true
      }
   }
   when #defined(invalid){
      #panic("function \""+function+"\" not recognized")
   }
   return result,true
}

__add:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   //TODO maybe improve error handling wrong argc
   (len(args)==2) or_return
   result=args[0]+args[1]
   return result,true
}

__sub:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]-args[1]
   return result,true
}

__mul:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]*args[1]
   return result,true
}

__div:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]/args[1]
   return result,true
}

__mod:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=math.mod(args[0],args[1])
   return result,true
}

__neg:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==1) or_return
   result=-args[0]
   return result,true
}

__abs:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==1) or_return
   result=abs(args[0])
   return result,true
}

__if:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==3) or_return
   result=args[0]!=0?args[1]:args[2]
   return result,true
}

__eq:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]==args[1]?1:0
   return result,true
}

__neq:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]!=args[1]?1:0
   return result,true
}

__lt:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]<args[1]?1:0
   return result,true
}

__lte:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]<=args[1]?1:0
   return result,true
}

__gt:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]>args[1]?1:0
   return result,true
}

__gte:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]>=args[1]?1:0
   return result,true
}

__not:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==1) or_return
   result=args[0]==0?1:0
   return result,true
}

__and:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]!=0&&args[1]!=0?1:0
   return result,true
}

__or:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=args[0]!=0||args[1]!=0?1:0
   return result,true
}

__xor:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==2) or_return
   result=(args[0]!=0)!=(args[1]!=0)?1:0
   return result,true
}

__min:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   result=max(f64)
   for arg in args{
      if arg<result{
         result=arg
      }
   }
   return result,true
}

__max:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   result=min(f64)
   for arg in args{
      if arg>result{
         result=arg
      }
   }
   return result,true
}

__clamp:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==3) or_return
   result=clamp(args[0],args[1],args[2])
   return result,true
}

__lerp:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==3) or_return
   result=args[0]+args[2]*(args[1]-args[0])
   return result,true
}

__floor:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==1) or_return
   result=math.floor(args[0])
   return result,true
}

__ceil:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==1) or_return
   result=math.ceil(args[0])
   return result,true
}

__round:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   (len(args)==1) or_return
   result=math.round(args[0])
   return result,true
}

__rand:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   result=rand.float64()
   return result,true
}

__print:_Function:#force_inline proc(ctx:^Context,args:_Args)->(result:f64,ok:bool){
   if len(args)==1{
      result=f64(fmt.println(args[0]))
   }else{
      result=f64(fmt.println(args))
   }
   return result,true
}
