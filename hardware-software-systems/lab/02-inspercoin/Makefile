CC = gcc
CFLAGS = -g -Wall -Wno-unused-result -Og -Og -Wno-discarded-qualifiers
LIBS = -lsodium -lcurl -ljansson

SRCDIR = ./
LIBDIR = lib
KEYDIR = $(LIBDIR)/key
COINDIR = $(LIBDIR)/coin

SRCFILES = $(SRCDIR)/inspercoin.c
LIBFILES = $(KEYDIR)/key.c $(COINDIR)/coin.c

all: inspercoin

inspercoin: $(SRCFILES) $(LIBFILES)
	$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

clean:
	rm -f inspercoin

.PHONY: clean

rebuild: clean all

.PHONY: rebuild