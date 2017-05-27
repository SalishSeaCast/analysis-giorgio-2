# Process this file with autoconf to produce a configure script.
##
## If you change this script, submit these commands after change(s) :
## aclocal ; automake ; autoconf     
################################################################
## configure.ac file for the ARIANE application.
##
## Nicolas.Grima@univ-brest.fr
## April 2009
##
################################################################
#
#################################################################################
# Initialization calls
#################################################################################
## Initialize autoconf with name of project, version, bug report and support
## email address.
AC_INIT([Ariane],[2.2.6_00],[Bruno.Blanke@univ-brest.fr or Nicolas.Grima@univ-brest.fr])
#
## Ensure that a recent enough version of Autotconf is being used.
AC_PREREQ([2.59])
#
## Revision stamp from configure.ac into configure.
AC_REVISION($Revision: 0.2.0 $)
#
## Set the directory that contains support scripts such as install-sh and
## config.guess
AC_CONFIG_AUX_DIR(./confdb)
#
AM_INIT_AUTOMAKE
#
## Compute the canonical host-system type variable "host".
AC_CANONICAL_HOST
#
#################################################################################
# Checks for programs.
#################################################################################
##
## Safety check that correct --srcdir was specified
AC_CONFIG_SRCDIR([./src/ariane/ariane.f90])
#
#################################################################################
# Checks for typedefs, structures, and compiler characteristics.
#################################################################################
AC_PROG_INSTALL
#
## Configue argument definition.
## AC_ARG_ENABLE(..,..,etc)
#
## OPTIMIZATION LEVELS
##
AC_ARG_ENABLE(
    optimization,
    [  --enable-optimization=level - Control optimization level.
                             The following levels are supported.
       debug     - debugging compiler options will be selected.
       normal    - soft optimization (default).
       aggressive - aggressive optimization (YOU HAVE TO VERIFY YOUR RESULTS!).],
    ,
    enable_optimization=normal
             )
#
## PROFILING (if it is available)
##
AC_ARG_ENABLE(
    profiling,
    [  --enable-profiling - Turn on profiling compiler options.],
    enable_prof=yes,
    enable_prof=no
             )
#
## Quad precision (if it is available)
##
AC_ARG_ENABLE(
    quad,
    [  --enable-quad - Turn on quad precision for one varaible in Ariane.
                       This options allows to have same results on different
                       platform.],
    enable_quad=yes,
    enable_quad=no
             )
#
## Hdf5 if it is need for Netcdf4
##
AC_ARG_ENABLE(
    hdf5,
    [  --enable-hdf5 - HDF5 for Netcdf 4.],
    enable_hdf5=yes,
    enable_hdf5=no
             )

##################################
## Check for a Fortran compiler ##
##################################
AC_LANG(Fortran)
#------------------------------------------------------------------------
# list of Fortran compilers extracted from the NetCDF configure.in file.
#------------------------------------------------------------------------
# f90 is a generic name for Fortran compilers. 
# Host must be tested to choose right options.
#    - SGI (Irix OS)
#    - HP-Compaq Alpha/Server (Tru64 OS)
#    - NEC-SX (SUPER-UX OS)
# pgf90 are the Portland Group F77 and F90 compilers.
# xlf90/xlf95 are IBM (AIX) F90/F95 compilers.
# lf95 is the Lahey-Fujitsu compiler.
# fort is the Compaq Fortran 90 (now 95) compiler for Linux/Alpha (not TRU64).
# pathf90 is the Pathscale Fortran 90 compiler.
# ifort is another name for the Inten f90 compiler.
# efc - An older Intel compiler (?).
# ifc - An older Intel compiler.
# g95 is the GNU Fortran compiler.
# f95 is a generic name for Fortran 95 compiler (not tested).
#-----------------------------------------------------------------------------
AC_PROG_FC(ifort fort xlf90 pgf90 epcf90 pathf90 ifc efc f90 xlf95 lf95 f95 gfortran g95)
if test -n "$FC" ; then 
  case "$FC" in
