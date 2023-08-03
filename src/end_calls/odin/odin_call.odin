package odin_call

import "core:fmt"
import "core:runtime"

@export
call_odin :: proc "c"(x: cstring) {
	context = runtime.default_context()

    fmt.println(x)
}
