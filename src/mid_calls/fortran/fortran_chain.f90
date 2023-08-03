module c_interface
    interface
        subroutine call_ada(a) bind(C, name='call_ada')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_ada

        subroutine call_c(a) bind(C, name='call_c')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_c

        subroutine call_cpp(a) bind(C, name='call_cpp')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_cpp

        subroutine call_cobol(a) bind(C, name='call_cobol')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_cobol

        subroutine call_d(a) bind(C, name='call_d')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_d

        subroutine call_fortran(a) bind(C, name='call_fortran')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_fortran

        subroutine call_go(a) bind(C, name='call_go')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_go

        subroutine call_nim(a) bind(C, name='call_nim')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_nim

        subroutine call_oc(a) bind(C, name='call_oc')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_oc

        subroutine call_odin(a) bind(C, name='call_odin')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_odin

        subroutine call_pascal(a) bind(C, name='call_pascal')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_pascal

        subroutine call_rust(a) bind(C, name='call_rust')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_rust

        subroutine call_swift(a) bind(C, name='call_swift')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_swift

        subroutine call_zig(a) bind(C, name='call_zig')
            use, intrinsic :: iso_c_binding
            character(kind=c_char),dimension (*) :: a
        end subroutine call_zig

    end interface
end module c_interface


subroutine start_fortran_chain() bind ( C, name='start_fortran_chain')
    use c_interface

    call call_ada('ada called by fortran'//char(0));
    call call_c('c called by fortran'//char(0));
    call call_cpp('c++ called by fortran'//char(0));
    call call_cobol('cobol called by fortran'//char(0));
    call call_d('d called by fortran'//char(0));
    call call_fortran('fortran called by fortran'//char(0));
    call call_go('go called by fortran'//char(0));
    call call_nim('nim called by fortran'//char(0));
    call call_oc('oc called by fortran'//char(0));
    call call_pascal('pascal called by fortran'//char(0));
    call call_rust('rust called by fortran'//char(0));
    call call_swift('swift called by fortran'//char(0));
    call call_zig('zig called by fortran'//char(0));
    return
end subroutine start_fortran_chain