##    GENERIC FORTRAN COMPILER (SGI-IRIX, HP-TRUE64, NEC-SX )
      f90)
        case "$host" in
        *-sgi-irix*)
          case "$enable_optimization" in
	    debug)
              AC_MSG_NOTICE([  -> DEBUGGING OPTIONS are SELECTED])
              FCFLAGS="-g -O0 -C -fullwarn -DEBUG:trap_uninitialized=ON:subscript_check=ON"
              LDFLAGS="-g"
            ;;
            aggressive)
              AC_MSG_NOTICE([  -> AGGRESSIVE COMPILER OPTIONS are SELECTED])
    	      FCFLAGS="-g3 -O3 -ipa -listing"
              LDFLAGS="-g3"
            ;;
            normal|*)
              AC_MSG_NOTICE([  -> NORMAL MODE])
	      FCFLAGS="-g3 -O2 -listing"
              LDFLAGS="-g3"
	    ;;
          esac
	  if test "$enable_prof" = "yes" ; then
            AC_MSG_WARN([!!! NO PROFILING COMPILER OPTIONS ON IRIX SYSTEM !!!])
            AC_MSG_WARN([!!!        PLEASE READ SPEEDSHOP MANUAL          !!!])
          fi
        ;;
        alpha*-dec-osf*)
          case "$enable_optimization" in
	    debug)
              AC_MSG_NOTICE([  -> DEBUGGING OPTIONS are SELECTED])
              FCFLAGS="-V -ladebug -g -O0 -C -check overflow -check underflow -warn nouninitialized -warn argument_checking"
              LDFLAGS="-ladebug -g"
            ;;
            aggressive)
              AC_MSG_NOTICE([  -> AGGRESSIVE COMPILER OPTIONS are SELECTED])
    	      FCFLAGS="-V -g3 -fast -math_library fast"
              LDFLAGS="-g3 -fast -math_library fast"
            ;;
            normal|*)
              AC_MSG_NOTICE([  -> NORMAL MODE])
	      FCFLAGS="-V -g3 -O"
              LDFLAGS=""
	    ;;
          esac
	  if test "$enable_prof" = "yes" ; then
            AC_MSG_NOTICE([  -> PROFILING is SELECTED (gprof)])
            FCFLAGS="-pg $FCFLAGS"
            LDFLAGS="-pg $LDFLAGS"
          fi
        ;;
        *nec*superux*)
          case "$enable_optimization" in
	    debug)
              AC_MSG_NOTICE([  -> DEBUGGING OPTIONS are SELECTED])
              FCFLAGS='-C debug -eR -eP -R1 -R5 -Wf"-L nostdout" -Wf"-L source mrgmsg" -Wf"-L summary" -Wf"-init stack=nan" -Wf"-init heap=nan" -Wl"-f nan" Wf"-msg d" -Wf"-msg o"'
              LDFLAGS="-C debug"
            ;;
            aggressive)
              AC_MSG_NOTICE([  -> AGGRESSIVE COMPILER OPTIONS are SELECTED])
    	      FCFLAGS='-C hopt -R1 -R5 -Wf"-L nostdout"  -Wf"-L summary" -Wf"-pvctl fullmsg" -Wf"-O infomsg"'
              LDFLAGS="-C hopt"
            ;;
            normal|*)
              AC_MSG_NOTICE([  -> NORMAL MODE])
	      FCFLAGS='-R1 -R5 -Wf"-L nostdout"  -Wf"-L summary" -Wf"-pvctl fullmsg" -Wf"-O infomsg"'
              LDFLAGS=""
	    ;;
          esac
	  if test "$enable_prof" = "yes" ; then
            AC_MSG_NOTICE([  -> PROFILING is SELECTED (gprof)])
            FCFLAGS="-ftrace $FCFLAGS"
            LDFLAGS="-ftrace $LDFLAGS"
          fi
	;;
        *solaris*)
          case "$enable_optimization" in
	    debug)
              AC_MSG_NOTICE([  -> DEBUGGING OPTIONS are SELECTED])
              FCFLAGS="-g -C -stackvar -w4"
              LDFLAGS="-g "
            ;;
            aggressive)
              AC_MSG_NOTICE([  -> AGGRESSIVE COMPILER OPTIONS are SELECTED])
    	      FCFLAGS="-O5 -fast"
              LDFLAGS=""
            ;;
            normal|*)
              AC_MSG_NOTICE([  -> NORMAL MODE])
	      FCFLAGS="-O2"
              LDFLAGS=""
	    ;;
          esac
	  if test "$enable_prof" = "yes" ; then
            AC_MSG_NOTICE([  -> PROFILING is SELECTED (prof)])
            FCFLAGS="-p $FCFLAGS"
            LDFLAGS="-p $LDFLAGS"
          fi
        ;;
        *)
          AC_MSG_WARN([Ariane MSG: !!! HOST and/or SYSTEM is UNKNOWN : $host !!!])
        ;;
        esac
        ;;
