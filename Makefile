CC = gcc
CFLAGS = -O2 -Wall -Wextra -I$(SRC_DIR)/include
LDFLAGS = -pthread
PREFIX = /usr
INSTALL_DIRS = $(PREFIX)/bin /var/lib/steal/repos /etc/steal /usr/local/share/steal/installed
SRC_DIR = src

# Source files
SRCS = $(wildcard $(SRC_DIR)/*.c) \
       $(wildcard $(SRC_DIR)/network/*.c) \
       $(wildcard $(SRC_DIR)/utils/*.c) \
       $(wildcard $(SRC_DIR)/core/*.c)

# Object files
OBJS = $(SRCS:.c=.o)

# ANSI color codes
BLUE = \033[1;34m
GREEN = \033[1;32m
YELLOW = \033[1;33m
CYAN = \033[1;36m
RED = \033[1;31m
NC = \033[0m

all: steal

steal: $(OBJS)
	@echo "$(BLUE)╭─────────────────────────────╮$(NC)"
	@echo "$(BLUE)│$(NC)    $(CYAN)Compiling steal...$(NC)        $(BLUE)│$(NC)"
	@echo "$(BLUE)╰─────────────────────────────╯$(NC)"
	@$(CC) $(OBJS) -o $@ $(LDFLAGS)
	@echo "$(GREEN)✓ Successfully compiled steal$(NC)\n"

%.o: %.c
	@$(CC) $(CFLAGS) -c $< -o $@

install: steal
	@echo "$(BLUE)╭─────────────────────────────╮$(NC)"
	@echo "$(BLUE)│$(NC)    $(CYAN)Installing steal...$(NC)        $(BLUE)│$(NC)"
	@echo "$(BLUE)╰─────────────────────────────╯$(NC)"
	@for dir in $(INSTALL_DIRS); do \
		echo "$(YELLOW)Creating directory: $$dir$(NC)"; \
		mkdir -p $$dir; \
	done
	@install -m 755 steal $(PREFIX)/bin/steal
	@echo "$(GREEN)✓ Successfully installed steal$(NC)\n"

uninstall:
	@echo "$(BLUE)╭─────────────────────────────╮$(NC)"
	@echo "$(BLUE)│$(NC)   $(CYAN)Uninstalling steal...$(NC)      $(BLUE)│$(NC)"
	@echo "$(BLUE)╰─────────────────────────────╯$(NC)"
	@rm -f $(PREFIX)/bin/steal
	@echo "$(GREEN)✓ Successfully uninstalled steal$(NC)\n"

clean:
	@echo "$(BLUE)╭─────────────────────────────╮$(NC)"
	@echo "$(BLUE)│$(NC)     $(CYAN)Cleaning files...$(NC)        $(BLUE)│$(NC)"
	@echo "$(BLUE)╰─────────────────────────────╯$(NC)"
	@rm -f steal $(OBJS)
	@echo "$(GREEN)✓ Successfully cleaned files$(NC)\n"

.PHONY: all install uninstall clean
