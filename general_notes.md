Generally less deep type recursion is better but it does not matter as much with string buffers.

If you do need deep recursion do avoid fixed size arrays where possible as they bloat type checking immensely.

And if you can, prefer divide and conquer / recursive splitting algorithms over iterative algorithms; there is a hard limit on how deep you can go before the compiler panics.

---

If you have a recursive algorithm like `Fibonacci(I)=Fibonacci(I-2)+Fibonacci(I-1)` always evaluate the faster descending part first or the compiler may panic.

---

The old method for compiletime calculations used to be
```odin
   pow2::struct(exp:uint){
      _:[1<<exp]u8
   }
   result:=size_of(pow2(28))
```
but this was limited due to
```
Error: Array count too large, 268435456
```

The new method is
```odin
   pow2::struct(exp:uint){
      v:comp.U128(1<<exp)
   }
   result:=comp.v(pow2(127),"v").v
```
which gives you access to the full range of 128-bit integers and any other builtin type like floats and strings, as well as most structs.

---

Compiletime calculations cannot be wrapped in procedures so these how_to procedures are presented as code snippets to copy.
