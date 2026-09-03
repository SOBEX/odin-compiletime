package odin_compiletime_scratch

import comp ".."

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
         comp.v(Fibonacci_Matrix_2x2_Pow(comp.v(Fibonacci_Matrix_2x2_Mul(m,m),"v"),exp/2),"v")
      )when exp%2==0 else(
         comp.v(Fibonacci_Matrix_2x2_Mul(comp.v(Fibonacci_Matrix_2x2_Pow(m,exp/2),"v"),comp.v(Fibonacci_Matrix_2x2_Pow(m,(exp+1)/2),"v")),"v")
      )
   )
}

Fibonacci_Base::Fibonacci_Matrix_2x2({{1,1},{1,0}})

Fibonacci::struct(i:uint){
   v:comp.U128(comp.v(Fibonacci_Matrix_2x2_Pow(Fibonacci_Base,i),"v").v[0][1])
}
