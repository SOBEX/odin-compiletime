package odin_compiletime

import comp "."

COUNTER_0::bool(#config(COUNTER_0,false))
COUNTER_1::bool(#config(COUNTER_1,false))
COUNTER_2::bool(#config(COUNTER_2,false))
COUNTER_3::bool(#config(COUNTER_3,false))
COUNTER_4::bool(#config(COUNTER_4,false))

COUNTER::COUNTER_0||COUNTER_1||COUNTER_2||COUNTER_3||COUNTER_4

when COUNTER{
   Counter_State::struct(v:uint,finished:bool,real,fake_iteration_up,fake_iteration_down,fake_finished:uint){}
   Counter_0::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=0 else(
            Counter_State(s.v,true,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.v==0 else(
            comp.v(Counter_0(Counter_State(s.v-1,s.finished,s.real+1,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished),iterations_left-1),"v")
         )
      )
   }
   Counter_1::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=1 else(
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_1(comp.v(Counter_0(
               Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished),
            iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
   Counter_2::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=2 else(
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_2(comp.v(Counter_1(
               Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished),
            iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
   Counter_3::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=3 else(
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_3(comp.v(Counter_2(
               Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished),
            iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
   Counter_4::struct(s:/*Counter_State*/typeid,iterations_left:uint){
      v:/*Counter_State*/(
         (
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up+1,s.fake_iteration_down,s.fake_finished)
         )when iterations_left<=4 else(
            Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down,s.fake_finished+1)
         )when s.finished else(
            comp.v(Counter_4(comp.v(Counter_3(
               Counter_State(s.v,s.finished,s.real,s.fake_iteration_up,s.fake_iteration_down+1,s.fake_finished),
            iterations_left-1),"v"),iterations_left-1),"v")
         )
      )
   }
}

when COUNTER_0{
   result_0::Counter_0(Counter_State(1_000_000,false,0,0,0,0),262)
   #panic(comp.n(comp.v(result_0,"v")))
}

when COUNTER_1{
   result_1::Counter_1(Counter_State(1_000_000,false,0,0,0,0),262)
   #panic(comp.n(comp.v(result_1,"v")))
}

when COUNTER_2{
   result_2::Counter_2(Counter_State(1_000_000,false,0,0,0,0),261)
   #panic(comp.n(comp.v(result_2,"v")))
}

when COUNTER_3{
   result_3::Counter_3(Counter_State(1_000_000,false,0,0,0,0),260)
   #panic(comp.n(comp.v(result_3,"v")))
}

when COUNTER_4{
   result_4::Counter_4(Counter_State(1_000_000,false,0,0,0,0),259)
   #panic(comp.n(comp.v(result_4,"v")))
}

//Measure-Command { odin build . -no-entry-point -define:COUNTER_N=true | Out-Default }

/* github release build with regular stacksize (2026-06)
   - COUNTER_0:  29   70ms odin_compiletime::Counter_State(v:$$999971,finished:$$false,real:$$   29,fake_iteration_up:$$    1,fake_iteration_down:$$    0,fake_finished:$$0)
   - COUNTER_1:  29  100ms odin_compiletime::Counter_State(v:$$999594,finished:$$false,real:$$  406,fake_iteration_up:$$   29,fake_iteration_down:$$   28,fake_finished:$$0)
   - COUNTER_2:  28 4000ms odin_compiletime::Counter_State(v:$$996724,finished:$$false,real:$$ 3276,fake_iteration_up:$$  378,fake_iteration_down:$$  377,fake_finished:$$0)
   - COUNTER_3:  27  400 s odin_compiletime::Counter_State(v:$$982450,finished:$$false,real:$$17550,fake_iteration_up:$$ 2925,fake_iteration_down:$$ 2924,fake_finished:$$0)
   - COUNTER_4:  26  110 m odin_compiletime::Counter_State(v:$$934220,finished:$$false,real:$$65780,fake_iteration_up:$$14950,fake_iteration_down:$$14949,fake_finished:$$0)
*/

/* native release build with `/STACK:8388608,1048576`
   - COUNTER_0: 262   80ms odin_compiletime::Counter_State(v:$$999738,finished:$$false,real:$$  262,fake_iteration_up:$$    1,fake_iteration_down:$$    0,fake_finished:$$0)
   - COUNTER_1: 262   13 m odin_compiletime::Counter_State(v:$$965809,finished:$$false,real:$$34191,fake_iteration_up:$$  262,fake_iteration_down:$$  261,fake_finished:$$0)
   - COUNTER_2: 261
   - COUNTER_3: 260
   - COUNTER_4: 259
*/
