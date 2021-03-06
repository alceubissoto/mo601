#!/bin/bash

if [ ! -z ${PIN_HOME+x} ]; then
      file_project2_4k='project2_4k.so'
      file_project2_4mb='project2_4mb.so'
      file_name='bench'
      counter=0

      g++ ${file_name}_4k.cpp -o ./${file_name}_4k.o
      g++ ${file_name}_4mb.cpp -o ./${file_name}_4mb.o
      max=20
      for i in `seq 2 $max`
      do
          echo 'starting ' $i
          echo $counter
          counter=$((counter+1))
          $PIN_HOME/pin -t ./$file_project2_4k -- ./${file_name}_4k.o $i 2> ./4k_bench_$i &
          $PIN_HOME/pin -t ./$file_project2_4mb -- ./${file_name}_4k.o $i 2> ./4mb_bench_$i &
          if [ $counter -eq 2 ]; then
              wait
              counter=0
          fi
      done

      $PIN_HOME/pin -t ./$file_project2_4k -- ./${file_name}_4mb.o $i 2> ./toyresults/4k_bench_bigfile &
      $PIN_HOME/pin -t ./$file_project2_4mb -- ./${file_name}_4mb.o $i 2> ./toyresults/4mb_bench_bigfile &
      wait

else
    echo "Error - Set PIN_HOME first"
fi