##    INTEL FORTRAN COMPILER on LINUX OPERATING SYSTEM
      ifort|efc|ifc)
	case "$enable_optimization" in
	  debug)
            AC_MSG_NOTICE([  -> DEBUGGING OPTIONS are SELECTED])
            FCFLAGS="-g -O0 -check all -traceback -auto -warn all -warn unused -debug variable_locations"
	    LDFLAGS="-g -O0 -check all -traceback -auto"
## if idb bugs use          FCFLAGS="-g -O0 "
## if idb bugs use 	    LDFLAGS="-g -O0 "
          ;;
          aggressive)
            AC_MSG_NOTICE([  -> AGGRESSIVE COMPILER OPTIONS are SELECTED])
    	    FCFLAGS="-fast"
            LDFLAGS="-fast"
          ;;
          normal|*)
            AC_MSG_NOTICE([  -> NORMAL MODE])
	    FCFLAGS="-g -O2"
	  ;;
	esac
	if test "$enable_prof" = "yes" ; then
          AC_MSG_NOTICE([  -> PROFILING is SELECTED (gprof)])
          FCFLAGS="-pg $FCFLAGS"
          LDFLAGS="-pg $LDFLAGS"
        fi
        ;;
##    IBM FORTRAN COMPILER on AIX OPERATING SYSTEM
      xlf90|xlf95)
	case "$enable_optimization" in
	  debug)
            FCFLAGS="-qsuffix=cpp=F90 -qsuffix=f=f90 -qfree=f90 -g -qnooptimize -C -qinitauto=7FBFFFFF -qflttrap=overflow:underflow:zerodivide:invalid:enable -qfloat=nans -qsigtrap -qextchk"
          ;;
          aggressive)
            FCFLAGS="-qsuffix=cpp=F90 -qsuffix=f=f90 -qfree=f90 -O5 -qipa=level=2 -qessl -qhot=vector -qunroll"
            LDFLAGS="-qessl"
          ;;
          normal|*)
            FCFLAGS="-qsuffix=cpp=F90 -qsuffix=f=f90 -qfree=f90 -O3 -qstrict"
	  ;;
	esac
	if test "$enable_prof" = "yes" ; then
          AC_MSG_NOTICE([  -> PROFILING is SELECTED (gprof)])
          FCFLAGS="-pg $FCFLAGS"
          LDFLAGS="-pg $LDFLAGS"
        fi
        ;;
##    PORTLAND GROUP FORTRAN COMPILER
      pgf90)
	FCFLAGS="-g"
        ;;
##    GENERIC Fortran 95 compiler (not tested)
      f95)
	FCFLAGS="-g"
        ;;
##    HP_COMPAQ ALPHASERVER FORTRAN COMPILER (LINUX OPERATING SYSTEM)
      fort)
	FCFLAGS="-g"
        ;;
##    Lahey-Fujitsu compiler
      lf95)
	FCFLAGS="-g"
        ;;
##    PATHSCALE FORTRAN COMPILER (AMD-OPTERON) (Not Tested)
      pathf90)
	FCFLAGS="-g"
        ;;
##    GNU FORTRAN 90/95 COMPILER (Tested on Intel-PC and Mac OS X)
      g95)
	case "$enable_optimization" in
	  debug)
            AC_MSG_NOTICE([  -> DEBUGGING OPTIONS are SELECTED])
            FCFLAGS="-g -O0 -fno-second-underscore -Wall -Wunset-vars -Wunused-vars -fbounds-check "
	    LDFLAGS="-g -O0 -fno-second-underscore"
          ;;
          aggressive)
            AC_MSG_NOTICE([  -> AGGRESSIVE COMPILER OPTIONS are SELECTED])
    	    FCFLAGS="-g -O3 -fno-second-underscore"
            LDFLAGS="-g -O3 -fno-second-underscore"
          ;;
          normal|*)
            AC_MSG_NOTICE([  -> NORMAL MODE])
	    FCFLAGS="-g -O -fno-second-underscore"
            LDFLAGS="-g -O -fno-second-underscore"
	  ;;
	esac
	if test "$enable_prof" = "yes" ; then
          AC_MSG_NOTICE([  -> PROFILING is SELECTED (gprof)])
          FCFLAGS="-pg $FCFLAGS"
          LDFLAGS="-pg $LDFLAGS"
        fi
        ;;
