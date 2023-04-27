# The name of the source files
SOURCES = hellomain.c hellofunc.c

# The name of the executable
EXE = results

# Flags for compilation (adding warnings are always good)
CFLAGS = -Wall

# Flags for linking
LDFLAGS =

# Libraries to link with
LIBS =

# Use the GCC frontend program when linking
LD = gcc

# This creates a list of object files from the source files
OBJECTS = $(SOURCES:%.c=%.o)

# The first target, this will be the default target if none is specified
# This target tells "make" to make the "all" target
default: all

# Having an "all" target is customary, so one could write "make all"
# It depends on the executable program
all: $(EXE)

# This will link the executable from the object files
$(EXE): $(OBJECTS)
    $(LD) $(LDFLAGS) $(OBJECTS) -o  $(EXE) $(LIBS)

# This is a target that will compile all the needed source files into object
# files.  We don't need to specify a command or any rules, "make" will handle
# it automatically
%.o: %.c

# Target to clean up after us
clean:
    -rm -f $(EXE)      # Remove the executable file
    -rm -f $(OBJECTS)  # Remove the object files

# Finally we need to tell "make" what source and header file each object file depends on
hellomain.o: hellomain.c helloheader.h
hellofunc.o: hellofunc.c helloheader.h
