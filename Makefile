# ---------
# variables
# ---------

EXENAME				:=	main

BUILDDIR			:=	build
LIBDIR 				:= 	$(BUILDDIR)/libs
# for all libraries
OBJECTDIR 			:= 	$(BUILDDIR)/objects
# for all build files
HEADERDIR 			:= 	$(BUILDDIR)/headers
RUSTDIR 			:= 	$(BUILDDIR)/rust
DIRLIST				:= 	$(LIBDIR) $(OBJECTDIR) $(HEADERDIR) $(RUSTDIR)

C_CALLDIR 			:= 	src/end_calls
C_CHAINDIR 			:= 	src/mid_calls

CALL_LIBS 			:= 	$(LIBDIR)/libada_call.so		\
						$(LIBDIR)/libc_call.so  		\
						$(LIBDIR)/libcpp_call.so 		\
						$(LIBDIR)/libcobol_call.so 		\
						$(LIBDIR)/libd_call.so  		\
						$(LIBDIR)/libfortran_call.so	\
						$(LIBDIR)/libgo_call.so  		\
						$(LIBDIR)/libhaskell_call.so	\
						$(LIBDIR)/libjava_call.so $(LIBDIR)/libr_java_call.so		\
						$(LIBDIR)/libnim_call.so  		\
						$(LIBDIR)/liboc_call.so  		\
						$(LIBDIR)/libodin_call.so  		\
						$(LIBDIR)/libpascal_call.so		\
						$(LIBDIR)/librust_call.so  		\
						$(LIBDIR)/libswift_call.so  	\
						$(LIBDIR)/libzig_call.so

CHAIN_LIBS 			:=  $(LIBDIR)/libada_chain.so	  	\
						$(LIBDIR)/libjava_chain.so $(LIBDIR)/libr_java_chain.so		\
						$(LIBDIR)/libzig_chain.so

LIBS 				:= 	$(CALL_LIBS) $(CHAIN_LIBS)

CALL_LIBS_FLAGS 	:= 	-l:libada_call.so				\
						-l:libc_call.so					\
						-l:libcpp_call.so 				\
						-l:libcobol_call.so				\
						-l:libd_call.so 				\
						-l:libfortran_call.so 			\
						-l:libgo_call.so 				\
						-l:libhaskell_call.so			\
						-l:libjava_call.so -l:libr_java_call.so				\
						-l:libnim_call.so 				\
						-l:liboc_call.so 				\
						-l:libodin_call.so 				\
						-l:libpascal_call.so 			\
						-l:librust_call.so 				\
						-l:libswift_call.so 			\
						-l:libzig_call.so

CHAIN_LIBS_FLAGS 	:= 	-l:libada_chain.so				\
						-l:libjava_chain.so -l:libr_java_chain.so				\
						-l:libzig_chain.so

LIBS_FLAGS 			:= 	$(CALL_LIBS_FLAGS) $(CHAIN_LIBS_FLAGS) -lgfortran

CALL_HEADERS		:= 	$(HEADERDIR)/ada_call.h			\
						$(HEADERDIR)/c_call.h 			\
						$(HEADERDIR)/cpp_call.h 		\
						$(HEADERDIR)/cobol_call.h		\
						$(HEADERDIR)/d_call.h 			\
						$(HEADERDIR)/fortran_call.h 	\
						$(HEADERDIR)/go_call.h 			\
						$(HEADERDIR)/haskell_call.h		\
						$(HEADERDIR)/java_call.h $(HEADERDIR)/r_java_call.h		\
						$(HEADERDIR)/nim_call.h 		\
						$(HEADERDIR)/oc_call.h 			\
						$(HEADERDIR)/odin_call.h 		\
						$(HEADERDIR)/pascal_call.h 		\
						$(HEADERDIR)/rust_call.h 		\
						$(HEADERDIR)/swift_call.h 		\
						$(HEADERDIR)/zig_call.h

CHAIN_HEADERS		:= 	$(HEADERDIR)/ada_chain.h		\
						$(HEADERDIR)/java_chain.h $(HEADERDIR)/r_java_chain.h		\
						$(HEADERDIR)/zig_chain.h

