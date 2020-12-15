#include "./cpy_gnl/get_next_line.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
    int fd;
    char *line;
    fd = open(argv[1], O_RDONLY);
    while (1)
    {
        int ret = get_next_line(fd, &line);
        printf("======OUTPUT(line)=====\n");
        printf("ret:%d\n",ret);
        if (ret <= 0)
            break ;
        printf("%s\n",line);
    }
    exit(1);
}
// {
//     int fd;
//     char *line;
//     printf("\x1b[34m");
//     printf("\x1b[1m");
//     printf("********************Summary********************\n");
//     printf("\x1b[37m");
//     printf("\x1b[0m");
//     printf("argc:%d\n", argc);
//     printf("argv[1]:%s\n", argv[1]);
//     fd = open(argv[1], O_RDONLY);
//     printf("\x1b[34m");
//     printf("======OUTPUT(line)=====\n");
//     printf("\x1b[39m");
//     while (1)
//     {
//         int ret = get_next_line(fd, &line);
//         printf("%s\n",line);
//         if (ret <= 0)
//             break ;
//     }
//     printf("\x1b[34m");
//     printf("\x1b[1m");
//     printf("********************detail********************\n");
//     printf("\x1b[37m");
//     printf("\x1b[0m");
//     fd = open(argv[1], O_RDONLY);
//     while (1)
//     {
//         int ret = get_next_line(fd, &line);
//         printf("\x1b[34m");
//         printf("======OUTPUT(line)=====\n");
//         printf("\x1b[39m");
//         printf("ret:%d\n",ret);
//         printf("%s\n",line);
//         if (ret <= 0)
//             break ;
//     }
//     exit(1);
// }