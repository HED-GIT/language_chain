@_cdecl("start_swift_chain")
public func start_swift_chain(){
    "ada called from swift".withCString { cstr in
        call_ada(UnsafeMutablePointer(mutating: cstr))
    }
    "c called from swift".withCString { cstr in
        call_c(UnsafeMutablePointer(mutating: cstr))
    }
    "c++ called from swift".withCString { cstr in
        call_cpp(UnsafeMutablePointer(mutating: cstr))
    }
    "cobol called from swift".withCString { cstr in
        call_cobol(UnsafeMutablePointer(mutating: cstr))
    }
    "d called from swift".withCString { cstr in
        call_d(UnsafeMutablePointer(mutating: cstr))
    }
    "fortran called from swift".withCString { cstr in
        call_fortran(UnsafeMutablePointer(mutating: cstr))
    }
    "go called from swift".withCString { cstr in
        call_go(UnsafeMutablePointer(mutating: cstr))
    }
    "haskell called from swift".withCString { cstr in
        call_haskell(UnsafeMutablePointer(mutating: cstr))
    }
    "nim called from swift".withCString { cstr in
        call_nim(UnsafeMutablePointer(mutating: cstr))
    }
    "oc called from swift".withCString { cstr in
        call_oc(UnsafeMutablePointer(mutating: cstr))
    }
    "odin called from swift".withCString { cstr in
        call_odin(UnsafeMutablePointer(mutating: cstr))
    }
    "pascal called from swift".withCString { cstr in
        call_pascal(UnsafeMutablePointer(mutating: cstr))
    }
    "rust called from swift".withCString { cstr in
        call_rust(UnsafeMutablePointer(mutating: cstr))
    }
    "swift called from swift".withCString { cstr in
        call_swift(UnsafeMutablePointer(mutating: cstr))
    }
    "zig called from swift".withCString { cstr in
        call_zig(UnsafeMutablePointer(mutating: cstr))
    }
}