RUST_CALL_HEADERS	:= 	$(RUSTDIR)/ada_call.rs			\
						$(RUSTDIR)/c_call.rs 			\
						$(RUSTDIR)/cpp_call.rs 			\
						$(RUSTDIR)/cobol_call.rs		\
						$(RUSTDIR)/d_call.rs			\
						$(RUSTDIR)/fortran_call.rs		\
						$(RUSTDIR)/go_call.rs			\
						$(RUSTDIR)/haskell_call.rs		\
						$(RUSTDIR)/java_call.rs			\
						$(RUSTDIR)/nim_call.rs			\
						$(RUSTDIR)/oc_call.rs			\
						$(RUSTDIR)/odin_call.rs			\
						$(RUSTDIR)/pascal_call.rs		\
						$(RUSTDIR)/swift_call.rs		\
						$(RUSTDIR)/zig_call.rs

GHC_INCLUDE		:= /usr/lib/ghc-9.0.2/include
GHC_LIB			:= -l:libHSrts_thr-ghc9.0.2.so
GHC_LIB_DIR		:= /usr/lib/ghc-9.0.2/rts/

# -----
# build
# -----

build: $(BUILDDIR)/$(EXENAME)

$(BUILDDIR)/$(EXENAME): src/main.c $(LIBS) $(CHAIN_HEADERS)
	gcc -o $(BUILDDIR)/$(EXENAME) src/main.c -I$(HEADERDIR) -L$(LIBDIR) $(LIBS_FLAGS) -I$(GHC_INCLUDE) -L$(GHC_LIB_DIR) $(GHC_LIB)

# ---------
# call libs
# ---------

$(LIBDIR)/libada_call.so $(HEADERDIR)/ada_call.h: $(C_CALLDIR)/ada/ada_call.adb $(C_CALLDIR)/ada/ada_call.ads $(C_CALLDIR)/ada/ada_call.h | directories
	cp $(C_CALLDIR)/ada/ada_call.h $(HEADERDIR)/
	gcc -c -I$(C_CALLDIR)/ada/ -I- $(C_CALLDIR)/ada/ada_call.adb -o $(OBJECTDIR)/ada_call.o  -fPIC
	cd $(OBJECTDIR) && gnatbind -n -a ada_call -o b~ada_call.adb
	gcc -fPIC -c -s $(OBJECTDIR)/b~ada_call.adb -o $(OBJECTDIR)/b~ada_call.o
	gcc -shared -o $(LIBDIR)/libada_call.so $(OBJECTDIR)/ada_call.o $(OBJECTDIR)/b~ada_call.o -lgnat -lgnarl

$(LIBDIR)/libc_call.so $(HEADERDIR)/c_call.h: $(C_CALLDIR)/c/c_call.c $(C_CALLDIR)/c/c_call.h | directories
	cp $(C_CALLDIR)/c/c_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/c/c_call.c -o $(OBJECTDIR)/c_call.o
	gcc -shared -o $(LIBDIR)/libc_call.so $(OBJECTDIR)/c_call.o

$(LIBDIR)/libcpp_call.so $(HEADERDIR)/cpp_call.h: $(C_CALLDIR)/c++/cpp_call.cpp $(C_CALLDIR)/c++/cpp_call.hpp	| directories
	cp $(C_CALLDIR)/c++/cpp_call.hpp $(HEADERDIR)/cpp_call.h
	g++ -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/c++/cpp_call.cpp -o $(OBJECTDIR)/cpp_call.o
	g++ -shared -o $(LIBDIR)/libcpp_call.so $(OBJECTDIR)/cpp_call.o

$(LIBDIR)/libcobol_call.so $(HEADERDIR)/cobol_call.h: $(C_CALLDIR)/cobol/cobol_call.cob $(C_CALLDIR)/cobol/cobol_call.h | directories
	cp $(C_CALLDIR)/cobol/cobol_call.h $(HEADERDIR)/
	cobc -m -Wall -free -O $(C_CALLDIR)/cobol/cobol_call.cob -o $(LIBDIR)/libcobol_call.so -fimplicit-init

