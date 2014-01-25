for j in {1..10}
do
  for i in {100..4000..10}
  do
    ./microBench -i -n 1 -a $i -r 100 >/dev/null &
    wait
    grep 'Cycle' output.dat |\
      echo "`awk '{print $3}'` * 64 / `grep 'Counter 0:' output.dat | awk '{print $3}'`" | bc -l | tr -d "\n" >> data/$i.cpi.dat &
    wait
    echo " `grep 'Counter 0:' output.dat | awk '{print $3}'` $i" >> data/$i.cpi.dat &
    wait
  done
done