LIBDIR := build/libs
OBJECTDIR := build/objects
HEADERDIR := build/headers
C_CALLDIR := src/end_calls
C_CHAINDIR := src/mid_calls

build: build/main

build/main: src/main.c $(LIBDIR)/libc_chain.so $(LIBDIR)/libcpp_chain.so $(LIBDIR)/libd_chain.so $(LIBDIR)/libgo_chain.so
	gcc -o build/main src/main.c -I$(HEADERDIR) -L$(LIBDIR) -l:libc_call.so -l:libcpp_call.so -l:librust_call.so -l:libgo_call.so -l:libd_call.so -l:libzig_call.so -l:libnim_call.so -l:liboc_call.so -l:libc_chain.so -l:libcpp_chain.so -l:libd_chain.so -l:libgo_chain.so

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

$(LIBDIR)/libc_chain.so: $(C_CHAINDIR)/c/c_chain.h $(C_CHAINDIR)/c/c_chain.c $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so | directories
	cp $(C_CHAINDIR)/c/c_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/c/c_chain.c -o $(OBJECTDIR)/c_chain.o
	gcc -shared -o $(LIBDIR)/libc_chain.so $(OBJECTDIR)/c_chain.o

$(LIBDIR)/libcpp_chain.so: $(C_CHAINDIR)/c++/cpp_chain.hpp $(C_CHAINDIR)/c++/cpp_chain.cpp $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so | directories
	cp $(C_CHAINDIR)/c++/cpp_chain.hpp $(HEADERDIR)/cpp_chain.h
	g++ -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/c++/cpp_chain.cpp -o $(OBJECTDIR)/cpp_chain.o
	g++ -shared -o $(LIBDIR)/libcpp_chain.so $(OBJECTDIR)/cpp_chain.o


$(LIBDIR)/libd_chain.so: $(C_CHAINDIR)/d/d_chain.h $(C_CHAINDIR)/d/d_chain.d $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so | directories
	cp $(C_CHAINDIR)/d/d_chain.h $(HEADERDIR)/d_chain.h
	dmd -c $(C_CHAINDIR)/d/d_chain.d -fPIC -of$(OBJECTDIR)/d_chain.o
	dmd -of$(LIBDIR)/libd_chain.so $(OBJECTDIR)/d_chain.o -shared

$(LIBDIR)/libgo_chain.so: $(C_CHAINDIR)/go/go_chain.go $(LIBDIR)/libc_call.so $(LIBDIR)/libcpp_call.so $(LIBDIR)/librust_call.so $(LIBDIR)/libgo_call.so $(LIBDIR)/libd_call.so $(LIBDIR)/libzig_call.so $(LIBDIR)/libnim_call.so $(LIBDIR)/liboc_call.so | directories
	C_INCLUDE_PATH="$(PWD)/$(HEADERDIR)" go build -o ./$(LIBDIR)/libgo_chain.so -buildmode=c-shared $(C_CHAINDIR)/go/go_chain.go
	mv ./$(LIBDIR)/libgo_chain.h ./$(HEADERDIR)/go_chain.h

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

.PHONY: clean directories run build