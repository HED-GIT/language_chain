subroutine call_fortran(instr) bind ( C, name="call_fortran")
    use, intrinsic :: iso_c_binding
    character(kind=c_char), dimension(*), intent(IN) :: instr
    integer :: len

    len=0
    do
        if (instr(len+1) == C_NULL_CHAR) exit
        len = len + 1
        write(*,'(A)', advance="no") (instr(len))
    end do
    write(*,*)
    call flush(1)
end subroutine call_fortran