!
! Copyright (c) 2019, Advanced Micro Devices, Inc. All rights reserved.
!
! CPUPC-2013: F2008-Exit statement-Execution control
!
! Date of Modification: 23rd Sep 2019
!
! CPUPC-2013: Testing 'NAMED' SELECT TYPE construct.
!
PROGRAM EXIT06
  IMPLICIT NONE
  INTEGER, PARAMETER :: N = 1
  LOGICAL EXP(N), RES(N)
  CHARACTER(10), DIMENSION(3), TARGET :: A = (/'Hello', 'Bello', 'Cello'/)
  INTEGER, DIMENSION(5), TARGET :: B = (/1, 2, 3, 4, 5/)
  REAL, DIMENSION(4), TARGET :: C = (/22.3, 33.2, 44.5, 55.4/)
  LOGICAL, DIMENSION(2), TARGET :: D = (/.TRUE., .FALSE./)

  CALL SIMPLE_SELECT(A, B, C, D)
	! To be uncommented when this feature is available
  !CALL NAMED_SELECT(A, B, C, D)

	CALL CHECK(RES, EXP, N)
  PRINT *, 'PROGRAM EXITED NORMALLY'
END PROGRAM

IMPURE SUBROUTINE SIMPLE_SELECT(M, N, O, P)
  IMPLICIT NONE
  CHARACTER(10), DIMENSION(3), TARGET, INTENT(IN) :: M
  INTEGER, DIMENSION(5), TARGET, INTENT(IN) :: N
  REAL, DIMENSION(4), TARGET, INTENT(IN) :: O
  LOGICAL, DIMENSION(2), TARGET, INTENT(IN) :: P
  CLASS(*), POINTER, DIMENSION(:) :: X
  INTEGER I

  PRINT *, 'TESTING SIMPLE_SELECT'
  DO I = 1, 5
    SELECT CASE (I)
      CASE (1)
        X => M
      CASE (2)
        X => N
      CASE (3)
        X => O
      CASE (4)
        X => P
      CASE DEFAULT
        X => NULL()
    END SELECT

    SELECT TYPE (X)
    TYPE IS (CHARACTER(*))
      PRINT *, 'TYPE(X) = CHARACTER(*)'
    TYPE IS (INTEGER)
      PRINT *, 'TYPE(X) = INTEGER'
    TYPE IS (REAL)
      PRINT *, 'TYPE(X) = REAL'
    TYPE IS (LOGICAL)
      PRINT *, 'TYPE(X) = LOGICAL'
    CLASS DEFAULT
      PRINT *, 'EXITING SELECT'
      EXIT
    END SELECT
    PRINT *, 'AFTER END SELECT'
  END DO
  PRINT *, 'AFTER END DO'

  PRINT *, 'SUBROUTINE SIMPLE_SELECT EXITED NORMALLY'
END SUBROUTINE

IMPURE SUBROUTINE NAMED_SELECT(M, N, O, P)
  IMPLICIT NONE
  CHARACTER(10), DIMENSION(3), TARGET, INTENT(IN) :: M
  INTEGER, DIMENSION(5), TARGET, INTENT(IN) :: N
  REAL, DIMENSION(4), TARGET, INTENT(IN) :: O
  LOGICAL, DIMENSION(2), TARGET, INTENT(IN) :: P
  CLASS(*), POINTER, DIMENSION(:) :: X
  INTEGER I

  PRINT *, 'TESTING NAMED_SELECT'

  DO I = 1, 5
    SELECT CASE (I)
      CASE (1)
        X => M
      CASE (2)
        X => N
      CASE (3)
        X => O
      CASE (4)
        X => P
      CASE DEFAULT
        X => NULL()
    END SELECT

		! To be uncommented when the feature is implemented
    !SCS: SELECT TYPE (X)
    SELECT TYPE (X)
    TYPE IS (CHARACTER(*))
      PRINT *, 'TYPE(X) = CHARACTER(*)'
    TYPE IS (INTEGER)
      PRINT *, 'TYPE(X) = INTEGER'
    TYPE IS (REAL)
      PRINT *, 'TYPE(X) = REAL'
    TYPE IS (LOGICAL)
      PRINT *, 'TYPE(X) = LOGICAL'
    CLASS DEFAULT
      PRINT *, 'EXITING SELECT'
		! To be uncommented when the feature is implemented
    !  EXIT SCS
    !END SELECT SCS
    END SELECT
    PRINT *, 'AFTER END SELECT'
  END DO
  PRINT *, 'AFTER END DO'

  PRINT *, 'SUBROUTINE NAMED_SELECT EXITED NORMALLY'
END SUBROUTINE