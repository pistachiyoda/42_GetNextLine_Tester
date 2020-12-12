#!/bun/bash
make fclean
tests="./tests/*"
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

#すでにディレクトリやファイルが有るときは作り直す
rm -r my_result
mkdir my_result

function echo_result(){
    # echo ""
    # echo ""
    # echo -e "${YELLOW}=====BUFFER_SIZE=$1 x $2=====${NC}" | tr '\0' '$$'
    # echo ""
    file_name=`echo $2 | sed "s/\.\/tests\///g"`
    #./a.out $2
    ./a.out $2 > my_result/BUFFER_SIZE_$1x$file_name
}

function output_result(){
    gcc -o ./a.out -D BUFFER_SIZE=$1 main.c ./cpy_gnl/get_next_line.c ./cpy_gnl/get_next_line_utils.c
    #gcc -o ./a.out -D BUFFER_SIZE=$1 main.c ./correct_get_next_line/get_next_line.c ./correct_get_next_line/libft/libft.a
    for file in $tests; do
        if [[ $file =~ ./tests/same_buf_100 ]]; then
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
echo_result $plus1_buf ./tests/same_buf_100

minus1_buf=99
echo_result $minus1_buf ./tests/same_buf_100
