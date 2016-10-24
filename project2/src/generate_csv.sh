#!/bin/bash

results_file="results.csv"

ls -p | grep -v / | while read -r file ; do
        
    i=0
    while read -r value ; do
        i=$(( i + 1 ))
            
        case "$i" in
            1)
                ins_tlb_miss=$value
                ins_page_table_access=$((ins_tlb_miss * 3))
                ;;
            2)
                data_tlb_miss=$value
                data_page_table_access=$((data_tlb_miss * 3))
                ;;

            6)
                data_mem_access=$((data_page_table_access + value))
                break
                ;;
        esac
            
    done <<< "$(grep -oP 'Total Misses: \K.*' "$file")"
        
    echo "${file%.txt},$ins_tlb_miss,$ins_page_table_access,$data_tlb_miss,$data_page_table_access,$data_mem_access" >> $results_file
done
