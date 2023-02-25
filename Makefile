LIBDIR 				:= build/libs
OBJECTDIR 			:= build/objects
HEADERDIR 			:= build/headers
ZIGCACHEDIR 		:= build/zig
BUILDDIR			:= $(LIBDIR) $(OBJECTDIR) $(HEADERDIR) $(ZIGCACHEDIR)

C_CALLDIR 			:= src/end_calls
C_CHAINDIR 			:= src/mid_calls


CALL_LIBS 			:= $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so $(LIBDIR)/libswift_call.so $(LIBDIR)/libpascal_call.so $(LIBDIR)/libfortran_call.so
CHAIN_LIBS 			:= $(LIBDIR)/libc_chain.so $(LIBDIR)/libcpp_chain.so $(LIBDIR)/libd_chain.so $(LIBDIR)/libgo_chain.so $(LIBDIR)/libnim_chain.so $(LIBDIR)/liboc_chain.so $(LIBDIR)/librust_chain.so $(LIBDIR)/libzig_chain.so $(LIBDIR)/libswift_chain.so $(LIBDIR)/libpascal_chain.so $(LIBDIR)/libfortran_chain.so
LIBS 				:= $(CALL_LIBS) $(CHAIN_LIBS)

CALL_LIBS_FLAGS 	:= -l:libc_call.so -l:libcpp_call.so -l:librust_call.so -l:libgo_call.so -l:libd_call.so -l:libzig_call.so -l:libnim_call.so -l:liboc_call.so -l:libswift_call.so -l:libpascal_call.so -l:libfortran_call.so
CHAIN_LIBS_FLAGS 	:= -l:libc_chain.so -l:libcpp_chain.so -l:libd_chain.so -l:libgo_chain.so -l:libnim_chain.so -l:liboc_chain.so -l:librust_chain.so -l:libzig_chain.so -l:libswift_chain.so -l:libpascal_chain.so -l:libfortran_chain.so 
LIBS_FLAGS 			:= $(CALL_LIBS_FLAGS) $(CHAIN_LIBS_FLAGS) -lgfortran

CALL_HEADERS		:= $(HEADERDIR)/c_call.h $(HEADERDIR)/cpp_call.h $(HEADERDIR)/rust_call.h $(HEADERDIR)/go_call.h $(HEADERDIR)/zig_call.h $(HEADERDIR)/d_call.h $(HEADERDIR)/nim_call.h $(HEADERDIR)/oc_call.h $(HEADERDIR)/swift_call.h $(HEADERDIR)/pascal_call.h $(HEADERDIR)/fortran_call.h
CHAIN_HEADERS		:= $(HEADERDIR)/c_chain.h $(HEADERDIR)/cpp_chain.h $(HEADERDIR)/rust_chain.h $(HEADERDIR)/go_chain.h $(HEADERDIR)/zig_chain.h $(HEADERDIR)/d_chain.h $(HEADERDIR)/nim_chain.h $(HEADERDIR)/oc_chain.h $(HEADERDIR)/swift_chain.h $(HEADERDIR)/pascal_chain.h $(HEADERDIR)/fortran_chain.h

build: build/main

build/main: src/main.c $(LIBS) $(CHAIN_HEADERS)
	gcc -o build/main src/main.c -I$(HEADERDIR) -L$(LIBDIR) $(LIBS_FLAGS)

$(LIBDIR)/libc_call.so $(HEADERDIR)/c_call.h: $(C_CALLDIR)/c/c_call.c $(C_CALLDIR)/c/c_call.h | directories
	cp $(C_CALLDIR)/c/c_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/c/c_call.c -o $(OBJECTDIR)/c_call.o
	gcc -shared -o $(LIBDIR)/libc_call.so $(OBJECTDIR)/c_call.o

$(LIBDIR)/libswift_call.so $(HEADERDIR)/swift_call.h: $(C_CALLDIR)/swift/swift_call.swift $(C_CALLDIR)/swift/swift_call.h
	cp $(C_CALLDIR)/swift/swift_call.h $(HEADERDIR)/
	swiftc $(C_CALLDIR)/swift/swift_call.swift -emit-module -emit-library -o $(LIBDIR)/libswift_call.so

$(LIBDIR)/libcpp_call.so $(HEADERDIR)/cpp_call.h: $(C_CALLDIR)/c++/cpp_call.cpp $(C_CALLDIR)/c++/cpp_call.hpp	| directories
	cp $(C_CALLDIR)/c++/cpp_call.hpp $(HEADERDIR)/cpp_call.h
	g++ -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/c++/cpp_call.cpp -o $(OBJECTDIR)/cpp_call.o
	g++ -shared -o $(LIBDIR)/libcpp_call.so $(OBJECTDIR)/cpp_call.o

$(LIBDIR)/librust_call.so $(HEADERDIR)/rust_call.h $(HEADERDIR)/rust_call.hpp: $(C_CALLDIR)/rust/rust_call.rs | directories
	cbindgen --output $(HEADERDIR)/rust_call.h --lang c $(C_CALLDIR)/rust/rust_call.rs
	cbindgen --output $(HEADERDIR)/rust_call.hpp --lang c++ $(C_CALLDIR)/rust/rust_call.rs
	rustc --crate-type=cdylib -L $(HEADERDIR)/ $(C_CALLDIR)/rust/rust_call.rs -o $(LIBDIR)/librust_call.so

