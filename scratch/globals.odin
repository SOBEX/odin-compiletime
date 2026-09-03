package odin_compiletime_scratch

import comp ".."

Globals_State::struct(remaining:string,depth:uint,result:string,steps:uint,finished:bool){}

//this is a bad implementation and doesnt check if a curly brace is in a comment or string, but shows off iterative state machines and how to avoid hitting the recursion limit
Globals_Core::struct(s:/*TODO inline this struct Globals_State*/typeid,iterations_left:uint){
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
            comp.v(Globals_Core(Globals_State(s.remaining[1:],s.depth+1,s.result when s.depth!=0 else (s.result+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[0]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               comp.v(Globals_Core(Globals_State(s.remaining[1:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[0]=='}' else(
            comp.v(Globals_Core(Globals_State(s.remaining[2:],s.depth+1,s.result when s.depth!=0 else (s.result+s.remaining[:1]+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[1]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               comp.v(Globals_Core(Globals_State(s.remaining[2:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[1]=='}' else(
            comp.v(Globals_Core(Globals_State(s.remaining[3:],s.depth+1,s.result when s.depth!=0 else (s.result+s.remaining[:2]+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[2]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               comp.v(Globals_Core(Globals_State(s.remaining[3:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[2]=='}' else(
            comp.v(Globals_Core(Globals_State(s.remaining[4:],s.depth+1,s.result when s.depth!=0 else (s.result+s.remaining[:3]+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[3]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               comp.v(Globals_Core(Globals_State(s.remaining[4:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[3]=='}' else(
            comp.v(Globals_Core(Globals_State(s.remaining[4:],s.depth,s.result when s.depth!=0 else (s.result+s.remaining[:4]),s.steps+1,s.finished),iterations_left-1),"v")
         )
      //NOTE(sobex) compiletime `&&` seems to not short circuit so `when len(s.remaining)>3&&s.remaining[3]=='X'` fails
      )when len(s.remaining)>=4 else(
         (
            comp.v(Globals_Core(Globals_State(s.remaining[1:],s.depth+1,s.result when s.depth!=0 else (s.result+"{"),s.steps+1,s.finished),iterations_left-1),"v")
         )when s.remaining[0]=='{' else(
            (
               Globals_State(s.remaining,s.depth,s.result+"<End of Scope reached outside a scope>",s.steps+1,true)
            )when s.depth==0 else(
               comp.v(Globals_Core(Globals_State(s.remaining[1:],s.depth-1,s.result when s.depth!=1 else (s.result+"...}"),s.steps+1,s.finished),iterations_left-1),"v")
            )
         )when s.remaining[0]=='}' else(
            comp.v(Globals_Core(Globals_State(s.remaining[1:],s.depth,s.result when s.depth!=0 else (s.result+s.remaining[:1]),s.steps+1,s.finished),iterations_left-1),"v")
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
         comp.v(Globals_1(comp.v(Globals_Core(s,iterations_left-1),"v"),iterations_left-1),"v")
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
         comp.v(Globals_2(comp.v(Globals_1(s,iterations_left-1),"v"),iterations_left-1),"v")
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
         comp.v(Globals_3(comp.v(Globals_2(s,iterations_left-1),"v"),iterations_left-1),"v")
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
         comp.v(Globals_4(comp.v(Globals_3(s,iterations_left-1),"v"),iterations_left-1),"v")
      )
   )
}
