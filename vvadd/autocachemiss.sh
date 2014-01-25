for j in {1..10}
do
  for i in {100..4000..10}
  do
    ./microBench -i -n 1 -a $i -r 100 >/dev/null &
    wait
    echo "`grep 'Counter 0:' output.dat | awk '{print $3}'`" | tr -d "\n" >> data/cache/$i.cachemiss.dat &
    wait
    echo " `grep 'Counter 1:' output.dat | awk '{print $3}'`" >> data/cache/$i.cachemiss.dat &
    wait
  done
done