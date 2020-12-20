#include "./cpy_gnl/get_next_line.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
    int fd;
    char *line;

    if (!argv[2])
    {
        // mandatoy
        fd = open(argv[1], O_RDONLY);
        while (1)
        {
            int ret = get_next_line(fd, &line);
            printf("======OUTPUT(line)=====\n");
            printf("ret:%d\n",ret);
            printf("%s\n",line);
            free(line);
            line = NULL;
            if (ret <= 0)
                break ;
        }
    }
    else
    {
        // bonus
        int fd_a = open(argv[1], O_RDONLY);
        int fd_b = open(argv[2], O_RDONLY);
        fd = fd_a;
        while (1)
        {
            if (fd == -1)
            {
                fd = fd == fd_a ? fd_b : fd_a;
                continue;
            }
            int ret = get_next_line(fd, &line);
            printf("======OUTPUT=====\n");
            printf("ret:%d\n",ret);
            printf("line:%s\n",line);
            free(line);
            line = NULL;
            if (ret <= 0)
            {
                if (fd == fd_a)
                    fd_a = -1;
                else
                    fd_b = -1;
                if (fd_a == -1 && fd_b == -1)
                    break ;
            }
            fd = fd == fd_a ? fd_b : fd_a;
        }    
    }
    exit(1);
}