$(LIBDIR)/libd_call.so $(HEADERDIR)/d_call.h: $(C_CALLDIR)/d/d_call.d | directories
	cp $(C_CALLDIR)/d/d_call.h $(HEADERDIR)/
	dmd -c $(C_CALLDIR)/d/d_call.d -fPIC -of$(OBJECTDIR)/d_call.o
	dmd -of$(LIBDIR)/libd_call.so $(OBJECTDIR)/d_call.o -shared

$(LIBDIR)/libfortran_call.so $(HEADERDIR)/fortran_call.h: $(C_CALLDIR)/fortran/fortran_call.f90 $(C_CALLDIR)/fortran/fortran_call.h | directories
	cp $(C_CALLDIR)/fortran/fortran_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/fortran/fortran_call.f90 -o $(OBJECTDIR)/fortran_call.o
	gcc -shared -o $(LIBDIR)/libfortran_call.so $(OBJECTDIR)/fortran_call.o

$(LIBDIR)/libgo_call.so $(HEADERDIR)/go_call.h: $(C_CALLDIR)/go/go_call.go | directories
	go build -o ./$(LIBDIR)/libgo_call.so -buildmode=c-shared $(C_CALLDIR)/go/go_call.go
	mv ./$(LIBDIR)/libgo_call.h ./$(HEADERDIR)/go_call.h

$(LIBDIR)/libhaskell_call.so $(HEADERDIR)/haskell_call.h: $(C_CALLDIR)/haskell/haskell_call.hs | directories
	ghc -dynamic -fPIC -c $(C_CALLDIR)/haskell/haskell_call.hs -o $(OBJECTDIR)/haskell_call.o -ohi $(OBJECTDIR)/haskell_call.hi
	ghc -dynamic -shared -flink-rts $(OBJECTDIR)/haskell_call.o -o $(LIBDIR)/libhaskell_call.so
	mv $(C_CALLDIR)/haskell/haskell_call_stub.h $(HEADERDIR)/haskell_call.h

$(LIBDIR)/libjava_call.so $(LIBDIR)/libr_java_call.so $(HEADERDIR)/java_call.h $(HEADERDIR)/r_java_call.h: $(C_CALLDIR)/java/r_java_call.java $(C_CALLDIR)/java/java_call.c $(C_CALLDIR)/java/java_call.h | directories
	javac $(C_CALLDIR)/java/r_java_call.java -d $(OBJECTDIR)/r_java_call
	(cd $(OBJECTDIR)/r_java_call && native-image --shared -H:Name=libfoobar)
	mv $(OBJECTDIR)/r_java_call/graal_isolate.h $(HEADERDIR)/
	mv $(OBJECTDIR)/r_java_call/libfoobar.h $(HEADERDIR)/r_java_call.h
	mv $(OBJECTDIR)/r_java_call/libfoobar.so $(LIBDIR)/libr_java_call.so
	cp $(C_CALLDIR)/java/java_call.h $(HEADERDIR)/
	
	gcc -c -I$(HEADERDIR) -FPIC $(C_CALLDIR)/java/java_call.c -o $(OBJECTDIR)/java_call.o
	gcc -shared -o $(LIBDIR)/libjava_call.so $(OBJECTDIR)/java_call.o

$(LIBDIR)/libnim_call.so $(HEADERDIR)/nim_call.h: $(C_CALLDIR)/nim/nim_call.nim | directories
	nim c --app=lib --noMain --header:nim_call.h -o:$(LIBDIR)/libnim_call.so $(C_CALLDIR)/nim/nim_call.nim 
	cp ~/.cache/nim/nim_call_d/nim_call.h $(HEADERDIR)/nim_call.h

$(LIBDIR)/liboc_call.so $(HEADERDIR)/oc_call.h: $(C_CALLDIR)/objective-c/oc_call.m $(C_CALLDIR)/objective-c/oc_call.h | directories
	cp $(C_CALLDIR)/objective-c/oc_call.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CALLDIR)/objective-c/oc_call.m -o $(OBJECTDIR)/oc_call.o
	gcc -shared -o $(LIBDIR)/liboc_call.so $(OBJECTDIR)/oc_call.o

