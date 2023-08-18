module HaskellChain where

import Foreign.C.String

foreign import ccall "ada_call.h call_ada" call_ada :: CString -> IO()
foreign import ccall "c_call.h call_c" call_c :: CString -> IO()
foreign import ccall "cpp_call.h call_cpp" call_cpp :: CString -> IO()
foreign import ccall "cobol_call.h call_cobol" call_cobol :: CString -> IO()
foreign import ccall "d_call.h call_d" call_d :: CString -> IO()
foreign import ccall "fortran_call.h call_fortran" call_fortran :: CString -> IO()
foreign import ccall "go_call.h call_go" call_go :: CString -> IO()
foreign import ccall "haskell_call.h call_haskell" call_haskell :: CString -> IO()
foreign import ccall "nim_call.h call_nim" call_nim :: CString -> IO()
foreign import ccall "oc_call.h call_oc" call_oc :: CString -> IO()
foreign import ccall "odin_call.h call_odin" call_odin :: CString -> IO()
foreign import ccall "pascal_call.h call_pascal" call_pascal :: CString -> IO()
foreign import ccall "rust_call.h call_rust" call_rust :: CString -> IO()
foreign import ccall "swift_call.h call_swift" call_swift :: CString -> IO()
foreign import ccall "zig_call.h call_zig" call_zig :: CString -> IO()

start_haskell_chain ::  IO ()
start_haskell_chain = do
    ada_text <- newCString "ada called by haskell"
    call_ada ada_text
    c_text <- newCString "c called by haskell"
    call_c c_text
    cpp_text <- newCString "c++ called by haskell"
    call_cpp cpp_text
    cobol_text <- newCString "cobol called by haskell"
    call_cobol cobol_text
    d_text <- newCString "d called by haskell"
    call_d d_text
    fortran_text <- newCString "fortran called by haskell"
    call_fortran fortran_text
    go_text <- newCString "go called by haskell"
    call_go go_text
    haskell_text <- newCString "haskell called by haskell"
    call_haskell haskell_text
    nim_text <- newCString "nim called by haskell"
    call_nim nim_text
    oc_text <- newCString "oc called by haskell"
    call_oc oc_text
    odin_text <- newCString "odin called by haskell"
    call_odin odin_text
    pascal_text <- newCString "pascal called by haskell"
    call_pascal pascal_text
    rust_text <- newCString "rust called by haskell"
    call_rust rust_text
    swift_text <- newCString "swift called by haskell"
    call_swift swift_text
    zig_text <- newCString "zig called by haskell"
    call_zig zig_text

foreign export ccall
    start_haskell_chain :: IO ()
