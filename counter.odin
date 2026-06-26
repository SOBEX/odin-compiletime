package odin_compiletime

import comp "."
import "core:fmt"

COUNTER_0::bool(#config(COUNTER_0,false))
COUNTER_1::bool(#config(COUNTER_1,false))
COUNTER_2::bool(#config(COUNTER_2,false))
COUNTER_3::bool(#config(COUNTER_3,false))
COUNTER_4::bool(#config(COUNTER_4,false))
COUNTER_PROC::uint(#config(COUNTER_PROC,0))

COUNTER::COUNTER_0||COUNTER_1||COUNTER_2||COUNTER_3||COUNTER_4||(COUNTER_PROC>0)

when COUNTER{
   Counter_State::struct(value:uint,finished:bool,real,fake_iteration_up,fake_iteration_down,fake_finished:uint){}
   Counter_0::struct(value:uint,finished:bool,real,fake_iteration_up,fake_iteration_down,fake_finished:uint,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(value,finished,real,fake_iteration_up+1,fake_iteration_down,fake_finished)
         )when iterations_left<=0 else(
            Counter_State(value,true,real,fake_iteration_up,fake_iteration_down,fake_finished+1)
         )when value==0 else(
            comp.v(Counter_0(value-1,finished,real+1,fake_iteration_up,fake_iteration_down,fake_finished,iterations_left-1),"v")
         )
      )
   }
   Counter_1::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=1 else(
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_1(comp.v(Counter_0(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished,iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
   Counter_2::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=2 else(
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_2(comp.v(Counter_1(
               Counter_State(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished),
            iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
   Counter_3::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=3 else(
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_3(comp.v(Counter_2(
               Counter_State(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished),
            iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
   Counter_4::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=4 else(
            Counter_State(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_4(comp.v(Counter_3(
               Counter_State(s.value,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished),
            iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
   //Counter_Proc::proc($value:uint,$finished:bool,$real,$fake_iteration_up,$fake_iteration_down,$fake_finished:uint,$iterations_left:uint)->(
   //   v:(/*Counter_State*/(
   //      Counter_State(value,finished,real,fake_iteration_up+1,fake_iteration_down,fake_finished)
   //   )when iterations_left<=0 else(
   //      Counter_State(value,true,real,fake_iteration_up,fake_iteration_down,fake_finished+1)
   //   )when value==0 else(
   //      comp.r(comp.p(Counter_Proc(value-1,finished,real+1,fake_iteration_up,fake_iteration_down,fake_finished,iterations_left-1)),0)
   //   ))
   //)
   Counter_Result::struct{value:uint,finished:bool,real,fake_iteration_up,fake_iteration_down,fake_finished:uint}
   Counter_Proc::proc($value:uint,$finished:bool,$real,$fake_iteration_up,$fake_iteration_down,$fake_finished:uint,$iterations_left:uint)->Counter_Result{
      when iterations_left<=0{
         return Counter_Result{value,finished,real,fake_iteration_up+1,fake_iteration_down,fake_finished}
      }else when value==0{
         return Counter_Result{value,true,real,fake_iteration_up,fake_iteration_down,fake_finished+1}
      }else{
         //NOTE(sobex) if you force_inline this will stack overflow llvm, if you dont force_inline this will stack overflow at runtime
         return #force_inline Counter_Proc(value-1,finished,real+1,fake_iteration_up,fake_iteration_down,fake_finished,iterations_left-1)
      }
   }
}

when COUNTER_0{
   result_0::Counter_0(1_000_000,false,0,0,0,0,29)
   #panic(comp.n(comp.v(result_0,"v")))
}

when COUNTER_1{
   result_1::Counter_1(Counter_State(1_000_000,false,0,0,0,0),29)
   #panic(comp.n(comp.v(result_1,"v")))
}

when COUNTER_2{
   result_2::Counter_2(Counter_State(1_000_000,false,0,0,0,0),28)
   #panic(comp.n(comp.v(result_2,"v")))
}

when COUNTER_3{
   result_3::Counter_3(Counter_State(1_000_000,false,0,0,0,0),27)
   #panic(comp.n(comp.v(result_3,"v")))
}

when COUNTER_4{
   result_4::Counter_4(Counter_State(1_000_000,false,0,0,0,0),26)
   #panic(comp.n(comp.v(result_4,"v")))
}

when COUNTER_PROC>0{
   //result_proc::comp.p(Counter_Proc(1_000_000,false,0,0,0,0,29))
   //#panic(comp.n(comp.r(result_proc,0)))
   main::proc(){
      result_proc:=Counter_Proc(1_000_000,false,0,0,0,0,COUNTER_PROC)
      fmt.printfln("%w",result_proc)
   }
}

//Measure-Command { odin build . -no-entry-point -define:COUNTER_N=true | Out-Default }
//Measure-Command { odin build . -define:COUNTER_PROC=N | Out-Default }; .\odin-compiletime.exe

/* github release build with regular stacksize (2026-06)
   - COUNTER_0:       29   60ms odin_compiletime::Counter_State(value:$$999971,finished:$$false,real:$$   29,fake_iteration_up:$$    1,fake_iteration_down:$$    0,fake_finished:$$0)
   - COUNTER_1:       29   90ms odin_compiletime::Counter_State(value:$$999594,finished:$$false,real:$$  406,fake_iteration_up:$$   29,fake_iteration_down:$$   28,fake_finished:$$0)
   - COUNTER_2:       28  900ms odin_compiletime::Counter_State(value:$$996724,finished:$$false,real:$$ 3276,fake_iteration_up:$$  378,fake_iteration_down:$$  377,fake_finished:$$0)
   - COUNTER_3:       27   100s odin_compiletime::Counter_State(value:$$982450,finished:$$false,real:$$17550,fake_iteration_up:$$ 2925,fake_iteration_down:$$ 2924,fake_finished:$$0)
   - COUNTER_4:       26    36m odin_compiletime::Counter_State(value:$$934220,finished:$$false,real:$$65780,fake_iteration_up:$$14950,fake_iteration_down:$$14949,fake_finished:$$0)
   - COUNTER_PROC:   406  400ms                  Counter_Result{value = 999594,finished = false,real =   406,fake_iteration_up =     1,fake_iteration_down =     0,fake_finished = 0}
   - COUNTER_PROC:  3276 1900ms                  Counter_Result{value = 996724,finished = false,real =  3276,fake_iteration_up =     1,fake_iteration_down =     0,fake_finished = 0}
   - COUNTER_PROC: 17550    80s                  Counter_Result{value = 982450,finished = false,real = 17550,fake_iteration_up =     1,fake_iteration_down =     0,fake_finished = 0}
   - COUNTER_PROC: 65780    27m                  Counter_Result{value = 934220,finished = false,real = 65780,fake_iteration_up =     1,fake_iteration_down =     0,fake_finished = 0}
*/

/* native release build with `/STACK:8388608,1048576`
   - COUNTER_0: 262   60ms odin_compiletime::Counter_State(value:$$999738,finished:$$false,real:$$  262,fake_iteration_up:$$    1,fake_iteration_down:$$    0,fake_finished:$$0)
   - COUNTER_1: 262  4m30s odin_compiletime::Counter_State(value:$$965809,finished:$$false,real:$$34191,fake_iteration_up:$$  262,fake_iteration_down:$$  261,fake_finished:$$0)
   - COUNTER_2: 261
   - COUNTER_3: 260
   - COUNTER_4: 259
*/
