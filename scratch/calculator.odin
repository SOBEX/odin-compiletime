package odin_compiletime_scratch

import comp ".."

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

Calculator_Calculator::struct(node:/*Calculator_Node*/typeid){
   v:/*Calculator_Node_Number*/(
      (
         /*TODO do we need invalid?*/Calculator_Node_Number(.Number,0,false)
      )when node.type==.Invalid else(
         Calculator_Node_Number(.Number,comp.v(Calculator_Calculator(node.ml),"v").n*comp.v(Calculator_Calculator(node.mr),"v").n,true)
      )when node.type==.Multiplication else(
         Calculator_Node_Number(.Number,comp.v(Calculator_Calculator(node.dl),"v").n/comp.v(Calculator_Calculator(node.dr),"v").n,true)
      )when node.type==.Division else(
         Calculator_Node_Number(.Number,comp.v(Calculator_Calculator(node.al),"v").n+comp.v(Calculator_Calculator(node.ar),"v").n,true)
      )when node.type==.Addition else(
         Calculator_Node_Number(.Number,comp.v(Calculator_Calculator(node.sl),"v").n-comp.v(Calculator_Calculator(node.sr),"v").n,true)
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
   v:comp.v(Calculator_Calculator(comp.v(Calculator_Parser(expression,0,false,0,0,Calculator_Node_Invalid(.Invalid)),"v")),"v")
}
