package compiletime_ocl_test

import ocl ".."

import "core:debug/trace"
import "core:fmt"

@export myprint:ocl._Function:#force_inline proc(ctx:^ocl.Context,args:ocl._Args)->(result:f64,ok:bool){
   fmt.println("Hey from custom injected function, my args are",args,"and also my stacktrace:")
   capture:=trace.capture()
   locations,_:=trace.resolve(capture)
   trace.print(locations)
   trace.locations_destroy(locations)
   return 0,true
}

main::proc(){
   ctx,ok_1:=ocl.eval(#load("main.ocl"))
   ok_2:=ocl.run(&ctx,"custom_myprint(a)")
   fmt.println(ok_1,ok_2,ctx)
}