##    OFICIAL GCC GNU FORTRAN 90/95 COMPILER (Tested on Intel-PC with Linux/Ubuntu)
      gfortran)
	case "$enable_optimization" in
	  debug)
            AC_MSG_NOTICE([  -> DEBUGGING OPTIONS are SELECTED])
            FCFLAGS="-g -O0 -frecord-marker=4"
	    LDFLAGS="-g -O0 -frecord-marker=4"
          ;;
          aggressive)
            AC_MSG_NOTICE([  -> AGGRESSIVE COMPILER OPTIONS are SELECTED])
    	    FCFLAGS="-g -O3 -frecord-marker=4"
            LDFLAGS="-g -O3 -frecord-marker=4"
          ;;
          normal|*)
            AC_MSG_NOTICE([  -> NORMAL MODE])
	    FCFLAGS="-g -O2 -frecord-marker=4"
            LDFLAGS="-g -O2 -frecord-marker=4"
	  ;;
	esac
	if test "$enable_prof" = "yes" ; then
          AC_MSG_NOTICE([  -> PROFILING is SELECTED (gprof)])
          FCFLAGS="-pg $FCFLAGS"
          LDFLAGS="-pg $LDFLAGS"
        fi
        ;;
  esac  
  AC_FC_SRCEXT(f90)
  AC_FC_FREEFORM()
  F77=$FC
else
  AC_MSG_ERROR([No Fortran 90 compiler available on this machine.
               Please use F90FLAGS to specify it or
               update your environnement variable PATH or
               install a Fortran 90 compiler.])
fi

###########################################################
## Quad precision -> Add a precompilation option.        ##
## It concerns only the mod_precision.f90 fortran module.##
###########################################################
if test "$enable_quad" = "yes" ; then
  CPPFLAGS="-Dquad"
  AC_MSG_NOTICE([  -> Quad Precision is used to improve precision])
else	
  CPPFLAGS=""
fi

########################################################
## Test if fortran compiler works on a simple program ##
########################################################
AC_MSG_CHECKING([for Fortran compiler can handle Fortran-90 code])
cat <<EOF >conftest.f90
  program conftest
    IMPLICIT NONE 
    REAL(kind=8), PARAMETER :: A = 3.141592654
    end program conftest
EOF
doit='$FC ${FCFLAGS} ${FCFLAGS_f90} conftest.f90'
if AC_TRY_EVAL(doit); then
  nc_ans=yes
else
  nc_ans=no
