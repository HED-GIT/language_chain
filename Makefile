# ---------
# variables
# ---------

EXE_NAME			:=	main

BUILD_DIR			:=	build
LIB_DIR 			:= 	$(CURDIR)/$(BUILD_DIR)/libs
# for all libraries
OBJECT_DIR 			:= 	$(CURDIR)/$(BUILD_DIR)/objects
# for all build files
HEADER_DIR 			:= 	$(CURDIR)/$(BUILD_DIR)/headers
RUST_DIR 			:= 	$(CURDIR)/$(BUILD_DIR)/rust
KOTLIN_DIR 			:= 	$(CURDIR)/$(BUILD_DIR)/kotlin
DIR_LIST			:= 	$(LIB_DIR) $(OBJECT_DIR) $(HEADER_DIR) $(RUST_DIR) $(KOTLIN_DIR)

SRC_DIR				:=	$(CURDIR)/src
TEST_DIR			:=	$(CURDIR)/test
CALL_DIR 			:= 	$(SRC_DIR)/end_calls
CHAIN_DIR 			:= 	$(SRC_DIR)/mid_calls

LANGUAGES			:=	ada c cpp cobol crystal d fortran go haskell java julia kotlin nim oc odin pascal rust swift zig
LANGUAGE_WRAPPERS	:=	java kotlin
# everything that requires a wrapper to run

CALL_LIBS 			:= 	$(foreach LANGUAGE,$(LANGUAGES), $(LIB_DIR)/lib$(LANGUAGE)_call.so)
CHAIN_LIBS 			:=  $(foreach LANGUAGE,$(LANGUAGES), $(LIB_DIR)/lib$(LANGUAGE)_chain.so)
LIBS 				:= 	$(CALL_LIBS) $(CHAIN_LIBS)

CALL_LIBS_FLAGS 	:= 	$(foreach LANGUAGE,$(LANGUAGES), -l:lib$(LANGUAGE)_call.so) $(foreach WRAPPER,$(LANGUAGE_WRAPPERS), -l:libr_$(WRAPPER)_call.so)
CHAIN_LIBS_FLAGS 	:= 	$(foreach LANGUAGE,$(LANGUAGES), -l:lib$(LANGUAGE)_chain.so) $(foreach WRAPPER,$(LANGUAGE_WRAPPERS), -l:libr_$(WRAPPER)_chain.so)

CALL_HEADERS		:= 	$(foreach LANGUAGE,$(LANGUAGES), $(HEADER_DIR)/$(LANGUAGE)_call.h) $(foreach WRAPPER,$(LANGUAGE_WRAPPERS), $(HEADER_DIR)/r_$(WRAPPER)_call.h)
CHAIN_HEADERS		:= 	$(foreach LANGUAGE,$(LANGUAGES), $(HEADER_DIR)/$(LANGUAGE)_chain.h) $(foreach WRAPPER,$(LANGUAGE_WRAPPERS), $(HEADER_DIR)/r_$(WRAPPER)_chain.h)

RUST_CALL_HEADERS	:= 	$(foreach LANGUAGE,$(LANGUAGES), $(RUST_DIR)/$(LANGUAGE)_call.rs)
KOTLIN_CALL_HEADERS	:= 	$(foreach LANGUAGE,$(LANGUAGES), $(KOTLIN_DIR)/$(LANGUAGE)_call.klib)

CALL_TEST_EXES		:= 	$(foreach LANGUAGE,$(LANGUAGES), $(BUILD_DIR)/test_$(LANGUAGE)_call)
CHAIN_TEST_EXES		:= 	$(foreach LANGUAGE,$(LANGUAGES), $(BUILD_DIR)/test_$(LANGUAGE)_chain)

GHC_VERSION			:= 9.0.2
GHC_INCLUDE			:= /usr/lib/ghc-$(GHC_VERSION)/include
GHC_LIB				:= -l:libHSrts_thr-ghc$(GHC_VERSION).so
GHC_LIB_DIR			:= /usr/lib/ghc-$(GHC_VERSION)/rts/

BASE_INCLUDE		:= /usr/include/

JULIA_LIB_DIR		:= /usr/lib/julia

LIBS_FLAGS 			:= $(CALL_LIBS_FLAGS) $(CHAIN_LIBS_FLAGS) $(GHC_LIB) -lgfortran -ljulia -ljulia-internal
LIB_DIR_FLAGS		:= -L$(LIB_DIR) -L$(GHC_LIB_DIR) -L/$(JULIA_LIB_DIR)
HEADER_DIR_FLAGS 	:= -I$(HEADER_DIR) -I$(GHC_INCLUDE) 

