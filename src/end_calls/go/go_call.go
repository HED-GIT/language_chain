package main


import "C" // has to be seperate from the others

import (
	"fmt"
)

//export call_go
func call_go(str *C.char) {
    fmt.Println(C.GoString(str));
}

func main(){}