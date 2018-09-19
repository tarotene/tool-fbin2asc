PROGRAM bin2asc
  USE procs
  
  IMPLICIT NONE

	INTEGER(4) :: ilx, ily, ilt0, ilt1, ilt2, ilt3, vel
  DOUBLE PRECISION :: dkbt, dprob
  INTEGER(4), ALLOCATABLE :: ispin(:,:)
  CHARACTER(len=30) :: sxbc, sybc, sinitst, sfield
  CHARACTER(len=60) :: sdirsnap, sdirem
  CHARACTER(len=60), ALLOCATABLE :: sfilesnap1(:), sfilesnap3(:)

  INTEGER(4) :: j, k, l

  READ(*,*) ilx, ily, ilt0, ilt1, ilt2, ilt3, dkbt, vel, sxbc, sybc, sinitst, sfield

  ALLOCATE(sfilesnap1(1:ilt1),sfilesnap3(1:ilt3))
  
  CALL convertParamDirname(ilx,ily,ilt0,ilt1,dkbt,sxbc,sybc,sdirsnap,sdirem)
  CALL convertTimeFilesnap(ilt1,ilt3,sfilesnap1(1:),sfilesnap3(1:))

	ALLOCATE(ispin(1:ilx,1:ily))
	ispin(1:ilx,1:ily) = 0

  sweeps1: DO j = 1, ilt1, 1
    !  WRITE(st,'(i0.9)') t
    !  OPEN(unit=10,file=TRIM(sdirsnap)//"/"//sfilesnap1(j)//"/"//".bin",status="replace",action="write",access="stream",form="unformatted")
    !  WRITE(unit=10) ispin(1:ilx,1:ily)
    !  CLOSE(unit=10)
     OPEN(unit=11,file=TRIM(sdirsnap)//"/"//sfilesnap1(j)//"/"//".bin",status="old",action="read",access="stream",form="unformatted")
     OPEN(unit=10,file=TRIM(sdirsnap)//"/_"//sfilesnap1(j)//"/"//".dat",status="replace",action="write",access="sequential",form="formatted")
     READ(unit=11) ispin(1:ilx,1:ily)
		 snapshot1: DO l = 1, ily, 1
        DO k = 1, ilx, 1
           WRITE(unit=10, fmt=*) k, l, ispin(k,l)
        END DO
        WRITE(unit=10,fmt='()')
     END DO snapshot1
     CLOSE(unit=11)
		 CLOSE(unit=10)
  END DO sweeps1

  sweeps3: DO j = 1, ilt3, 1
    !  WRITE(st,'(i0.9)') t
    !  OPEN(unit=10,file=TRIM(sdirsnap)//"/"//sfilesnap1(j)//"/"//".bin",status="replace",action="write",access="stream",form="unformatted")
    !  WRITE(unit=10) ispin(1:ilx,1:ily)
    !  CLOSE(unit=10)
     OPEN(unit=11,file=TRIM(sdirsnap)//"/"//sfilesnap3(j)//"/"//".bin",status="old",action="read",access="stream",form="unformatted")
     OPEN(unit=10,file=TRIM(sdirsnap)//"/_"//sfilesnap3(j)//"/"//".dat",status="replace",action="write",access="sequential",form="formatted")
     READ(unit=11) ispin(1:ilx,1:ily)
		 snapshot3: DO l = 1, ily, 1
        DO k = 1, ilx, 1
           WRITE(unit=10, fmt=*) k, l, ispin(k,l)
        END DO
        WRITE(unit=10,fmt='()')
     END DO snapshot3
     CLOSE(unit=11)
		 CLOSE(unit=10)
  END DO sweeps3
END PROGRAM bin2asc
