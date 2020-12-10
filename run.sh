#!/bun/bash
make fclean
files="./tests/*"
RED='\033[0;33m'
NC='\033[0m' # No Color

function echo_result(){
    echo ""
    echo ""
    echo -e "${RED}=====BUFFER_SIZE=$1 x $2=====${NC}" | tr '\0' '$$'
    echo ""
    ./a.out $2
}

function output_result(){
    gcc -o ./a.out -Wall -Wextra -Werror -D BUFFER_SIZE=$1 main.c ./cpy_gnl/get_next_line.c ./cpy_gnl/get_next_line_utils.c
    for file in $files; do
        if [[ $file =~ ./tests/same_buf_* ]]; then
            continue
        fi
        echo_result $1 $file
    done
}

big_buf=1500
output_result $big_buf

small_buf1=1
output_result $small_buf1

small_buf4=4
output_result $small_buf4

same_buf=100
echo_result $same_buf ./tests/same_buf_100

plus1_buf=101
echo_result $plus1_buf ./tests/same_buf_101

minus1_buf=99
echo_result $minus1_buf ./tests/same_buf_99
