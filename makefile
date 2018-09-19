# コンパイラ設定
FC = ifort
# FFLAGS = -O2 -ipo -mkl
# FFLAGS = -O3 -parallel -ipo -mkl
FFLAGS = -mkl -traceback
LDFLAGS = -mkl

# マクロ
TARGET = ./bin/bin2asc
LIBDIR = ../genlibs
LIBS = $(wildcard $(LIBDIR)/*.f90)
LIBOBJS = $(LIBS:.f90=.o)
SRCDIR = ./src
SRCS = $(wildcard $(SRCDIR)/*.f90)
SRCOBJS = $(SRCS:.f90=.o)
MODS = $(wildcard ./*.mod)

# 依存関係
$(TARGET): $(SRCOBJS) $(LIBOBJS)
	$(FC) -o $@ $^ $(LDFLAGS)
$(SRCOBJS): $(SRCS) $(LIBOBJS)
$(LIBOBJS): $(LIBS)

# サフィックスルール
.SUFFIXES: .o .f90
.f90.o:
	$(FC) $(FFLAGS) -o $@ -c $<

# 疑似ターゲット
.PHONY: all clean
all: $(TARGET)
clean:
	rm -f $(MODS) $(LIBOBJS) $(SRCOBJS) $(TARGET)