$(LIBDIR)/libgo_call.so $(HEADERDIR)/go_call.h: $(C_CALLDIR)/go/go_call.go | directories
	go build -o ./$(LIBDIR)/libgo_call.so -buildmode=c-shared $(C_CALLDIR)/go/go_call.go
	mv ./$(LIBDIR)/libgo_call.h ./$(HEADERDIR)/go_call.h

$(LIBDIR)/libzig_call.so $(HEADERDIR)/zig_call.h: $(C_CALLDIR)/zig/zig_call.zig | directories
	zig build-lib --library c --cache-dir $(ZIGCACHEDIR)/call -dynamic -I $(HEADERDIR)/ $(C_CALLDIR)/zig/zig_call.zig -femit-bin=$(LIBDIR)/libzig_call.so
	cp  $(C_CALLDIR)/zig/zig_call.h ./$(HEADERDIR)/zig_call.h

$(LIBDIR)/libd_call.so $(HEADERDIR)/d_call.h: $(C_CALLDIR)/d/d_call.d | directories
	cp $(C_CALLDIR)/d/d_call.h $(HEADERDIR)/
	dmd -c $(C_CALLDIR)/d/d_call.d -fPIC -of$(OBJECTDIR)/d_call.o
	dmd -of$(LIBDIR)/libd_call.so $(OBJECTDIR)/d_call.o -shared

$(LIBDIR)/libnim_call.so $(HEADERDIR)/nim_call.h: $(C_CALLDIR)/nim/nim_call.nim | directories
	nim c --app=lib --noMain --header:nim_call.h -o:$(LIBDIR)/libnim_call.so $(C_CALLDIR)/nim/nim_call.nim 
	cp ~/.cache/nim/nim_call_d/nim_call.h $(HEADERDIR)/nim_call.h

$(LIBDIR)/liboc_call.so $(HEADERDIR)/oc_call.h: $(C_CALLDIR)/objective-c/oc_call.m $(C_CALLDIR)/objective-c/oc_call.h | directories
	cp $(C_CALLDIR)/objective-c/oc_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/objective-c/oc_call.m -o $(OBJECTDIR)/oc_call.o
	gcc -shared -o $(LIBDIR)/liboc_call.so $(OBJECTDIR)/oc_call.o

$(LIBDIR)/libpascal_call.so $(HEADERDIR)/pascal_call.h: $(C_CALLDIR)/pascal/pascal_call.pp $(C_CALLDIR)/pascal/pascal_call.h | directories
	cp $(C_CALLDIR)/pascal/pascal_call.h $(HEADERDIR)/
	fpc $(C_CALLDIR)/pascal/pascal_call.pp -FE$(LIBDIR)/

$(LIBDIR)/libfortran_call.so $(HEADERDIR)/fortran_call.h: $(C_CALLDIR)/fortran/fortran_call.f90 $(C_CALLDIR)/fortran/fortran_call.h | directories
	cp $(C_CALLDIR)/fortran/fortran_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/fortran/fortran_call.f90 -o $(OBJECTDIR)/fortran_call.o
	gcc -shared -o $(LIBDIR)/libfortran_call.so $(OBJECTDIR)/fortran_call.o

$(LIBDIR)/libc_chain.so $(HEADERDIR)/c_chain.h: $(C_CHAINDIR)/c/c_chain.h $(C_CHAINDIR)/c/c_chain.c $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/c/c_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/c/c_chain.c -o $(OBJECTDIR)/c_chain.o
	gcc -shared -o $(LIBDIR)/libc_chain.so $(OBJECTDIR)/c_chain.o

$(LIBDIR)/libcpp_chain.so $(HEADERDIR)/cpp_chain.h: $(C_CHAINDIR)/c++/cpp_chain.hpp $(C_CHAINDIR)/c++/cpp_chain.cpp $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/c++/cpp_chain.hpp $(HEADERDIR)/cpp_chain.h
	g++ -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/c++/cpp_chain.cpp -o $(OBJECTDIR)/cpp_chain.o
	g++ -shared -o $(LIBDIR)/libcpp_chain.so $(OBJECTDIR)/cpp_chain.o

$(LIBDIR)/libd_chain.so $(HEADERDIR)/d_chain.h: $(C_CHAINDIR)/d/d_chain.h $(C_CHAINDIR)/d/d_chain.d $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/d/d_chain.h $(HEADERDIR)/d_chain.h
	dmd -c $(C_CHAINDIR)/d/d_chain.d -fPIC -of$(OBJECTDIR)/d_chain.o
	dmd -of$(LIBDIR)/libd_chain.so $(OBJECTDIR)/d_chain.o -shared