$(LIBDIR)/libodin_call.so $(HEADERDIR)/odin_call.h: $(C_CALLDIR)/odin/odin_call.odin $(C_CALLDIR)/odin/odin_call.h | directories
	cp $(C_CALLDIR)/odin/odin_call.h $(HEADERDIR)/
	odin build $(C_CALLDIR)/odin/odin_call.odin -file -build-mode:shared -out=$(LIBDIR)/libodin_call.so

$(LIBDIR)/libpascal_call.so $(HEADERDIR)/pascal_call.h: $(C_CALLDIR)/pascal/pascal_call.pp $(C_CALLDIR)/pascal/pascal_call.h | directories
	cp $(C_CALLDIR)/pascal/pascal_call.h $(HEADERDIR)/
	fpc $(C_CALLDIR)/pascal/pascal_call.pp -FE$(OBJECTDIR)/
	cp $(OBJECTDIR)/libpascal_call.so $(LIBDIR)/libpascal_call.so

$(LIBDIR)/librust_call.so $(HEADERDIR)/rust_call.h $(HEADERDIR)/rust_call.hpp: $(C_CALLDIR)/rust/rust_call.rs | directories
	cbindgen --output $(HEADERDIR)/rust_call.h --lang c $(C_CALLDIR)/rust/rust_call.rs
	cbindgen --output $(HEADERDIR)/rust_call.hpp --lang c++ $(C_CALLDIR)/rust/rust_call.rs
	rustc --crate-type=cdylib -L $(HEADERDIR)/ $(C_CALLDIR)/rust/rust_call.rs -o $(LIBDIR)/librust_call.so

$(LIBDIR)/libswift_call.so $(HEADERDIR)/swift_call.h: $(C_CALLDIR)/swift/swift_call.swift $(C_CALLDIR)/swift/swift_call.h
	cp $(C_CALLDIR)/swift/swift_call.h $(HEADERDIR)/
	swiftc $(C_CALLDIR)/swift/swift_call.swift -emit-module -emit-library -o $(OBJECTDIR)/libswift_call.so
	cp $(OBJECTDIR)/libswift_call.so $(LIBDIR)/libswift_call.so

$(LIBDIR)/libzig_call.so $(HEADERDIR)/zig_call.h: $(C_CALLDIR)/zig/zig_call.zig | directories
	zig build-lib --library c --cache-dir $(OBJECTDIR)/call -dynamic -I $(HEADERDIR)/ $(C_CALLDIR)/zig/zig_call.zig -femit-bin=$(OBJECTDIR)/libzig_call.so
	cp $(OBJECTDIR)/libzig_call.so $(LIBDIR)/libzig_call.so
	cp  $(C_CALLDIR)/zig/zig_call.h ./$(HEADERDIR)/zig_call.h


# ----------
# chain libs
# ----------

$(LIBDIR)/libada_chain.so $(HEADERDIR)/ada_chain.h: $(C_CHAINDIR)/ada/ada_chain.adb $(C_CHAINDIR)/ada/ada_chain.ads $(C_CHAINDIR)/ada/ada_chain.h $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/ada/ada_chain.h $(HEADERDIR)/
	gcc -c -I$(C_CHAINDIR)/ada/ -I- $(C_CHAINDIR)/ada/ada_chain.adb -o $(OBJECTDIR)/ada_chain.o  -fPIC
	cd $(OBJECTDIR) && gnatbind -n -a ada_chain -o b~ada_chain.adb
	gcc -fPIC -c -s $(OBJECTDIR)/b~ada_chain.adb -o $(OBJECTDIR)/b~ada_chain.o
	gcc -shared -o $(LIBDIR)/libada_chain.so $(OBJECTDIR)/ada_chain.o $(OBJECTDIR)/b~ada_chain.o -lgnat -lgnarl

$(LIBDIR)/libc_chain.so $(HEADERDIR)/c_chain.h: $(C_CHAINDIR)/c/c_chain.h $(C_CHAINDIR)/c/c_chain.c $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/c/c_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -I$(GHC_INCLUDE) -fPIC $(C_CHAINDIR)/c/c_chain.c -o $(OBJECTDIR)/c_chain.o
	gcc -shared -o $(LIBDIR)/libc_chain.so $(OBJECTDIR)/c_chain.o

