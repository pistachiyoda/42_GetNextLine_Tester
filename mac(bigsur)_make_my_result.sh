#!/bun/bash
make fclean
tests="./tests/*"
YELLOW='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

rm -r my_result
mkdir my_result

function leaks_report()
{
    echo -e "${BLUE}============LEAKS REPORT============${NC}"
    leaks -atExit -- ./a.out $FILE > leaks.txt
    cat leaks.txt | sed -n -e '/leaks Report/,$p'
    rm leaks.txt
}

# Mandatory part1
## Error check

echo -e "${YELLOW}====================ERROR CHECK!!!!!!!!!!====================${NC}" 

function error_checks(){
    BUFFER_SIZE=$1
    FILE=$2
    MAIN=$3
    echo -e "${YELLOW}==========BUFFER_SIZE${BUFFER_SIZE}x${FILE}==========${NC}" 
    gcc -o ./a.out -D BUFFER_SIZE=${BUFFER_SIZE} ${MAIN} ./cpy_gnl/get_next_line.c ./cpy_gnl/get_next_line_utils.c

    ./a.out $FILE > error_check_result.txt
    if [ `cat error_check_result.txt | grep 'ret:-1'` ] ; then
        echo -e "${GREEN}============RETURN OK============${NC}"
    else
        echo -e "${RED}============RETURN KO============${NC}"
    fi
    cat error_check_result.txt
    rm error_check_result.txt
    leaks_report
}

### BUFFER_SIZE == 0
error_checks 0 ./tests/normal_901 main.c

### BUFFER_SIZE == -1
error_checks -1 ./tests/normal_901 main.c

### The file is not exist
error_checks 10 ./tests/not_exist_file main.c

### The fd is not exist
error_checks 10 ./tests/normal_901 main_for_fd_errorcheck.c

# Mandatory part2
## Test cases

function make_my_result(){
    BUFFER_SIZE=$1
    file=$2
    gcc -o ./a.out -D BUFFER_SIZE=$BUFFER_SIZE main.c ./cpy_gnl/get_next_line.c ./cpy_gnl/get_next_line_utils.c
    file_name=`echo $file | sed "s/\.\/tests\///g"`
    ./a.out $file > my_result/BUFFER_SIZE_$BUFFER_SIZEx$file_name
    echo -e "${YELLOW}=====BUFFER_SIZE=$BUFFER_SIZE x $file=====${NC}" 
    diff my_result/BUFFER_SIZE_$BUFFER_SIZEx$file_name correct_result/BUFFER_SIZE_$BUFFER_SIZEx$file_name > /dev/null 2>&1
    if [ $? -eq 1 ] ; then
        echo -e "${RED}============THERE ARE DIFFERENCES============${NC}"
        diff -u my_result/BUFFER_SIZE_$BUFFER_SIZEx$file_name correct_result/BUFFER_SIZE_$BUFFER_SIZEx$file_name
    else
        echo -e "${GREEN}============THERE IS NO DIFFERENCE============${NC}"
    fi
    leaks_report
}

### normal cases

echo -e "${YELLOW}====================NORMAL TEST CASES!!!!!!!!!!====================${NC}" 

function though_tests(){
    BUFFER_SIZE=$1
    for file in $tests; do
        if [[ $file =~ ./tests/same_buf_100 ]]; then
            continue
        fi
        make_my_result $BUFFER_SIZE $file
    done
}

big_buf=1500
though_tests $big_buf

small_buf1=1
though_tests $small_buf1

small_buf4=4
though_tests $small_buf4

### special cases

echo -e "${YELLOW}====================SPECIAL TEST CASES!!!!!!!!!!====================${NC}" 

function output_sp_case_result(){
    BUFFER_SIZE=$1
    file=$2
    make_my_result $BUFFER_SIZE $file
}

same_buf=100
make_my_result $same_buf ./tests/same_buf_100

plus1_buf=101
make_my_result $plus1_buf ./tests/same_buf_100

minus1_buf=99
make_my_result $minus1_buf ./tests/same_buf_100

# Bonus

echo -e "${YELLOW}====================BONUS!!!!!!!!!!====================${NC}" 

size_list=(1 4 1500)

for size in ${size_list[@]}; do
    bonus_correct=correct_result/BONUS_BUFFER_SIZE_${size}xnormal_901xlongline_multiple_6678
    bonus_my=my_result/BONUS_BUFFER_SIZE_${size}xnormal_901xlongline_multiple_6678
    gcc -o ./a.out -D BUFFER_SIZE=${size} main.c ./cpy_gnl/get_next_line.c ./cpy_gnl/get_next_line_utils.c
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
