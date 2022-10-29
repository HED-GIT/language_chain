LIBDIR 				:= build/libs
OBJECTDIR 			:= build/objects
HEADERDIR 			:= build/headers
C_CALLDIR 			:= src/end_calls
C_CHAINDIR 			:= src/mid_calls

CALL_LIBS 			:= $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so
CHAIN_LIBS 			:= $(LIBDIR)/libc_chain.so $(LIBDIR)/libcpp_chain.so $(LIBDIR)/libd_chain.so $(LIBDIR)/libgo_chain.so $(LIBDIR)/libnim_chain.so $(LIBDIR)/liboc_chain.so $(LIBDIR)/librust_chain.so $(LIBDIR)/libzig_chain.so
LIBS 				:= $(CALL_LIBS) $(CHAIN_LIBS)

CALL_LIBS_FLAGS 	:= -l:libc_call.so -l:libcpp_call.so -l:librust_call.so -l:libgo_call.so -l:libd_call.so -l:libzig_call.so -l:libnim_call.so -l:liboc_call.so 
CHAIN_LIBS_FLAGS 	:= -l:libc_chain.so -l:libcpp_chain.so -l:libd_chain.so -l:libgo_chain.so -l:libnim_chain.so -l:liboc_chain.so -l:librust_chain.so -l:libzig_chain.so
LIBS_FLAGS 			:= $(CALL_LIBS_FLAGS) $(CHAIN_LIBS_FLAGS)

build: build/main

build/main: src/main.c $(CHAIN_LIBS)
	gcc -o build/main src/main.c -I$(HEADERDIR) -L$(LIBDIR) $(LIBS_FLAGS)

$(LIBDIR)/libc_call.so: $(C_CALLDIR)/c/c_call.c $(C_CALLDIR)/c/c_call.h | directories
	cp $(C_CALLDIR)/c/c_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/c/c_call.c -o $(OBJECTDIR)/c_call.o
	gcc -shared -o $(LIBDIR)/libc_call.so $(OBJECTDIR)/c_call.o

$(LIBDIR)/libcpp_call.so: $(C_CALLDIR)/c++/cpp_call.cpp $(C_CALLDIR)/c++/cpp_call.hpp	| directories
	cp $(C_CALLDIR)/c++/cpp_call.hpp $(HEADERDIR)/cpp_call.h
	g++ -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/c++/cpp_call.cpp -o $(OBJECTDIR)/cpp_call.o
	g++ -shared -o $(LIBDIR)/libcpp_call.so $(OBJECTDIR)/cpp_call.o

$(LIBDIR)/librust_call.so: $(C_CALLDIR)/rust/rust_call.rs | directories
	cbindgen --output $(HEADERDIR)/rust_call.h --lang c $(C_CALLDIR)/rust/rust_call.rs
	cbindgen --output $(HEADERDIR)/rust_call.hpp --lang c++ $(C_CALLDIR)/rust/rust_call.rs
	rustc --crate-type=cdylib -L $(HEADERDIR)/ $(C_CALLDIR)/rust/rust_call.rs -o $(LIBDIR)/librust_call.so

$(LIBDIR)/libgo_call.so: $(C_CALLDIR)/go/go_call.go | directories
	go build -o ./$(LIBDIR)/libgo_call.so -buildmode=c-shared $(C_CALLDIR)/go/go_call.go
	mv ./$(LIBDIR)/libgo_call.h ./$(HEADERDIR)/go_call.h

$(LIBDIR)/libzig_call.so: $(C_CALLDIR)/zig/zig_call.zig | directories
	zig build-lib --library c -dynamic -I $(HEADERDIR)/ $(C_CALLDIR)/zig/zig_call.zig -femit-bin=$(LIBDIR)/libzig_call.so
	cp  $(C_CALLDIR)/zig/zig_call.h ./$(HEADERDIR)/zig_call.h

$(LIBDIR)/libd_call.so: $(C_CALLDIR)/d/d_call.d | directories
	cp $(C_CALLDIR)/d/d_call.h $(HEADERDIR)/
	dmd -c $(C_CALLDIR)/d/d_call.d -fPIC -of$(OBJECTDIR)/d_call.o
	dmd -of$(LIBDIR)/libd_call.so $(OBJECTDIR)/d_call.o -shared

$(LIBDIR)/libnim_call.so: $(C_CALLDIR)/nim/nim_call.nim | directories
	nim c --app=lib --noMain --header:nim_call.h -o:$(LIBDIR)/libnim_call.so $(C_CALLDIR)/nim/nim_call.nim 
	cp ~/.cache/nim/nim_call_d/nim_call.h $(HEADERDIR)/nim_call.h

