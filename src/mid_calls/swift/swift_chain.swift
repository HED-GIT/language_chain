@_cdecl("start_swift_chain")
public func start_swift_chain(){
    "ada called by swift".withCString { cstr in
        call_ada(UnsafeMutablePointer(mutating: cstr))
    }
    "c called by swift".withCString { cstr in
        call_c(UnsafeMutablePointer(mutating: cstr))
    }
    "cpp called by swift".withCString { cstr in
        call_cpp(UnsafeMutablePointer(mutating: cstr))
    }
    "cobol called by swift".withCString { cstr in
        call_cobol(UnsafeMutablePointer(mutating: cstr))
    }
    "crystal called by swift".withCString { cstr in
        call_crystal(UnsafeMutablePointer(mutating: cstr))
    }
    "d called by swift".withCString { cstr in
        call_d(UnsafeMutablePointer(mutating: cstr))
    }
    "fortran called by swift".withCString { cstr in
        call_fortran(UnsafeMutablePointer(mutating: cstr))
    }
    "go called by swift".withCString { cstr in
        call_go(UnsafeMutablePointer(mutating: cstr))
    }
    "haskell called by swift".withCString { cstr in
        call_haskell(UnsafeMutablePointer(mutating: cstr))
    }
    "java called by swift".withCString { cstr in
        call_java(UnsafeMutablePointer(mutating: cstr))
    }
    "kotlin called by swift".withCString { cstr in
        call_kotlin(UnsafeMutablePointer(mutating: cstr))
    }
    "nim called by swift".withCString { cstr in
        call_nim(UnsafeMutablePointer(mutating: cstr))
    }
    "oc called by swift".withCString { cstr in
        call_oc(UnsafeMutablePointer(mutating: cstr))
    }
    "odin called by swift".withCString { cstr in
        call_odin(UnsafeMutablePointer(mutating: cstr))
    }
    "pascal called by swift".withCString { cstr in
        call_pascal(UnsafeMutablePointer(mutating: cstr))
    }
    "rust called by swift".withCString { cstr in
        call_rust(UnsafeMutablePointer(mutating: cstr))
    }
    "swift called by swift".withCString { cstr in
        call_swift(UnsafeMutablePointer(mutating: cstr))
    }
    "zig called by swift".withCString { cstr in
        call_zig(UnsafeMutablePointer(mutating: cstr))
    }
}