ARIANESRCDIR=../ariane

SUFFIXES = .F90 .f90 .o .mod


.f90.mod:
	$(FC) $(FCFLAGS) -c $<

.f90.o:
	$(FC) $(FCFLAGS) -c $<

clean-local:
	-rm  -f *.o *.mod
	sed "s/${VERSION}/x.x.x/" mkseg0.f90 > mkseg0.f90.orig
	mv -f mkseg0.f90.orig mkseg0.f90
	sed "s/${VERSION}/x.x.x/" mkseg.f90 > mkseg.f90.orig
	mv -f mkseg.f90.orig mkseg.f90
	sed "s/${VERSION}/x.x.x/" test_data_and_mask_consistency.f90 > test_data_and_mask_consistency.f90.orig
	mv -f test_data_and_mask_consistency.f90.orig test_data_and_mask_consistency.f90

mkseg0.o: mkseg0.f90.orig

mkseg.o: mkseg.f90.orig

test_data_and_mask_consistency.o : test_data_and_mask_consistency.f90.orig

mkseg0.f90.orig:
	sed "s/x.x.x/${VERSION}/" mkseg0.f90 > mkseg0.f90.orig
	cp -f mkseg0.f90.orig mkseg0.f90

mkseg.f90.orig:
	sed "s/x.x.x/${VERSION}/" mkseg.f90 > mkseg.f90.orig
	cp -f mkseg.f90.orig mkseg.f90

test_data_and_mask_consistency.f90.orig:
	sed "s/x.x.x/${VERSION}/" test_data_and_mask_consistency.f90 > test_data_and_mask_consistency.f90.orig
	cp -f test_data_and_mask_consistency.f90.orig test_data_and_mask_consistency.f90

mod_precision.mod: $(ARIANESRCDIR)/mod_precision.F90 
	$(FC) -cpp $(CPPFLAGS) $(FCFLAGS) -c $(ARIANESRCDIR)/mod_precision.F90 

mod_precision.o: $(ARIANESRCDIR)/mod_precision.F90 
	$(FC) -cpp $(CPPFLAGS) $(FCFLAGS) -c $(ARIANESRCDIR)/mod_precision.F90 

##
SUBDIRS		= .
bin_PROGRAMS  	= mkseg0 mkseg test_data_and_mask_consistency
##
##
mkseg0_SOURCES 	= $(ARIANESRCDIR)/mod_precision.F90 $(ARIANESRCDIR)/mod_lun.f90 $(ARIANESRCDIR)/mod_namelist.f90 $(ARIANESRCDIR)/mod_memory.f90 $(ARIANESRCDIR)/mod_reducmem.f90 $(ARIANESRCDIR)/mod_netcdf.f90 $(ARIANESRCDIR)/mod_input_grid.f90 mkseg0.f90
mkseg_SOURCES 	=mod_region_ind.f90 $(ARIANESRCDIR)/mod_precision.F90 $(ARIANESRCDIR)/mod_lun.f90 $(ARIANESRCDIR)/mod_namelist.f90  $(ARIANESRCDIR)/mod_memory.f90 $(ARIANESRCDIR)/mod_reducmem.f90 $(ARIANESRCDIR)/mod_netcdf.f90 $(ARIANESRCDIR)/mod_input_grid.f90 mkseg.f90 
test_data_and_mask_consistency_SOURCES 	= $(ARIANESRCDIR)/mod_precision.F90 $(ARIANESRCDIR)/mod_lun.f90 $(ARIANESRCDIR)/mod_namelist.f90 $(ARIANESRCDIR)/mod_memory.f90 $(ARIANESRCDIR)/mod_reducmem.f90 $(ARIANESRCDIR)/mod_netcdf.f90 $(ARIANESRCDIR)/mod_input_grid.f90 $(ARIANESRCDIR)/mod_seq.f90 $(ARIANESRCDIR)/mod_input_data_main.f90 test_data_and_mask_consistency.f90
##
## noinst_LIBRARIES = netcdf.a
##

