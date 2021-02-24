#!/bin/bash
make fclean
tests="./tests/*"
YELLOW='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

rm -r my_bonus_result
mkdir my_bonus_result

function leaks_report()
{
    echo -e "${BLUE}============LEAKS REPORT============${NC}"
    leaks -atExit -- ./a.out ./tests/normal_901 ./tests/longline_multiple_6678 > leaks.txt
    cat leaks.txt | sed -n -e '/leaks Report/,$p'
    rm leaks.txt
}

echo -e "${YELLOW}====================BONUS!!!!!!!!!!====================${NC}" 

size_list=(1 4 1500)

for size in ${size_list[@]}; do
    bonus_correct=correct_bonus_result/BONUS_BUFFER_SIZE_${size}xnormal_901xlongline_multiple_6678
    bonus_my=my_bonus_result/BONUS_BUFFER_SIZE_${size}xnormal_901xlongline_multiple_6678
    gcc -o ./a.out -D BUFFER_SIZE=${size} main.c ./cpy_gnl/get_next_line_bonus.c ./cpy_gnl/get_next_line_utils_bonus.c
    ./a.out ./tests/normal_901 ./tests/longline_multiple_6678 > ${bonus_my}
    echo -e "${YELLOW}=====BONUS_BUFFER_SIZE_${size}xnormal_901xlongline_multiple_6678=====${NC}" 
    diff ${bonus_my} ${bonus_correct} > /dev/null 2>&1
    if [ $? -eq 1 ] ; then
        echo -e "${RED}============THERE ARE DIFFERENCES============${NC}"
        diff -u ${bonus_correct} ${bonus_my}
    else
        echo -e "${GREEN}============THERE IS NO DIFFERENCE============${NC}"
    fi
	leaks_report
done
