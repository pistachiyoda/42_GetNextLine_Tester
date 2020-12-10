#include "get_next_line.h"
#include <string.h>

int newline_index(char *str)
{
    int i;

    i = 0;
    if (!str)
        return (0);
    while (str[i])
    {
        if (str[i] == '\n')
            return (i + 1);
        i++;
    }
    return (0);
}

char *make_save(char *save, int i, int save_len)
{
    char *new_save;
    int j;

    j = 0;
    if (!(new_save = (char *)malloc(sizeof(char) * save_len + 1)))
        return (0);
    while (j < save_len)
    {
        new_save[j] = save[i];
        j++;
        i++;
    }
    new_save[save_len] = '\0';
    return (new_save);
}

char *make_line(char *save, int i)
{
    char *line;
    int j;

    line = (char *)malloc(sizeof(char) * i);
    j = 0;
    while (save[j] != '\n') 
    {
        line[j] = save[j];
        j++;
    }
    line[j] = '\0';
    return (line);
}

int get_next_line(int fd, char **line) 
{
    int buf_cnt;
    char *buf;
    static char *save;
    int i;

    if (fd < 0 || line == NULL || BUFFER_SIZE <= 0)
        return (-1);
    if (!(buf = (char *)malloc(sizeof(char) * BUFFER_SIZE)))
        return (-1);

    while (1)
    {

        if ((buf_cnt = read(fd, buf, BUFFER_SIZE)) == -1)
        {
            // free(buf);
            return (-1);
        }
        if (buf_cnt > 0)
            save = ft_strnjoin(save, buf, buf_cnt);
        i = newline_index(save);
        if (buf_cnt == 0 && i == 0)
        {
            *line = ft_strdup(save);
            // free(save);
            save = ft_strdup(""); // よくわからんけどうまくいく
            break ;
        }
        if (i)
        {
            *line = make_line(save, i);
            save = make_save(save, i, ft_strlen(save) - i);
            return (1) ;
        }
    }
    return (0);
}
