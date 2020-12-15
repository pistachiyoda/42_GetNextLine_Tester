#!/bun/bash
make fclean
tests="./tests/*"
YELLOW='\033[0;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

rm -r my_result
mkdir my_result

function echo_myresult(){
    echo ""
    echo ""
    echo -e "${YELLOW}=====BUFFER_SIZE=$1 x $2=====${NC}" | tr '\0' '$$'
    echo ""
    ./a.out $2
}

function echo_compare_result(){
    diff -u my_result/BUFFER_SIZE_$1x$2 correct_result/BUFFER_SIZE_$1x$2
}

function output_myresult(){
    gcc -o ./a.out -D BUFFER_SIZE=$1 main.c ./cpy_gnl/get_next_line.c ./cpy_gnl/get_next_line_utils.c
    file_name=`echo $2 | sed "s/\.\/tests\///g"`
    ./a.out $2 > my_result/BUFFER_SIZE_$1x$file_name
    echo -e "${YELLOW}=====BUFFER_SIZE=$1 x $2=====${NC}" 
    diff my_result/BUFFER_SIZE_$1x$file_name correct_result/BUFFER_SIZE_$1x$file_name > /dev/null 2>&1
    if [ $? -eq 1 ] ; then
        echo -e "${RED}=================THERE ARE DIFFERENCES=================${NC}"
        echo_compare_result $1 $file_name
    else
        echo -e "${GREEN}=================THERE IS NO DIFFERENCES=================${NC}"
    fi
}

function output_result(){
    # gcc -o ./a.out -D BUFFER_SIZE=$1 main.c ./cpy_gnl/get_next_line.c ./cpy_gnl/get_next_line_utils.c
    # gcc -o ./a.out -D BUFFER_SIZE=$1 main.c ./correct_get_next_line/get_next_line.c ./correct_get_next_line/libft/libft.a
    for file in $tests; do
        if [[ $file =~ ./tests/same_buf_100 ]]; then
            continue
        fi
        output_myresult $1 $file
    done
}

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
