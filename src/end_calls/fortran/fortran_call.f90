subroutine call_fortran(instr) bind ( C, name="call_fortran")
    use, intrinsic :: iso_c_binding
    character(kind=c_char), dimension(*), intent(IN) :: instr
    integer :: len

    len=0
    do
       if (instr(len+1) == C_NULL_CHAR) exit
       len = len + 1
    end do
    write(*,'(A)') instr(1:len)
end subroutine call_fortran