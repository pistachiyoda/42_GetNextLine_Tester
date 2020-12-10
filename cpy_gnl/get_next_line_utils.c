#include "get_next_line.h"

void	*ft_memset(void *b, int c, size_t n)
{
	unsigned char *dst;

	dst = (unsigned char *)b;
	while (n)
	{
		*dst = (unsigned char)c;
		dst++;
		n--;
	}
	return (b);
}

size_t	ft_strlen(const char *str)
{
	size_t cnt;

	if (!str)
		return 0;
	cnt = 0;
	while (1)
	{
		if (*str == '\0')
			break ;
		str++;
		cnt++;
	}
	return (cnt);
}

char	*null_pattern(char const *s1, char const *s2)
{
	if (s1 == NULL && s2 == NULL)
		return (ft_strdup(""));
	if (s2 == NULL)
		return (ft_strdup((char *)s1));
	return (ft_strdup((char *)s2));
}

char	*ft_strnjoin(char const *s1, char const *s2, int i)
{
	size_t	len;
	char	*str;
	char	*ret;

	if (s1 == NULL || s2 == NULL)
		return (null_pattern(s1, s2));
	len = ft_strlen((char *)s1) + i + 1;
	str = (char *)malloc(sizeof(char) * len);
	if (str == NULL)
		return (NULL);
	ret = str;
	while (*s1 != '\0')
		*str++ = *s1++;
	while (i) 
	{
		*str++ = *s2++;
		i--;
	}
	*str = '\0';
	return (ret);
}

char	*ft_strdup(const char *src)
{
	int		str_cnt;
	char	*malloc_p;
	int		i;

	if (!src)
	{
		malloc_p = (char *)malloc(sizeof(char) * 1);
		*malloc_p = '\0';
		return (malloc_p);
	}
	str_cnt = ft_strlen(src);
	malloc_p = (char *)malloc(sizeof(char) * str_cnt + 1);
	if (malloc_p == NULL)
		return (NULL);
	i = 0;
	while (src[i] != '\0')
	{
		malloc_p[i] = src[i];
		i++;
	}
	malloc_p[i] = '\0';
	return (malloc_p);
}