$(LIBDIR)/libcpp_chain.so $(HEADERDIR)/cpp_chain.h: $(C_CHAINDIR)/c++/cpp_chain.hpp $(C_CHAINDIR)/c++/cpp_chain.cpp $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/c++/cpp_chain.hpp $(HEADERDIR)/cpp_chain.h
	g++ -c -I$(HEADERDIR) -I$(GHC_INCLUDE) -fPIC $(C_CHAINDIR)/c++/cpp_chain.cpp -o $(OBJECTDIR)/cpp_chain.o
	g++ -shared -o $(LIBDIR)/libcpp_chain.so $(OBJECTDIR)/cpp_chain.o

$(LIBDIR)/libcobol_chain.so $(HEADERDIR)/cobol_chain.h: $(C_CHAINDIR)/cobol/cobol_chain.cob $(C_CHAINDIR)/cobol/cobol_chain.h $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/cobol/cobol_chain.h $(HEADERDIR)/
	cobc -m -Wall -free -O $(C_CHAINDIR)/cobol/cobol_chain.cob -o $(LIBDIR)/libcobol_chain.so -L$(LIBDIR) $(CALL_LIBS_FLAGS) -fimplicit-init

$(LIBDIR)/libd_chain.so $(HEADERDIR)/d_chain.h: $(C_CHAINDIR)/d/d_chain.h $(C_CHAINDIR)/d/d_chain.d $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/d/d_chain.h $(HEADERDIR)/d_chain.h
	dmd -c $(C_CHAINDIR)/d/d_chain.d -fPIC -of$(OBJECTDIR)/d_chain.o
	dmd -of$(LIBDIR)/libd_chain.so $(OBJECTDIR)/d_chain.o -shared

$(LIBDIR)/libfortran_chain.so $(HEADERDIR)/fortran_chain.h: $(C_CHAINDIR)/fortran/fortran_chain.f90 $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/fortran/fortran_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -fPIC $(C_CHAINDIR)/fortran/fortran_chain.f90 -o $(OBJECTDIR)/fortran_chain.o
	gcc -shared -o $(LIBDIR)/libfortran_chain.so $(OBJECTDIR)/fortran_chain.o
	rm -rf c_interface.mod

$(LIBDIR)/libgo_chain.so $(HEADERDIR)/go_chain.h: $(C_CHAINDIR)/go/go_chain.go $(CALL_HEADERS) | directories
	C_INCLUDE_PATH="$(PWD)/$(HEADERDIR):$(GHC_INCLUDE)" go build -o ./$(LIBDIR)/libgo_chain.so -buildmode=c-shared $(C_CHAINDIR)/go/go_chain.go
	mv ./$(LIBDIR)/libgo_chain.h ./$(HEADERDIR)/go_chain.h

$(LIBDIR)/libhaskell_chain.so $(HEADERDIR)/haskell_chain.h: $(C_CHAINDIR)/haskell/haskell_chain.hs $(CALL_HEADERS) | directories
	ghc -dynamic -fPIC -c $(C_CHAINDIR)/haskell/haskell_chain.hs -o $(OBJECTDIR)/haskell_chain.o -ohi $(OBJECTDIR)/haskell_chain.hi
	ghc -dynamic -shared -flink-rts $(OBJECTDIR)/haskell_chain.o -o $(LIBDIR)/libhaskell_chain.so
	mv $(C_CHAINDIR)/haskell/haskell_chain_stub.h $(HEADERDIR)/haskell_chain.h

$(LIBDIR)/libjava_chain.so $(LIBDIR)/libr_java_chain.so $(HEADERDIR)/java_chain.h $(HEADERDIR)/r_java_chain.h: $(C_CHAINDIR)/java/r_java_chain.java $(C_CHAINDIR)/java/java_chain.c $(C_CHAINDIR)/java/java_chain.h | directories
	javac $(C_CHAINDIR)/java/r_java_chain.java -d $(OBJECTDIR)/r_java_chain
	(cd $(OBJECTDIR)/r_java_chain && native-image --shared -H:Name=libfoobar)
	mv $(OBJECTDIR)/r_java_chain/graal_isolate.h $(HEADERDIR)/
	mv $(OBJECTDIR)/r_java_chain/libfoobar.h $(HEADERDIR)/r_java_chain.h
	mv $(OBJECTDIR)/r_java_chain/libfoobar.so $(LIBDIR)/libr_java_chain.so
	cp $(C_CHAINDIR)/java/java_chain.h $(HEADERDIR)/
	
	gcc -c -I$(HEADERDIR) -FPIC $(C_CHAINDIR)/java/java_chain.c -o $(OBJECTDIR)/java_chain.o
	gcc -shared -o $(LIBDIR)/libjava_chain.so $(OBJECTDIR)/java_chain.o