$(LIBDIR)/libgo_chain.so $(HEADERDIR)/go_chain.h: $(C_CHAINDIR)/go/go_chain.go $(CALL_HEADERS) | directories
	C_INCLUDE_PATH="$(PWD)/$(HEADERDIR)" go build -o ./$(LIBDIR)/libgo_chain.so -buildmode=c-shared $(C_CHAINDIR)/go/go_chain.go
	mv ./$(LIBDIR)/libgo_chain.h ./$(HEADERDIR)/go_chain.h

$(LIBDIR)/libnim_chain.so $(HEADERDIR)/nim_chain.h: $(C_CHAINDIR)/nim/nim_chain.nim $(CALL_HEADERS) | directories
	nim c --app=lib --noMain --header:nim_chain.h -o:$(LIBDIR)/libnim_chain.so $(C_CHAINDIR)/nim/nim_chain.nim 
	cp ~/.cache/nim/nim_chain_d/nim_chain.h $(HEADERDIR)/nim_chain.h

$(LIBDIR)/liboc_chain.so $(HEADERDIR)/oc_chain.h: $(C_CHAINDIR)/objective-c/oc_chain.m $(C_CHAINDIR)/objective-c/oc_chain.h $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/objective-c/oc_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/objective-c/oc_chain.m -o $(OBJECTDIR)/oc_chain.o
	gcc -shared -o $(LIBDIR)/liboc_chain.so $(OBJECTDIR)/oc_chain.o

$(LIBDIR)/librust_chain.so $(HEADERDIR)/rust_chain.h: $(C_CHAINDIR)/rust/rust_chain.rs $(CALL_HEADERS)  | directories
	cp $(C_CHAINDIR)/objective-c/oc_chain.h $(HEADERDIR)/
	# bindgen $(HEADERDIR)/c_call.h -o $(HEADERDIR)/c_call.rs
	# bindgen $(HEADERDIR)/cpp_call.h -o $(HEADERDIR)/cpp_call.rs
	# bindgen $(HEADERDIR)/d_call.h -o $(HEADERDIR)/d_call.rs
	# bindgen $(HEADERDIR)/go_call.h -o $(HEADERDIR)/go_call.rs
	# bindgen $(HEADERDIR)/nim_call.h -o $(HEADERDIR)/nim_call.rs
	# bindgen $(HEADERDIR)/oc_call.h -o $(HEADERDIR)/oc_call.rs
	# bindgen $(HEADERDIR)/rust_call.h -o $(HEADERDIR)/rust_call.rs
	# bindgen $(HEADERDIR)/zig_call.h -o $(HEADERDIR)/zig_call.rs
	cbindgen --output $(HEADERDIR)/rust_chain.h --lang c $(C_CHAINDIR)/rust/rust_chain.rs
	rustc --crate-type=cdylib -L $(HEADERDIR)/ $(C_CHAINDIR)/rust/rust_chain.rs -o $(LIBDIR)/librust_chain.so

$(LIBDIR)/libzig_chain.so $(HEADERDIR)/zig_chain.h: $(C_CHAINDIR)/zig/zig_chain.zig $(CALL_HEADERS) | directories
	zig build-lib --library c -dynamic --cache-dir $(ZIGCACHEDIR)/chain -I /usr/include/ -I $(HEADERDIR)/ $(C_CHAINDIR)/zig/zig_chain.zig -femit-bin=$(LIBDIR)/libzig_chain.so
	cp  $(C_CHAINDIR)/zig/zig_chain.h ./$(HEADERDIR)/zig_chain.h

$(LIBDIR)/libswift_chain.so $(HEADERDIR)/swift_chain.h: $(C_CHAINDIR)/swift/swift_chain.swift $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/swift/swift_chain.h $(HEADERDIR)/
	swiftc $(C_CHAINDIR)/swift/swift_chain.swift -emit-module -emit-library -o $(LIBDIR)/libswift_chain.so -import-objc-header $(C_CHAINDIR)/swift/swift_external_header.h

$(LIBDIR)/libpascal_chain.so $(HEADERDIR)/pascal_chain.h: $(C_CHAINDIR)/pascal/pascal_chain.pp $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/pascal/pascal_chain.h $(HEADERDIR)/
	fpc $(C_CHAINDIR)/pascal/pascal_chain.pp -FE$(LIBDIR)/

$(LIBDIR)/libfortran_chain.so $(HEADERDIR)/fortran_chain.h: $(C_CHAINDIR)/fortran/fortran_chain.f90 $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/fortran/fortran_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/fortran/fortran_chain.f90 -o $(OBJECTDIR)/fortran_chain.o
	gcc -shared -o $(LIBDIR)/libfortran_chain.so $(OBJECTDIR)/fortran_chain.o

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(OBJECTDIR):
	mkdir -p $(OBJECTDIR)

$(HEADERDIR):
	mkdir -p $(HEADERDIR)

$(ZIGCACHEDIR):
	mkdir -p $(ZIGCACHEDIR)

directories: $(BUILDDIR)

run: build/main
	LD_LIBRARY_PATH="$(LIBDIR):$LD_LIBRARY_PATH" ./build/main

clean:
	rm -rf build

.PHONY: clean directories run build