# -----
# build
# -----

all: build run_test

build: $(BUILD_DIR)/$(EXE_NAME)

build_tests: $(CALL_TEST_EXES) $(CHAIN_TEST_EXES)

$(BUILD_DIR)/$(EXE_NAME): $(SRC_DIR)/main.c $(LIBS) $(CHAIN_HEADERS)
	gcc -o $(BUILD_DIR)/$(EXE_NAME) src/main.c $(HEADER_DIR_FLAGS) $(LIB_DIR_FLAGS) $(LIBS_FLAGS) 

# -----
# tests
# -----

$(BUILD_DIR)/test_%_call: $(TEST_DIR)/call_test.c $(LIBS)
	gcc -o $(BUILD_DIR)/test_$*_call $(TEST_DIR)/call_test.c $(HEADER_DIR_FLAGS) $(LIB_DIR_FLAGS) $(LIBS_FLAGS) -D CALL_FUNCTION=call_$* -D CALL_LIB=\"$*_call.h\"

$(BUILD_DIR)/test_%_chain: $(TEST_DIR)/chain_test.c $(LIBS) $(CHAIN_HEADERS)
	gcc -o $(BUILD_DIR)/test_$*_chain $(TEST_DIR)/chain_test.c $(HEADER_DIR_FLAGS) $(LIB_DIR_FLAGS) $(LIBS_FLAGS) -D CHAIN_FUNCTION=start_$*_chain -D CHAIN_LIB=\"$*_chain.h\"


# ---------
# call libs
# ---------

$(LIB_DIR)/libada_call.so $(HEADER_DIR)/ada_call.h: $(CALL_DIR)/ada/ada_call.adb $(CALL_DIR)/ada/ada_call.ads $(CALL_DIR)/ada/ada_call.h | $(DIR_LIST)
	cp $(CALL_DIR)/ada/ada_call.h $(HEADER_DIR)/
	gcc -c -I$(CALL_DIR)/ada/ -I- $(CALL_DIR)/ada/ada_call.adb -o $(OBJECT_DIR)/ada_call.o  -fPIC
	cd $(OBJECT_DIR) && gnatbind -n -a ada_call -o b~ada_call.adb
	gcc -fPIC -c -s $(OBJECT_DIR)/b~ada_call.adb -o $(OBJECT_DIR)/b~ada_call.o
	gcc -shared -o $(LIB_DIR)/libada_call.so $(OBJECT_DIR)/ada_call.o $(OBJECT_DIR)/b~ada_call.o -lgnat -lgnarl

$(LIB_DIR)/libc_call.so $(HEADER_DIR)/c_call.h: $(CALL_DIR)/c/c_call.c $(CALL_DIR)/c/c_call.h | $(DIR_LIST)
	cp $(CALL_DIR)/c/c_call.h $(HEADER_DIR)/
	gcc -c -I$(HEADER_DIR) -fPIC $(CALL_DIR)/c/c_call.c -o $(OBJECT_DIR)/c_call.o
	gcc -shared -o $(LIB_DIR)/libc_call.so $(OBJECT_DIR)/c_call.o

$(LIB_DIR)/libcpp_call.so $(HEADER_DIR)/cpp_call.h: $(CALL_DIR)/c++/cpp_call.cpp $(CALL_DIR)/c++/cpp_call.hpp	| $(DIR_LIST)
	cp $(CALL_DIR)/c++/cpp_call.hpp $(HEADER_DIR)/cpp_call.h
	g++ -c -I$(HEADER_DIR) -fPIC $(CALL_DIR)/c++/cpp_call.cpp -o $(OBJECT_DIR)/cpp_call.o
	g++ -shared -o $(LIB_DIR)/libcpp_call.so $(OBJECT_DIR)/cpp_call.o

$(LIB_DIR)/libcobol_call.so $(HEADER_DIR)/cobol_call.h: $(CALL_DIR)/cobol/cobol_call.cob $(CALL_DIR)/cobol/cobol_call.h | $(DIR_LIST)
	cp $(CALL_DIR)/cobol/cobol_call.h $(HEADER_DIR)/
	cobc -m -Wall -free -O $(CALL_DIR)/cobol/cobol_call.cob -o $(LIB_DIR)/libcobol_call.so -fimplicit-init

