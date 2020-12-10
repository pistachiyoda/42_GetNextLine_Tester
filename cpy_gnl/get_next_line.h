#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
size_t	ft_strlen(const char *str);
int     get_next_line(int fd, char **line);
void	*ft_memset(void *b, int c, size_t n);
char	*ft_strnjoin(char const *s1, char const *s2, int i);
char	*ft_strdup(const char *src);