fi
rm -f conftest.f90 a.out
AC_MSG_RESULT([$nc_ans])
if test "x$nc_ans" = xno; then
  AC_MSG_ERROR([A simple Fortran 90 test doesn't work.])
fi

###############
## HDF5  LIB ##
###############
if test "$enable_hdf5" = "yes" ; then
  if test "${HDF5_LIB}"; then
    if test -d "${HDF5_LIB}"; then
       LIBS="${LIBS} -L${HDF5_LIB}"
      if test -f "${HDF5_LIB}/libhdf5.a"; then
	LIBS="${LIBS} -lhdf5"
      else
        AC_MSG_ERROR([Can't find libhdf5.a in ${HDF5_LIB}])
      fi
      if test -f "${HDF5_LIB}/libhdf5_fortran.a"; then
        LIBS="${LIBS} -lhdf5_fortran"
      else
        AC_MSG_ERROR([Can't find libhdf5_fortran.a in ${HDF5_LIB}])
      fi
      if test -f "${HDF5_LIB}/libhdf5_hl.a"; then
        LIBS="${LIBS} -lhdf5_hl"
      else
        AC_MSG_ERROR([Can't find libhdf5_hl.a in ${HDF5_LIB}])
      fi
    else
      AC_MSG_ERROR([${HDF5_LIB} location does not exist!])
    fi
  else
    HDF5_LIB="/usr/local/lib"
    if test -d "${HDF5_LIB}"; then
       LIBS="${LIBS} -L${HDF5_LIB}"
       if test -f "${HDF5_LIB}/libhdf5.a"; then
         LIBS="${LIBS} -lhdf5"
       else
         AC_MSG_ERROR([Can't find libhdf5.a in ${HDF5_LIB}])
       fi
       if test -f "${HDF5_LIB}/libhdf5_fortran.a"; then
         LIBS="${LIBS} -lhdf5_fortran"
       else
         AC_MSG_ERROR([Can't find libhdf5_fortran.a in ${HDF5_LIB}])
       fi
       if test -f "${HDF5_LIB}/libhdf5_hl.a"; then
         LIBS="${LIBS} -lhdf5_hl"
       else
         AC_MSG_ERROR([Can't find libhdf5_hl.a in ${HDF5_LIB}])
       fi
    else
      AC_MSG_ERROR([${HDF5_LIB} location does not exist!])
    fi
  fi
  AC_MSG_NOTICE([  -> HDF5 library for Netcdf 4 : ${HDF5_LIB}])
fi
##################
## HDF5 INCLUDE ##
##################
if test "$enable_hdf5" = "yes" ; then
  if test "${HDF5_INC}"; then
    if test -d "${HDF5_INC}"; then
       FCFLAGS="${FCFLAGS} -I${HDF5_INC}"
    else
      AC_MSG_ERROR([${HDF5_INC} location does not exist!])
    fi
  else
    HDF5_INC="/usr/local/lib"
    if test -d "${HDF5_INC}"; then
       FCFLAGS="${FCFLAGS} -I${HDF5_INC}"
    else
      AC_MSG_ERROR([${HDF5_INC} location does not exist!])
    fi
  fi
  AC_MSG_NOTICE([  -> HDF5 include for Netcdf 4 : ${HDF5_INC}])
fi


#
#################################################################################
# Checks for library functions. (From NCO configure.in)
#################################################################################
# Begin Mandatory Link Test with libnetcdf.a
# Make precious variables for ./configure --help
AC_ARG_VAR(NETCDF_INC,Location of netCDF module (compile-time))
AC_ARG_VAR(NETCDF_LIB,Location of netCDF library (compile-time))
# Add user-specified netCDF locations, if any, else add /usr/local/ locations if they exist
################
## NETCDF_LIB ##
################
if test "${NETCDF_LIB}"; then
    if test -d "${NETCDF_LIB}"; then
      if test -f "${NETCDF_LIB}/libnetcdf.a"; then
        if test -f "${NETCDF_LIB}/libnetcdff.a"; then
          LIBS="${LIBS} -L${NETCDF_LIB} -lnetcdff -lnetcdf"
        else
	  LIBS="${LIBS} -L${NETCDF_LIB} -lnetcdf"
        fi
      else
        AC_MSG_ERROR([Can't find libnetcdf.a in ${NETCDF_LIB}])
      fi
    else
      AC_MSG_ERROR([${NETCDF_LIB} location does not exist!])
    fi
else
    NETCDF_LIB="/usr/local/lib"
    if test -d "${NETCDF_LIB}"; then
      if test -f "${NETCDF_LIB}/libnetcdf.a"; then
        if test -f "${NETCDF_LIB}/libnetcdff.a"; then
          LIBS="${LIBS} -L${NETCDF_LIB} -lnetcdff -lnetcdf"
        else
	  LIBS="${LIBS} -L${NETCDF_LIB} -lnetcdf"
        fi
      else
        AC_MSG_ERROR([Can't find libnetcdf.a in ${NETCDF_LIB}])
      fi
    else
      AC_MSG_ERROR([${NETCDF_LIB} location does not exist!])
    fi
fi

################
## NETCDF_INC ##
################
if test "${NETCDF_INC}"; then
    if test -d "${NETCDF_INC}"; then
      if test -f "${NETCDF_INC}/netcdf.mod"; then
	FCFLAGS="${FCFLAGS} -I${NETCDF_INC}"
      else
        AC_MSG_ERROR([Can't find netcdf.mod in ${NETCDF_INC}])
      fi
    else
	AC_MSG_ERROR([{NETCDF_INC} location does not exist!])
    fi
else
    NETCDF_INC=/usr/local/include
    if test -d "${NETCDF_INC}"; then
      if test -f "${NETCDF_INC}/netcdf.mod"; then
	FCFLAGS="${FCFLAGS} -I${NETCDF_INC}"
      else
        AC_MSG_ERROR([Can't find netcdf.mod in ${NETCDF_INC}])
      fi
    else
	AC_MSG_ERROR([{NETCDF_INC} location does not exist!])
    fi
fi

#####################
## ARIANE messages ##
#####################
AC_MSG_NOTICE([  -> NetCDF library: ${NETCDF_LIB}])
AC_MSG_NOTICE([  -> NetCDF module : ${NETCDF_INC}])

######################################################
## Test a simple fortran 90 code linked with NetCDF ##
######################################################
AC_MSG_CHECKING([for Fortran-90 program linked with NetCDF library])
cat <<EOF >conftest.f90
  program conftest
    USE netcdf
    IMPLICIT NONE
    character(len=128), PARAMETER :: &
    c_filename='./examples/data/reduc_meshmask.nc'
    INTEGER(kind = 4)  :: is_err, ncid
    is_err = nf90_open(           &
         path = TRIM(c_filename), &
         mode = nf90_nowrite    , &
         ncid = ncid              &
         )
   is_err = nf90_close(ncid = ncid)
  END program conftest
EOF
doit='$FC ${FCFLAGS} ${FCFLAGS_f90} conftest.f90 ${LIBS}'
if AC_TRY_EVAL(doit); then
  nc_ans=yes
else
  nc_ans=no
fi
rm -f conftest.f90 a.out
AC_MSG_RESULT([$nc_ans])
if test "x$nc_ans" = xno; then
  AC_MSG_NOTICE([ ])
  AC_MSG_ERROR([A simple Fortran 90 program linked with Netcdf library doesn't work. Please verify that the NetCDF library was compiled with the Fortran compiler $FC.])
fi

#################################################################################
# Export DATA
#################################################################################
AC_SUBST(CPPFLAGS)
AC_SUBST(F77)
AC_SUBST(FC)
AC_SUBST(FCFLAGS)
AC_SUBST(FCFLAGS_f90)
AC_SUBST(LDFLAGS)
AC_SUBST(LIBS)

#################################################################################
# Checks for system services
#################################################################################
## ?

AC_OUTPUT([Makefile
           src/Makefile
           src/ariane/Makefile
           src/tools/Makefile
           doc/Makefile
           doc/manuals/Makefile
           doc/src_browser/Makefile
           doc/src_browser/call_from/Makefile
           doc/src_browser/call_to/Makefile
           doc/src_browser/gif/Makefile
           doc/src_browser/html_code/Makefile
           doc/src_browser/html_code/ariane/Makefile
           doc/src_browser/ind/Makefile
           examples/Makefile
           examples/IDL/Makefile
           examples/Matlab/Makefile
           examples/Matlab/bg_routines/Makefile
           examples/OPA/Makefile
           examples/ROMS/Makefile
           examples/data/Makefile
           examples/shell_scripts/Makefile
           examples/quantitative/Makefile
           examples/quantitative/validation/Makefile
           examples/qualitative/Makefile
           examples/qualitative/validation/Makefile])


# Echo build parameters for debugging
echo ""
echo "Configuration Parameters:"
echo "------------------------"
echo "Ariane's version..... ${VERSION}"
echo "CPP.................. ${CPP}"
echo "CPPFLAGS............. ${CPPFLAGS}"
echo "FC................... ${FC}"
echo "FCFLAGS.............. ${FCFLAGS}"
echo "FCFLAGS_f90.......... ${FCFLAGS_f90}"
echo "LDFLAGS.............. ${LDFLAGS}"
echo "LIBS................. ${LIBS}"
echo "NETCDF_LIB........... ${NETCDF_LIB}"
echo "NETCDF_INC........... ${NETCDF_INC}"
echo "ENABLE_OPTIMIZATION.. ${enable_optimization}"
echo "ENABLE_PROFILING..... ${enable_prof}"
echo "ENABLE_QUAD.......... ${enable_quad}"
echo "host................. ${host}"
echo "prefix............... ${prefix}"
date

# Inform users of the very useful configure.eg
echo ""
echo "*******************************************************************"
echo "*              Ariane's configuration is completed                *" 
echo "* You are now ready to run 'make', 'make check' and 'make install'*"
echo "*******************************************************************"