$(LIB_DIR)/libcrystal_call.so $(HEADER_DIR)/crystal_call.h: $(CALL_DIR)/crystal/crystal_call.cr $(CALL_DIR)/crystal/crystal_call.h | $(DIR_LIST)
	crystal build --release --no-debug -o $(LIB_DIR)/libcrystal_call.so --link-flags="-shared" $(CALL_DIR)/crystal/crystal_call.cr
	cp $(CALL_DIR)/crystal/crystal_call.h $(HEADER_DIR)/crystal_call.h

$(LIB_DIR)/libd_call.so $(HEADER_DIR)/d_call.h: $(CALL_DIR)/d/d_call.d | $(DIR_LIST)
	cp $(CALL_DIR)/d/d_call.h $(HEADER_DIR)/
	dmd -c $(CALL_DIR)/d/d_call.d -fPIC -of$(OBJECT_DIR)/d_call.o
	dmd -of$(LIB_DIR)/libd_call.so $(OBJECT_DIR)/d_call.o -shared

$(LIB_DIR)/libfortran_call.so $(HEADER_DIR)/fortran_call.h: $(CALL_DIR)/fortran/fortran_call.f90 $(CALL_DIR)/fortran/fortran_call.h | $(DIR_LIST)
	cp $(CALL_DIR)/fortran/fortran_call.h $(HEADER_DIR)/
	gcc -c -I$(HEADER_DIR) -fPIC $(CALL_DIR)/fortran/fortran_call.f90 -o $(OBJECT_DIR)/fortran_call.o
	gcc -shared -o $(LIB_DIR)/libfortran_call.so $(OBJECT_DIR)/fortran_call.o

$(LIB_DIR)/libgo_call.so $(HEADER_DIR)/go_call.h: $(CALL_DIR)/go/go_call.go | $(DIR_LIST)
	go build -o $(LIB_DIR)/libgo_call.so -buildmode=c-shared $(CALL_DIR)/go/go_call.go
	mv $(LIB_DIR)/libgo_call.h $(HEADER_DIR)/go_call.h

$(LIB_DIR)/libhaskell_call.so $(HEADER_DIR)/haskell_call.h: $(CALL_DIR)/haskell/haskell_call.hs | $(DIR_LIST)
	ghc -dynamic -fPIC -c $(CALL_DIR)/haskell/haskell_call.hs -o $(OBJECT_DIR)/haskell_call.o -ohi $(OBJECT_DIR)/haskell_call.hi
	ghc -dynamic -shared -flink-rts $(OBJECT_DIR)/haskell_call.o -o $(LIB_DIR)/libhaskell_call.so
	mv $(CALL_DIR)/haskell/haskell_call_stub.h $(HEADER_DIR)/haskell_call.h || true

$(LIB_DIR)/libjava_call.so $(LIB_DIR)/libr_java_call.so $(HEADER_DIR)/java_call.h $(HEADER_DIR)/r_java_call.h: $(CALL_DIR)/java/r_java_call.java $(CALL_DIR)/java/java_call.c $(CALL_DIR)/java/java_call.h | $(DIR_LIST)
	javac $(CALL_DIR)/java/r_java_call.java -d $(OBJECT_DIR)/r_java_call
	(cd $(OBJECT_DIR)/r_java_call && /usr/lib/jvm/default/bin/native-image --shared -H:Name=libfoobar)
	mv $(OBJECT_DIR)/r_java_call/graal_isolate.h $(HEADER_DIR)/graal_isolate.h
	mv $(OBJECT_DIR)/r_java_call/libfoobar.h $(HEADER_DIR)/r_java_call.h
	mv $(OBJECT_DIR)/r_java_call/libfoobar.so $(LIB_DIR)/libr_java_call.so
	cp $(CALL_DIR)/java/java_call.h $(HEADER_DIR)/
	
	gcc -c -I$(HEADER_DIR) -FPIC $(CALL_DIR)/java/java_call.c -o $(OBJECT_DIR)/java_call.o
	gcc -shared -o $(LIB_DIR)/libjava_call.so $(OBJECT_DIR)/java_call.o

