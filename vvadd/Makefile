all: microBench

microBench:	main.c ../test_common/test_common.h \
  	../test_common/test_common.c \
  	../test_common/rpi_pmu.h  ../test_common/rpi_pmu.c
	gcc -c ../test_common/rpi_pmu.c
	gcc -c ../test_common/test_common.c
	gcc -O3 -I "/home/pi/Documents/RPiPerformance/vvadd" -c intAdd.c
	gcc -O3 -I "/home/pi/Documents/RPiPerformance/vvadd" -c main.c
	gcc -O3 main.o intAdd.o test_common.o rpi_pmu.o -o microBench

clean:
	rm -rf *.o microBench
