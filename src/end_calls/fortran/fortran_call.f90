subroutine call_fortran(instr) bind ( C, name="call_fortran")
    use, intrinsic :: iso_c_binding
    character(kind=c_char), dimension(*), intent(IN) :: instr
    integer :: len
    integer :: i


    len=0
    do
       if (instr(len+1) == C_NULL_CHAR) exit
       write(*,'(A)', advance="no") (instr(len))
       len = len + 1
    end do
    write(*,'(A)') (instr(len))

end subroutine call_fortran