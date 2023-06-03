# The name of the source files
SOURCES = main.c foo.c bar.c

# The name of the executable
EXE = main

# Flags for compilation (adding warnings are always good)
CFLAGS = -g -Wall

# Flags for linking, e.g. -L./lib
LDFLAGS =

# Libraries to link with, e.g.  -lcurl
LIBS = -lcurl

# Use the GCC frontend program when compiling
CC = gcc

# Use the GCC frontend program when linking
LD = gcc

# place to store auto-generated dependencies
DEPDIR = .d

#
# Nothing to change below
#

# This creates a list of object files from the source files
OBJECTS = $(SOURCES:%.c=%.o)

.PHONY: all
# Having an "all" target is customary, so one could write "make all"
# It depends on the executable program
all: $(EXE)

# The first target, this will be the default target if none is specified
# This target tells "make" to make the "all" target
default: all


# This will link the executable from the object files
$(EXE): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $(EXE) $(LIBS)

# Target to clean up after us
.PHONY: clean
clean:
	rm -f $(EXE)		# Remove the executable file
	rm -f $(OBJECTS)	# Remove the object files
	rm -Rf $(DEPDIR)	# Remove the dependencies files
	rm -Rf $(EXE).dSYM	# Remove the symbols

# Advanced auto-dependency, from:
# http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/

$(shell mkdir -p $(DEPDIR) >/dev/null)
DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td

COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
POSTCOMPILE = mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d

%.o : %.c
%.o : %.c $(DEPDIR)/%.d
	$(COMPILE.c) $(OUTPUT_OPTION) $<
	$(POSTCOMPILE)

$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

-include $(patsubst %,$(DEPDIR)/%.d,$(basename $(SOURCES)))
