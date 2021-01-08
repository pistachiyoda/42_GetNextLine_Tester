#!/bin/bash
make fclean
tests="./tests/*"

rm -r correct_result
mkdir correct_result

function output_myresult(){
    gcc -o ./a.out -D BUFFER_SIZE=$1 main.c ./correct_get_next_line/get_next_line.c ./correct_get_next_line/get_next_line_utils.c
    file_name=`echo $2 | sed "s/\.\/tests\///g"`
    ./a.out $2 > correct_result/BUFFER_SIZE_$1x$file_name
}

function output_result(){
    for file in $tests; do
        if [[ $file =~ ./tests/same_buf_100 ]]; then
            continue
        fi
        output_myresult $1 $file
    done
}

# Mandatory part
big_buf=1500
output_result $big_buf

small_buf1=1
output_result $small_buf1

small_buf4=4
output_result $small_buf4

same_buf=100
output_myresult $same_buf ./tests/same_buf_100

plus1_buf=101
output_myresult $plus1_buf ./tests/same_buf_100

minus1_buf=99
output_myresult $minus1_buf ./tests/same_buf_100

# bonus
size_list=(1 4 1500)

for size in ${size_list[@]}; do
    bonus_correct=correct_result/BONUS_BUFFER_SIZE_${size}xnormal_901xlongline_multiple_6678
    gcc -o ./a.out -D BUFFER_SIZE=${size} main.c ./correct_get_next_line/get_next_line.c ./correct_get_next_line/get_next_line_utils.c
    ./a.out ./tests/normal_901 ./tests/longline_multiple_6678 > ${bonus_correct}
done