$(LIB_DIR)/libjulia_call.so $(HEADER_DIR)/julia_call.h: $(CALL_DIR)/julia/src/julia_call.jl $(CALL_DIR)/julia/julia_call.h | $(DIR_LIST)
	julia -e 'using Pkg; Pkg.activate("$(CALL_DIR)/julia/"); using PackageCompiler; create_library("$(CALL_DIR)/julia/", "$(OBJECT_DIR)/julia_call", lib_name="libjulia_call", force=true, incremental=false, filter_stdlibs=true)'
	cp $(CALL_DIR)/julia/julia_call.h $(HEADER_DIR)/julia_call.h
	cp $(OBJECT_DIR)/julia_call/lib/*.so $(LIB_DIR)/

$(LIB_DIR)/libkotlin_call.so $(HEADER_DIR)/kotlin_call.h $(LIB_DIR)/libr_kotlin_call.so $(HEADER_DIR)/r_kotlin_call.h: $(CALL_DIR)/kotlin/r_kotlin_call.kt $(CALL_DIR)/kotlin/kotlin_call.c $(CALL_DIR)/kotlin/kotlin_call.h | $(DIR_LIST)
	kotlinc-native -produce dynamic -o $(OBJECT_DIR)/r_kotlin_call $(CALL_DIR)/kotlin/r_kotlin_call.kt
	mv $(OBJECT_DIR)/libr_kotlin_call.so $(LIB_DIR)/libr_kotlin_call.so
	mv $(OBJECT_DIR)/r_kotlin_call_api.h $(HEADER_DIR)/r_kotlin_call.h

	gcc -c -I$(HEADER_DIR) -FPIC $(CALL_DIR)/kotlin/kotlin_call.c -o $(OBJECT_DIR)/kotlin_call.o
	gcc -shared -o $(LIB_DIR)/libkotlin_call.so $(OBJECT_DIR)/kotlin_call.o
	cp $(CALL_DIR)/kotlin/kotlin_call.h $(HEADER_DIR)/

$(LIB_DIR)/libnim_call.so $(HEADER_DIR)/nim_call.h: $(CALL_DIR)/nim/nim_call.nim | $(DIR_LIST)
	nim c --app=lib --noMain --header:nim_call.h -o:$(LIB_DIR)/libnim_call.so $(CALL_DIR)/nim/nim_call.nim 
	cp ~/.cache/nim/nim_call_d/nim_call.h $(HEADER_DIR)/nim_call.h

$(LIB_DIR)/liboc_call.so $(HEADER_DIR)/oc_call.h: $(CALL_DIR)/objective-c/oc_call.m $(CALL_DIR)/objective-c/oc_call.h | $(DIR_LIST)
	cp $(CALL_DIR)/objective-c/oc_call.h $(HEADER_DIR)/
	gcc -c -I$(HEADER_DIR) -fPIC $(CALL_DIR)/objective-c/oc_call.m -o $(OBJECT_DIR)/oc_call.o
	gcc -shared -o $(LIB_DIR)/liboc_call.so $(OBJECT_DIR)/oc_call.o

$(LIB_DIR)/libodin_call.so $(HEADER_DIR)/odin_call.h: $(CALL_DIR)/odin/odin_call.odin $(CALL_DIR)/odin/odin_call.h | $(DIR_LIST)
	cp $(CALL_DIR)/odin/odin_call.h $(HEADER_DIR)/
	odin build $(CALL_DIR)/odin/odin_call.odin -file -build-mode:shared -out=$(LIB_DIR)/libodin_call.so

$(LIB_DIR)/libpascal_call.so $(HEADER_DIR)/pascal_call.h: $(CALL_DIR)/pascal/pascal_call.pp $(CALL_DIR)/pascal/pascal_call.h | $(DIR_LIST)
	cp $(CALL_DIR)/pascal/pascal_call.h $(HEADER_DIR)/
	fpc $(CALL_DIR)/pascal/pascal_call.pp -FE$(OBJECT_DIR)/
	cp $(OBJECT_DIR)/libpascal_call.so $(LIB_DIR)/libpascal_call.so

$(LIB_DIR)/librust_call.so $(HEADER_DIR)/rust_call.h $(HEADER_DIR)/rust_call.hpp: $(CALL_DIR)/rust/rust_call.rs | $(DIR_LIST)
	cbindgen --output $(HEADER_DIR)/rust_call.h --lang c $(CALL_DIR)/rust/rust_call.rs
	cbindgen --output $(HEADER_DIR)/rust_call.hpp --lang c++ $(CALL_DIR)/rust/rust_call.rs
	rustc --crate-type=cdylib -L $(HEADER_DIR)/ $(CALL_DIR)/rust/rust_call.rs -o $(LIB_DIR)/librust_call.so

$(LIB_DIR)/libswift_call.so $(HEADER_DIR)/swift_call.h: $(CALL_DIR)/swift/swift_call.swift $(CALL_DIR)/swift/swift_call.h
	cp $(CALL_DIR)/swift/swift_call.h $(HEADER_DIR)/
	swiftc $(CALL_DIR)/swift/swift_call.swift -emit-module -emit-library -o $(OBJECT_DIR)/libswift_call.so
	cp $(OBJECT_DIR)/libswift_call.so $(LIB_DIR)/libswift_call.so

$(LIB_DIR)/libzig_call.so $(HEADER_DIR)/zig_call.h: $(CALL_DIR)/zig/zig_call.zig | $(DIR_LIST)
	zig build-lib --library c --cache-dir $(OBJECT_DIR)/call -dynamic -I $(HEADER_DIR)/ $(CALL_DIR)/zig/zig_call.zig -femit-bin=$(OBJECT_DIR)/libzig_call.so
	cp $(OBJECT_DIR)/libzig_call.so $(LIB_DIR)/libzig_call.so
	cp  $(CALL_DIR)/zig/zig_call.h $(HEADER_DIR)/zig_call.h


# ----------
# chain libs
# ----------

$(LIB_DIR)/libada_chain.so $(HEADER_DIR)/ada_chain.h: $(CHAIN_DIR)/ada/ada_chain.adb $(CHAIN_DIR)/ada/ada_chain.ads $(CHAIN_DIR)/ada/ada_chain.h $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/ada/ada_chain.h $(HEADER_DIR)/
	gcc -c -I$(CHAIN_DIR)/ada/ -I- $(CHAIN_DIR)/ada/ada_chain.adb -o $(OBJECT_DIR)/ada_chain.o  -fPIC
	cd $(OBJECT_DIR) && gnatbind -n -a ada_chain -o b~ada_chain.adb
	gcc -fPIC -c -s $(OBJECT_DIR)/b~ada_chain.adb -o $(OBJECT_DIR)/b~ada_chain.o
	gcc -shared -o $(LIB_DIR)/libada_chain.so $(OBJECT_DIR)/ada_chain.o $(OBJECT_DIR)/b~ada_chain.o -lgnat -lgnarl

$(LIB_DIR)/libc_chain.so $(HEADER_DIR)/c_chain.h: $(CHAIN_DIR)/c/c_chain.h $(CHAIN_DIR)/c/c_chain.c $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/c/c_chain.h $(HEADER_DIR)/
	gcc -c -I$(HEADER_DIR) -I$(GHC_INCLUDE) -fPIC $(CHAIN_DIR)/c/c_chain.c -o $(OBJECT_DIR)/c_chain.o
	gcc -shared -o $(LIB_DIR)/libc_chain.so $(OBJECT_DIR)/c_chain.o

$(LIB_DIR)/libcpp_chain.so $(HEADER_DIR)/cpp_chain.h: $(CHAIN_DIR)/c++/cpp_chain.hpp $(CHAIN_DIR)/c++/cpp_chain.cpp $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/c++/cpp_chain.hpp $(HEADER_DIR)/cpp_chain.h
	g++ -c -I$(HEADER_DIR) -I$(GHC_INCLUDE) -fPIC $(CHAIN_DIR)/c++/cpp_chain.cpp -o $(OBJECT_DIR)/cpp_chain.o
	g++ -shared -o $(LIB_DIR)/libcpp_chain.so $(OBJECT_DIR)/cpp_chain.o

$(LIB_DIR)/libcobol_chain.so $(HEADER_DIR)/cobol_chain.h: $(CHAIN_DIR)/cobol/cobol_chain.cob $(CHAIN_DIR)/cobol/cobol_chain.h $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/cobol/cobol_chain.h $(HEADER_DIR)/
	cobc -m -Wall -free -O $(CHAIN_DIR)/cobol/cobol_chain.cob -o $(LIB_DIR)/libcobol_chain.so -L$(LIB_DIR) $(CALL_LIBS_FLAGS) -fimplicit-init

$(LIB_DIR)/libcrystal_chain.so $(HEADER_DIR)/crystal_chain.h: $(CHAIN_DIR)/crystal/crystal_chain.cr $(CHAIN_DIR)/crystal/crystal_chain.h | $(DIR_LIST)
	crystal build --release --no-debug -o $(LIB_DIR)/libcrystal_chain.so --link-flags="-shared" $(CHAIN_DIR)/crystal/crystal_chain.cr
	cp $(CHAIN_DIR)/crystal/crystal_chain.h $(HEADER_DIR)/crystal_chain.h

$(LIB_DIR)/libd_chain.so $(HEADER_DIR)/d_chain.h: $(CHAIN_DIR)/d/d_chain.h $(CHAIN_DIR)/d/d_chain.d $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/d/d_chain.h $(HEADER_DIR)/d_chain.h
	dmd -c $(CHAIN_DIR)/d/d_chain.d -fPIC -of$(OBJECT_DIR)/d_chain.o
	dmd -of$(LIB_DIR)/libd_chain.so $(OBJECT_DIR)/d_chain.o -shared

$(LIB_DIR)/libfortran_chain.so $(HEADER_DIR)/fortran_chain.h: $(CHAIN_DIR)/fortran/fortran_chain.f90 $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/fortran/fortran_chain.h $(HEADER_DIR)/
	gcc -c -I$(HEADER_DIR) -fPIC $(CHAIN_DIR)/fortran/fortran_chain.f90 -o $(OBJECT_DIR)/fortran_chain.o
	gcc -shared -o $(LIB_DIR)/libfortran_chain.so $(OBJECT_DIR)/fortran_chain.o
	rm -rf c_interface.mod

$(LIB_DIR)/libgo_chain.so $(HEADER_DIR)/go_chain.h: $(CHAIN_DIR)/go/go_chain.go $(CALL_HEADERS) | $(DIR_LIST)
	C_INCLUDE_PATH="$(HEADER_DIR):$(GHC_INCLUDE)" go build -o $(LIB_DIR)/libgo_chain.so -buildmode=c-shared $(CHAIN_DIR)/go/go_chain.go
	mv $(LIB_DIR)/libgo_chain.h $(HEADER_DIR)/go_chain.h

$(LIB_DIR)/libhaskell_chain.so $(HEADER_DIR)/haskell_chain.h: $(CHAIN_DIR)/haskell/haskell_chain.hs $(CALL_HEADERS) | $(DIR_LIST)
	rm -f $(OBJECT_DIR)/haskell_chain.hi $(OBJECT_DIR)/haskell_chain.o 
	# forces everything to recompile, else if a call_header changes it gets stuck in a loop where it decides not to compile because it would not change the result everytime it is built
	ghc -dynamic -fPIC -c $(CHAIN_DIR)/haskell/haskell_chain.hs -o $(OBJECT_DIR)/haskell_chain.o -ohi $(OBJECT_DIR)/haskell_chain.hi
	ghc -dynamic -shared -flink-rts $(OBJECT_DIR)/haskell_chain.o -o $(LIB_DIR)/libhaskell_chain.so
	mv $(CHAIN_DIR)/haskell/haskell_chain_stub.h $(HEADER_DIR)/haskell_chain.h || true			# true is required cause ghc does not fail if recompilation doesn't take place but therefor also doesn't generate the header

$(LIB_DIR)/libjava_chain.so $(LIB_DIR)/libr_java_chain.so $(HEADER_DIR)/java_chain.h $(HEADER_DIR)/r_java_chain.h: $(CHAIN_DIR)/java/r_java_chain.java $(CHAIN_DIR)/java/java_chain.c $(CHAIN_DIR)/java/java_chain.h | $(DIR_LIST)
	javac $(CHAIN_DIR)/java/r_java_chain.java -d $(OBJECT_DIR)/r_java_chain
	(cd $(OBJECT_DIR)/r_java_chain && /usr/lib/jvm/default/bin/native-image --shared -H:Name=libfoobar)
	mv $(OBJECT_DIR)/r_java_chain/graal_isolate.h $(HEADER_DIR)/graal_isolate.h
	mv $(OBJECT_DIR)/r_java_chain/libfoobar.h $(HEADER_DIR)/r_java_chain.h
	mv $(OBJECT_DIR)/r_java_chain/libfoobar.so $(LIB_DIR)/libr_java_chain.so
	cp $(CHAIN_DIR)/java/java_chain.h $(HEADER_DIR)/
	
	gcc -c -I$(HEADER_DIR) -FPIC $(CHAIN_DIR)/java/java_chain.c -o $(OBJECT_DIR)/java_chain.o
	gcc -shared -o $(LIB_DIR)/libjava_chain.so $(OBJECT_DIR)/java_chain.o

$(LIB_DIR)/libjulia_chain.so $(HEADER_DIR)/julia_chain.h: $(CHAIN_DIR)/julia/src/julia_chain.jl $(CHAIN_DIR)/julia/julia_chain.h $(CALL_LIBS) | $(DIR_LIST)
	julia -e 'using Pkg; Pkg.activate("$(CHAIN_DIR)/julia/"); using PackageCompiler; create_library("$(CHAIN_DIR)/julia/", "$(OBJECT_DIR)/julia_chain", lib_name="libjulia_chain", force=true, incremental=false, filter_stdlibs=true)'
	cp $(OBJECT_DIR)/julia_chain/lib/*.so $(LIB_DIR)/
	cp $(CHAIN_DIR)/julia/julia_chain.h $(HEADER_DIR)/julia_chain.h

$(LIB_DIR)/libkotlin_chain.so $(LIB_DIR)/libr_kotlin_chain.so $(HEADER_DIR)/kotlin_chain.h $(HEADER_DIR)/r_kotlin_chain.h: $(CHAIN_DIR)/kotlin/r_kotlin_chain.kt $(CHAIN_DIR)/kotlin/kotlin_chain.c $(CHAIN_DIR)/kotlin/kotlin_chain.h $(KOTLIN_CALL_HEADERS) | $(DIR_LIST)
	kotlinc-native -produce dynamic -o $(OBJECT_DIR)/r_kotlin_chain $(CHAIN_DIR)/kotlin/r_kotlin_chain.kt $(foreach HEADER,$(KOTLIN_CALL_HEADERS), -library $(HEADER))
	mv $(OBJECT_DIR)/libr_kotlin_chain.so $(LIB_DIR)/libr_kotlin_chain.so
	mv $(OBJECT_DIR)/r_kotlin_chain_api.h $(HEADER_DIR)/r_kotlin_chain.h

	gcc -c -I$(HEADER_DIR) -FPIC $(CHAIN_DIR)/kotlin/kotlin_chain.c -o $(OBJECT_DIR)/kotlin_chain.o
	gcc -shared -o $(LIB_DIR)/libkotlin_chain.so $(OBJECT_DIR)/kotlin_chain.o
	cp $(CHAIN_DIR)/kotlin/kotlin_chain.h $(HEADER_DIR)/

$(LIB_DIR)/libnim_chain.so $(HEADER_DIR)/nim_chain.h: $(CHAIN_DIR)/nim/nim_chain.nim $(CALL_HEADERS) | $(DIR_LIST)
	nim c --app=lib --noMain --header:nim_chain.h -o:$(LIB_DIR)/libnim_chain.so $(CHAIN_DIR)/nim/nim_chain.nim 
	cp ~/.cache/nim/nim_chain_d/nim_chain.h $(HEADER_DIR)/nim_chain.h

$(LIB_DIR)/liboc_chain.so $(HEADER_DIR)/oc_chain.h: $(CHAIN_DIR)/objective-c/oc_chain.m $(CHAIN_DIR)/objective-c/oc_chain.h $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/objective-c/oc_chain.h $(HEADER_DIR)/
	gcc -c -I$(HEADER_DIR) -I$(GHC_INCLUDE) -fPIC $(CHAIN_DIR)/objective-c/oc_chain.m -o $(OBJECT_DIR)/oc_chain.o
	gcc -shared -o $(LIB_DIR)/liboc_chain.so $(OBJECT_DIR)/oc_chain.o

$(LIB_DIR)/libodin_chain.so $(HEADER_DIR)/odin_chain.h: $(CHAIN_DIR)/odin/odin_chain.odin $(CHAIN_DIR)/odin/odin_chain.h $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/odin/odin_chain.h $(HEADER_DIR)/
	odin build $(CHAIN_DIR)/odin/odin_chain.odin -file -build-mode:shared -out=$(LIB_DIR)/libodin_chain.so

$(LIB_DIR)/libpascal_chain.so $(HEADER_DIR)/pascal_chain.h: $(CHAIN_DIR)/pascal/pascal_chain.pp $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/pascal/pascal_chain.h $(HEADER_DIR)/
	fpc $(CHAIN_DIR)/pascal/pascal_chain.pp -FE$(OBJECT_DIR)/
	cp $(OBJECT_DIR)/libpascal_chain.so $(LIB_DIR)/libpascal_chain.so

$(LIB_DIR)/librust_chain.so: $(CHAIN_DIR)/rust/rust_chain.rs $(CALL_HEADERS) $(RUST_CALL_HEADERS) | $(DIR_LIST)
	rustc --crate-type=cdylib -L $(HEADER_DIR)/ $(CHAIN_DIR)/rust/rust_chain.rs -o $(LIB_DIR)/librust_chain.so

$(HEADER_DIR)/rust_chain.h: $(CHAIN_DIR)/rust/rust_chain.rs | $(DIR_LIST)
	cbindgen --output $(HEADER_DIR)/rust_chain.h --lang c $(CHAIN_DIR)/rust/rust_chain.rs

$(LIB_DIR)/libswift_chain.so $(HEADER_DIR)/swift_chain.h: $(CHAIN_DIR)/swift/swift_chain.swift $(CALL_HEADERS) | $(DIR_LIST)
	cp $(CHAIN_DIR)/swift/swift_chain.h $(HEADER_DIR)/
	swiftc $(CHAIN_DIR)/swift/swift_chain.swift -emit-module -emit-library -o $(OBJECT_DIR)/libswift_chain.so -import-objc-header $(CHAIN_DIR)/swift/swift_external_header.h
	cp $(OBJECT_DIR)/libswift_chain.so $(LIB_DIR)/libswift_chain.so

$(LIB_DIR)/libzig_chain.so $(HEADER_DIR)/zig_chain.h: $(CHAIN_DIR)/zig/zig_chain.zig $(CALL_HEADERS) | $(DIR_LIST)
	zig build-lib --library c -dynamic --cache-dir $(OBJECT_DIR)/chain -I /usr/include/ -I $(HEADER_DIR)/ -I $(GHC_INCLUDE) $(CHAIN_DIR)/zig/zig_chain.zig -femit-bin=$(OBJECT_DIR)/libzig_chain.so
	cp $(OBJECT_DIR)/libzig_chain.so $(LIB_DIR)/libzig_chain.so
	cp $(CHAIN_DIR)/zig/zig_chain.h $(HEADER_DIR)/zig_chain.h

# ------------
# rust headers
# ------------

$(RUST_DIR)/%.rs: $(HEADER_DIR)/%.h | $(DIR_LIST)
	bindgen $< -o $@

$(RUST_DIR)/haskell_call.rs: $(HEADER_DIR)/haskell_call.h | $(DIR_LIST)
	bindgen $< -o $@ -- -I$(GHC_INCLUDE)

# --------------
# kotlin headers
# --------------

$(KOTLIN_DIR)/%.klib: $(HEADER_DIR)/%.h | $(DIR_LIST)
	cinterop -header $< -pkg $* -o $@

$(KOTLIN_DIR)/haskell_call.klib: $(HEADER_DIR)/haskell_call.h | $(DIR_LIST)
	cinterop -header $< -pkg haskell_call -o $@ -compiler-options -I$(GHC_INCLUDE)

$(KOTLIN_DIR)/nim_call.klib: $(HEADER_DIR)/nim_call.h | $(DIR_LIST)
	cinterop -header $< -pkg nim_call -o $@ -compiler-options -I$(BASE_INCLUDE)

# -------
# folders
# -------

$(DIR_LIST):
	mkdir -p $(DIR_LIST)

# -----
# other
# -----

run: build/main
	LD_LIBRARY_PATH="$(LIB_DIR):$(GHC_LIB_DIR):$(JULIA_LIB_DIR):$LD_LIBRARY_PATH" $(BUILD_DIR)/$(EXE_NAME)

run_test: run_call_tests run_chain_tests

run_call_tests: $(CALL_TEST_EXES)
	LD_LIBRARY_PATH="$(LIB_DIR):$(GHC_LIB_DIR):$(JULIA_LIB_DIR):$LD_LIBRARY_PATH" bash $(TEST_DIR)/call_test_runner.sh $(LANGUAGES)

run_chain_tests: $(CHAIN_TEST_EXES)
	LD_LIBRARY_PATH="$(LIB_DIR):$(GHC_LIB_DIR):$(JULIA_LIB_DIR):$LD_LIBRARY_PATH" bash $(TEST_DIR)/chain_test_runner.sh $(LANGUAGES)

clean:
	rm -rf build

.PHONY: clean run run_test run_call_tests run_chain_tests
