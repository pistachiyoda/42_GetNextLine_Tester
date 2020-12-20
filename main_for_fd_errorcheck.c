#include "./cpy_gnl/get_next_line.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
    int fd;
    char *line;

	fd = 200;
	while (1)
	{
		int ret = get_next_line(fd, &line);
		printf("======OUTPUT(line)=====\n");
		printf("ret:%d\n",ret);
		// printf("%s\n",line);
		// free(line);
		// line = NULL;
		if (ret <= 0)
			break ;
	}
    exit(1);
}