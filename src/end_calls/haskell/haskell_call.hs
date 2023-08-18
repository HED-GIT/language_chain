module HasekellCall where

import Foreign.C.String
import System.IO

call_haskell :: CString -> IO()
call_haskell x = do
    hx <- peekCString x
    putStrLn hx
    hFlush stdout

foreign export ccall
    call_haskell :: CString -> IO()
