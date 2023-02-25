@_cdecl("start_swift_chain")
public func start_swift_chain(){
    "c called from swift".withCString { cstr in
        call_c(UnsafeMutablePointer(mutating: cstr))
    }
    "c++ called from swift".withCString { cstr in
        call_cpp(UnsafeMutablePointer(mutating: cstr))
    }
    "rust called from swift".withCString { cstr in
        call_rust(UnsafeMutablePointer(mutating: cstr))
    }
    "go called from swift".withCString { cstr in
        call_go(UnsafeMutablePointer(mutating: cstr))
    }
    "d called from swift".withCString { cstr in
        call_d(UnsafeMutablePointer(mutating: cstr))
    }
    "zig called from swift".withCString { cstr in
        call_zig(UnsafeMutablePointer(mutating: cstr))
    }
    "nim called from swift".withCString { cstr in
        call_nim(UnsafeMutablePointer(mutating: cstr))
    }
    "oc called from swift".withCString { cstr in
        call_oc(UnsafeMutablePointer(mutating: cstr))
    }
    "swift called from swift".withCString { cstr in
        call_swift(UnsafeMutablePointer(mutating: cstr))
    }
    "pascal called from swift".withCString { cstr in
        call_pascal(UnsafeMutablePointer(mutating: cstr))
    }
    "fortran called from swift".withCString { cstr in
        call_fortran(UnsafeMutablePointer(mutating: cstr))
    }
    "ada called from swift".withCString { cstr in
        call_ada(UnsafeMutablePointer(mutating: cstr))
    }
}