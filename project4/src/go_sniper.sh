#!/bin/bash

[ -z "$PIN_HOME" ] && PIN_HOME="/home/abissoto/Documents/project3/pinplay-drdebug-2.2-pldi2015-pin-2.14-71313-gcc.4.4.7-linux"

if env | grep -q ^PIN_HOME= > /dev/null
then
  echo env PIN_HOME is already exported
else
  echo env variable was not exported, but now it is
  export PIN_HOME
fi

source /home/abissoto/temp-python/bin/activate

cd /home/abissoto/Documents/project3/sniper-6.1

make

pinball_hmmer="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-hmmer-ref-1.pp/cpu2006-hmmer-ref-1_t0r1_warmup100001500_prolog0_region30000002_epilog0_001_0-02538.0.address"

pinball_gobmk="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-gobmk-ref-1.pp/cpu2006-gobmk-ref-1_t0r1_warmup100001500_prolog0_region30000001_epilog0_001_0-24877.0.address"

pinball_gcc="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-gcc-ref-1.pp/cpu2006-gcc-ref-1_t0r1_warmup100001500_prolog0_region30000013_epilog0_001_0-09512.0.address"

pinball_astar="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-astar-ref-1.pp/cpu2006-astar-ref-1_t0r1_warmup100001500_prolog0_region30000002_epilog0_001_0-01030.0.address"

pinball_bzip2="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-bzip2-ref-1.pp/cpu2006-bzip2-ref-1_t0r1_warmup100001500_prolog0_region30000015_epilog0_001_0-07828.0.address"

pinball_h264="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-h264ref-ref-1.pp/cpu2006-h264ref-ref-1_t0r1_warmup100001500_prolog0_region30000034_epilog0_001_0-20955.0.address"

pinball_libquantum="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-libquantum-ref-1.pp/cpu2006-libquantum-ref-1_t0r1_warmup100001500_prolog0_region30000003_epilog0_001_0-00960.0.address"

pinball_mcf="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-mcf-ref-1.pp/cpu2006-mcf-ref-1_t0r1_warmup100001500_prolog0_region30000003_epilog0_001_0-09946.0.address"

pinball_omnetpp="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-omnetpp-ref-1.pp/cpu2006-omnetpp-ref-1_t0r1_warmup100001500_prolog0_region30000011_epilog0_001_0-27540.0.address"

pinball_perlbench="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-perlbench-ref-1.pp/cpu2006-perlbench-ref-1_t0r1_warmup100001500_prolog0_region30000004_epilog0_001_0-16949.0.address"

pinball_sjeng="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-sjeng-ref-1.pp/cpu2006-sjeng-ref-1_t0r1_warmup100001500_prolog0_region30000001_epilog0_001_0-00024.0.address"

pinball_xalancbmk="--pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-xalancbmk-ref-1.pp/cpu2006-xalancbmk-ref-1_t0r1_warmup100001500_prolog0_region30000001_epilog0_001_0-02874.0.address"

./run-sniper -cgainestown -d lru_hmmer -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_hmmer --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_hmmer -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_hmmer --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_gobmk -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_gobmk --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_gobmk -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_gobmk --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_gcc -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_gcc --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_gcc -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_gcc --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_astar -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_astar --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_astar -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_astar --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_astar -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_bzip2 --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_astar -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_bzip2 --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_h264 -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_h264 --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_h264 -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_h264 --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_libquantum -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_libquantum --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_libquantum -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_libquantum --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_mcf -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_mcf --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_mcf -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_mcf --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_omnetpp -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_omnetpp --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_omnetpp -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_omnetpp --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_perlbench -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_perlbench --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_perlbench -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_perlbench --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_sjeng -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_sjeng --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_sjeng -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_sjeng --roi-script -s roi-icount:0:100000000:30000000 &

wait

./run-sniper -cgainestown -d lru_xalancbmk -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" $pinball_xalancbmk --roi-script -s roi-icount:0:100000000:30000000 &

./run-sniper -cgainestown -d hawkeye_xalancbmk -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -gperf_model/l3_cache/cache_size=2048 -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" --pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-xalancbmk-ref-1.pp/cpu2006-xalancbmk-ref-1_t0r1_warmup100001500_prolog0_region30000001_epilog0_001_0-02874.0.address --roi-script -s roi-icount:0:100000000:30000000 &

wait
#./run-sniper -d $directory -- /home/abissoto/Downloads/pin-3.0-76991-gcc-linux/source/tools/ManualExamples/obj-intel64/fibonacci

#./run-sniper -cgainestown -d $directory -gperf_model/l3_cache/replacement_policy=hawkeye -glog/enabled=true -glog/enabled_modules="\"cache_set_hawkeye.cc cache_set.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" -- /home/abissoto/Downloads/pin-3.0-76991-gcc-linux/source/tools/ManualExamples/obj-intel64/fibonacci

#./run-sniper -cgainestown -d $lru_directory -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -glog/stack_trace=true -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" --pinballs ../INTcpu2006-pinpoints-w100M-d30M-m10/cpu2006-gcc_1-ref-1.pp/cpu2006-gcc_1-ref-1_t0r1_warmup100001500_prolog0_region30000001_epilog0_001_0-10555.0.address --roi-script -s roi-icount:0:100000000:30000000



#./run-sniper -cgainestown --roi-script -s roi-icount:0:100000000:30000000 -d lru/ -gperf_model/l3_cache/replacement_policy=lru -glog/enabled=true -glog/stack_trace=true -g log/enabled_modules="\"cache_set_hawkeye.cc\"" -g log/disabled_modules="\"barrier_sync_server. cache_cntlr.cc core.cc shmem_perf_model.cc thread_manager.cc pin_tls.cc core_manager.cc address_home_lookup. memory_manager.cc network.cc smtransport.cc handle_syscalls.cc syscall_model.cc simulator.cc queue_model_history_ sim_thread.cc\"" --pinballs ../cpu2006-wholeprogram-pinballs-pinplay-1.1/cpu2006-hmmer-ref-1/pinball.address




#./run-sniper -cgainestown --roi-script -s roi-icount:0:100000000:30000000 -d $hawkeye_directory -gperf_model/l3_cache/replacement_policy=hawkeye  --pinballs ../cpu2006-wholeprogram-pinballs-pinplay-1.1/cpu2006-hmmer-ref-1/pinball.address