$(LIBDIR)/libnim_chain.so $(HEADERDIR)/nim_chain.h: $(C_CHAINDIR)/nim/nim_chain.nim $(CALL_HEADERS) | directories
	nim c --app=lib --noMain --header:nim_chain.h -o:$(LIBDIR)/libnim_chain.so $(C_CHAINDIR)/nim/nim_chain.nim 
	cp ~/.cache/nim/nim_chain_d/nim_chain.h $(HEADERDIR)/nim_chain.h

$(LIBDIR)/liboc_chain.so $(HEADERDIR)/oc_chain.h: $(C_CHAINDIR)/objective-c/oc_chain.m $(C_CHAINDIR)/objective-c/oc_chain.h $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/objective-c/oc_chain.h $(HEADERDIR)/
	gcc -c -I$(HEADERDIR) -I$(GHC_INCLUDE) -fPIC $(C_CHAINDIR)/objective-c/oc_chain.m -o $(OBJECTDIR)/oc_chain.o
	gcc -shared -o $(LIBDIR)/liboc_chain.so $(OBJECTDIR)/oc_chain.o

$(LIBDIR)/libodin_chain.so $(HEADERDIR)/odin_chain.h: $(C_CHAINDIR)/odin/odin_chain.odin $(C_CHAINDIR)/odin/odin_chain.h $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/odin/odin_chain.h $(HEADERDIR)/
	odin build $(C_CHAINDIR)/odin/odin_chain.odin -file -build-mode:shared -out=$(LIBDIR)/libodin_chain.so

$(LIBDIR)/libpascal_chain.so $(HEADERDIR)/pascal_chain.h: $(C_CHAINDIR)/pascal/pascal_chain.pp $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/pascal/pascal_chain.h $(HEADERDIR)/
	fpc $(C_CHAINDIR)/pascal/pascal_chain.pp -FE$(OBJECTDIR)/
	cp $(OBJECTDIR)/libpascal_chain.so $(LIBDIR)/libpascal_chain.so

$(LIBDIR)/librust_chain.so: $(C_CHAINDIR)/rust/rust_chain.rs $(CALL_HEADERS) $(RUST_CALL_HEADERS) | directories
	rustc --crate-type=cdylib -L $(HEADERDIR)/ $(C_CHAINDIR)/rust/rust_chain.rs -o $(LIBDIR)/librust_chain.so

$(HEADERDIR)/rust_chain.h: $(C_CHAINDIR)/rust/rust_chain.rs | directories
	cbindgen --output $(HEADERDIR)/rust_chain.h --lang c $(C_CHAINDIR)/rust/rust_chain.rs

$(LIBDIR)/libswift_chain.so $(HEADERDIR)/swift_chain.h: $(C_CHAINDIR)/swift/swift_chain.swift $(CALL_HEADERS) | directories
	cp $(C_CHAINDIR)/swift/swift_chain.h $(HEADERDIR)/
	swiftc $(C_CHAINDIR)/swift/swift_chain.swift -emit-module -emit-library -o $(OBJECTDIR)/libswift_chain.so -import-objc-header $(C_CHAINDIR)/swift/swift_external_header.h
	cp $(OBJECTDIR)/libswift_chain.so $(LIBDIR)/libswift_chain.so

