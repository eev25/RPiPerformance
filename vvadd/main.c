/* pertTest.c
   Einar Veizaga, July 2013, BRG
   A microbenchmarking program
*/
//__attribute__((noinline))

#include <benchFunctions.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#include "../test_common/test_common.h"
#include "../test_common/rpi_pmu.h"
 
void display_usage() {
    puts( "\nmicroBench - an integer and floating point micro benchmarking tool" );
    puts( "Usage:\n\tmicroBench [ -f ] [-i ] [ -n <no. trials> ]\n\t\t"
          "   [ -a <array length> ] [ -r <range of vals in array> ]\n" );
    exit( EXIT_FAILURE );
}

int main(int argc, char *argv[]) {

   int floatingPoint = 0;
   int integer = 0;
   int trials = 0;
   int arrLength = 0;
   int range = 0;
   char* endptr;
   struct timespec start, stop;

   int opt;
   while ((opt = getopt( argc, argv, "fin:a:r:")) != -1) {
      switch (opt) {
         case 'f':
            floatingPoint = 1;
            break;
         case 'i':
            integer = 1;
            break;
         case 'n':
            trials = strtol( optarg, &endptr, 10);
            break;
         case 'a':
            arrLength = strtol( optarg, &endptr, 10);
            break;
         case 'r':
            range = strtol( optarg, &endptr, 10);
            break;
         case '?':
            display_usage();
            break;
      }
   }
//   printf( "float: %u, int: %u, trials: %u, array length: %u\n", floatingPoint, integer, trials, arrLength);

   int k = 0;
   int i = 0;

   if( integer == 1) {
      int a[arrLength];
      int b[arrLength];
      int c[arrLength];

      srand(time(0));

      for( i = 0; i < arrLength; i++) {
         a[i] = rand() % range;
         b[i] = rand() % range; 
      }

      //"Warm-up" to remove initial memory-acces overhead
      intAdd( a, b, c, arrLength);

      //clock_gettime(CLOCK_REALTIME, &start);
      start_counting(ARMV6_EVENT_INSTR_EXEC, ARMV6_EVENT_CPU_CYCLES) ;
      //start_counting(ARMV6_EVENT_DTLB_MISS, ARMV6_EVENT_MAIN_TLB_MISS) ;
      //start_counting(ARMV6_EVENT_DCACHE_CACCESS, ARMV6_EVENT_DCACHE_MISS) ;

      for( k = trials; k > 0; k--) {
         intAdd( a, b, c, arrLength);
      }

      stop_counting() ;

      if (create_result_file("output.dat") == 0) {
        printf ("Error cannot create file");
        exit( EXIT_FAILURE ) ;
      }

      fprintf(result_file,"Performance Monitor events\n") ;
      print_counts(result_file) ;

      //clock_gettime(CLOCK_REALTIME, &stop);

      double diff = ( stop.tv_sec - start.tv_sec ) + ( stop.tv_nsec - start.tv_nsec ) / 1E9;
      printf( "%u, %u, %lf\n", trials, arrLength, diff);

   }else if ( floatingPoint == 1) {
      double a[arrLength];
      double b[arrLength];
      double c[arrLength];

      srand(time(0));
   
      for( i = 0; i < arrLength; i++) {
         a[i] = (double)rand() / (double)(RAND_MAX/range);
         b[i] = (double)rand() / (double)(RAND_MAX/range);
      }

      /*"Warm-up" to remove initial memory-acces overhead
      fpAdd( a, b, c, arrLength);
 
      clock_gettime(CLOCK_REALTIME, &start);

      for( k = trials; k > 0; k--) {
         fpAdd( a, b, c, arrLength);
      }

      clock_gettime(CLOCK_REALTIME, &stop);
      */

      double diff = ( stop.tv_sec - start.tv_sec ) + ( stop.tv_nsec - start.tv_nsec ) / 1E9;
      printf( "%u, %u, %lf\n", trials, arrLength, diff);
   }
return 0;
}
