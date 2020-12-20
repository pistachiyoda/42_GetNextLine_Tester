PATH_GNL = ../get_next_line

NAME = get_next_line.a
CPY_DIR = cpy_gnl/
CC = gcc
CFLAGS = -Wall -Wextra -Werror -D
CFILES = get_next_line.c get_next_line_utils.c
OBJ = $(CFILES:.c=.o)
BONUS_CFILES = get_next_line_bonus.c get_next_line_utils.c
BONUS_OBJ = $(BONUS_CFILES:.c=.o)
all: $(NAME)
$(NAME): $(OBJ)
	ar -rcs $(NAME) $(OBJ)
cp:
	mkdir $(CPY_DIR)
	cp $(PATH_GNL)/get_next_line.c $(CPY_DIR)
	cp $(PATH_GNL)/get_next_line.h $(CPY_DIR)
	cp $(PATH_GNL)/get_next_line_utils.c $(CPY_DIR)
	cp $(PATH_GNL)/get_next_line_bonus.c $(CPY_DIR)
	cp $(PATH_GNL)/get_next_line_bonus.h $(CPY_DIR)
	cp $(PATH_GNL)/get_next_line_utils_bonus.c $(CPY_DIR)
clean:
	rm -rf $(CPY_DIR)
	rm -f $(OBJ) $(BONUS_OBJ)
fclean: clean cp
	rm -f $(NAME)
re: fclean all
bonus: $(BONUS_OBJ)
	ar -rcs $(NAME) $(OBJ) $(BONUS_OBJ)
.PHONY: all cp clean fclean re bonus