$(LIBDIR)/libzig_chain.so $(HEADERDIR)/zig_chain.h: $(C_CHAINDIR)/zig/zig_chain.zig $(CALL_HEADERS) | directories
	zig build-lib --library c -dynamic --cache-dir $(OBJECTDIR)/chain -I /usr/include/ -I $(HEADERDIR)/ -I $(GHC_INCLUDE) $(C_CHAINDIR)/zig/zig_chain.zig -femit-bin=$(OBJECTDIR)/libzig_chain.so
	cp $(OBJECTDIR)/libzig_chain.so $(LIBDIR)/libzig_chain.so
	cp  $(C_CHAINDIR)/zig/zig_chain.h ./$(HEADERDIR)/zig_chain.h

# ------------
# rust headers
# ------------

$(RUSTDIR)/ada_call.rs: $(HEADERDIR)/ada_call.h | directories
	bindgen $(HEADERDIR)/ada_call.h -o $(RUSTDIR)/ada_call.rs

$(RUSTDIR)/c_call.rs: $(HEADERDIR)/c_call.h | directories
	bindgen $(HEADERDIR)/c_call.h -o $(RUSTDIR)/c_call.rs

$(RUSTDIR)/cpp_call.rs: $(HEADERDIR)/cpp_call.h | directories
	bindgen $(HEADERDIR)/cpp_call.h -o $(RUSTDIR)/cpp_call.rs

$(RUSTDIR)/cobol_call.rs: $(HEADERDIR)/cobol_call.h | directories
	bindgen $(HEADERDIR)/cobol_call.h -o $(RUSTDIR)/cobol_call.rs

$(RUSTDIR)/d_call.rs: $(HEADERDIR)/d_call.h | directories
	bindgen $(HEADERDIR)/d_call.h -o $(RUSTDIR)/d_call.rs

$(RUSTDIR)/fortran_call.rs: $(HEADERDIR)/fortran_call.h | directories
	bindgen $(HEADERDIR)/fortran_call.h -o $(RUSTDIR)/fortran_call.rs

$(RUSTDIR)/go_call.rs: $(HEADERDIR)/go_call.h | directories
	bindgen $(HEADERDIR)/go_call.h -o $(RUSTDIR)/go_call.rs

$(RUSTDIR)/haskell_call.rs: $(HEADERDIR)/haskell_call.h | directories
	bindgen $(HEADERDIR)/haskell_call.h -o $(RUSTDIR)/haskell_call.rs -- -I$(GHC_INCLUDE)

$(RUSTDIR)/java_call.rs: $(HEADERDIR)/java_call.h | directories
	bindgen $(HEADERDIR)/java_call.h -o $(RUSTDIR)/java_call.rs

$(RUSTDIR)/nim_call.rs: $(HEADERDIR)/nim_call.h | directories
	bindgen $(HEADERDIR)/nim_call.h -o $(RUSTDIR)/nim_call.rs

$(RUSTDIR)/oc_call.rs: $(HEADERDIR)/oc_call.h | directories
	bindgen $(HEADERDIR)/oc_call.h -o $(RUSTDIR)/oc_call.rs

$(RUSTDIR)/odin_call.rs: $(HEADERDIR)/odin_call.h | directories
	bindgen $(HEADERDIR)/odin_call.h -o $(RUSTDIR)/odin_call.rs

$(RUSTDIR)/pascal_call.rs: $(HEADERDIR)/pascal_call.h | directories
	bindgen $(HEADERDIR)/pascal_call.h -o $(RUSTDIR)/pascal_call.rs

$(RUSTDIR)/swift_call.rs: $(HEADERDIR)/swift_call.h | directories
	bindgen $(HEADERDIR)/swift_call.h -o $(RUSTDIR)/swift_call.rs

$(RUSTDIR)/zig_call.rs: $(HEADERDIR)/zig_call.h | directories
	bindgen $(HEADERDIR)/zig_call.h -o $(RUSTDIR)/zig_call.rs


# -------
# folders
# -------

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(OBJECTDIR):
	mkdir -p $(OBJECTDIR)

$(HEADERDIR):
	mkdir -p $(HEADERDIR)

$(RUSTDIR):
	mkdir -p $(RUSTDIR)

directories: $(DIRLIST)

# -----
# other
# -----

run: build/main
	LD_LIBRARY_PATH="$(LIBDIR):$(GHC_LIB_DIR):$LD_LIBRARY_PATH" ./build/main

clean:
	rm -rf build

.PHONY: clean directories run build