$(LIBDIR)/liboc_call.so: $(C_CALLDIR)/objective-c/oc_call.m $(C_CALLDIR)/objective-c/oc_call.h | directories
	cp $(C_CALLDIR)/objective-c/oc_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/objective-c/oc_call.m -o $(OBJECTDIR)/oc_call.o
	gcc -shared -o $(LIBDIR)/liboc_call.so $(OBJECTDIR)/oc_call.o

$(LIBDIR)/libc_chain.so: $(C_CHAINDIR)/c/c_chain.h $(C_CHAINDIR)/c/c_chain.c $(CALL_LIBS) | directories
	cp $(C_CHAINDIR)/c/c_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/c/c_chain.c -o $(OBJECTDIR)/c_chain.o
	gcc -shared -o $(LIBDIR)/libc_chain.so $(OBJECTDIR)/c_chain.o

$(LIBDIR)/libcpp_chain.so: $(C_CHAINDIR)/c++/cpp_chain.hpp $(C_CHAINDIR)/c++/cpp_chain.cpp $(CALL_LIBS) | directories
	cp $(C_CHAINDIR)/c++/cpp_chain.hpp $(HEADERDIR)/cpp_chain.h
	g++ -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/c++/cpp_chain.cpp -o $(OBJECTDIR)/cpp_chain.o
	g++ -shared -o $(LIBDIR)/libcpp_chain.so $(OBJECTDIR)/cpp_chain.o

$(LIBDIR)/libd_chain.so: $(C_CHAINDIR)/d/d_chain.h $(C_CHAINDIR)/d/d_chain.d $(CALL_LIBS) | directories
	cp $(C_CHAINDIR)/d/d_chain.h $(HEADERDIR)/d_chain.h
	dmd -c $(C_CHAINDIR)/d/d_chain.d -fPIC -of$(OBJECTDIR)/d_chain.o
	dmd -of$(LIBDIR)/libd_chain.so $(OBJECTDIR)/d_chain.o -shared

$(LIBDIR)/libgo_chain.so: $(C_CHAINDIR)/go/go_chain.go $(CALL_LIBS) | directories
	C_INCLUDE_PATH="$(PWD)/$(HEADERDIR)" go build -o ./$(LIBDIR)/libgo_chain.so -buildmode=c-shared $(C_CHAINDIR)/go/go_chain.go
	mv ./$(LIBDIR)/libgo_chain.h ./$(HEADERDIR)/go_chain.h

$(LIBDIR)/libnim_chain.so: $(C_CHAINDIR)/nim/nim_chain.nim $(CALL_LIBS) | directories
	nim c --app=lib --noMain --header:nim_chain.h -o:$(LIBDIR)/libnim_chain.so $(C_CHAINDIR)/nim/nim_chain.nim 
	cp ~/.cache/nim/nim_chain_d/nim_chain.h $(HEADERDIR)/nim_chain.h

$(LIBDIR)/liboc_chain.so: $(C_CHAINDIR)/objective-c/oc_chain.m $(C_CHAINDIR)/objective-c/oc_chain.h $(CALL_LIBS) | directories
	cp $(C_CHAINDIR)/objective-c/oc_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/objective-c/oc_chain.m -o $(OBJECTDIR)/oc_chain.o
	gcc -shared -o $(LIBDIR)/liboc_chain.so $(OBJECTDIR)/oc_chain.o

$(LIBDIR)/librust_chain.so: $(C_CHAINDIR)/rust/rust_chain.rs $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so | directories
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

$(LIBDIR)/libzig_chain.so: $(C_CHAINDIR)/zig/zig_chain.zig $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so | directories
	zig build-lib --library c -dynamic -I /usr/include/ -I $(HEADERDIR)/ $(C_CHAINDIR)/zig/zig_chain.zig -femit-bin=$(LIBDIR)/libzig_chain.so
	cp  $(C_CHAINDIR)/zig/zig_chain.h ./$(HEADERDIR)/zig_chain.h

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(OBJECTDIR):
	mkdir -p $(OBJECTDIR)

$(HEADERDIR):
	mkdir -p $(HEADERDIR)

directories: $(LIBDIR) $(OBJECTDIR) $(HEADERDIR)

run: build/main
	LD_LIBRARY_PATH="$(LIBDIR):$LD_LIBRARY_PATH" ./build/main

clean:
	rm -rf build
	rm -rf $(C_CALLDIR)/zig/zig-cache
	rm -rf $(C_CHAINDIR)/zig/zig-cache

.PHONY: clean directories run build