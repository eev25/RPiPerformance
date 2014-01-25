interchange:  interchange.c ../test_common/test_common.h \
	../test_common/test_common.c \
	../test_common/rpi_pmu.h  ../test_common/rpi_pmu.c
	gcc -c ../test_common/rpi_pmu.c 
	gcc -c ../test_common/test_common.c
	gcc -O2 -c interchange.c
	gcc -o interchange interchange.o test_common.o rpi_pmu.o

clean:
	rm interchange *.o