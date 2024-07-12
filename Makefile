ifdef PS5_PAYLOAD_SDK
    include $(PS5_PAYLOAD_SDK)/toolchain/prospero.mk
else
    $(error PS5_PAYLOAD_SDK is undefined)
endif

PS5_HOST ?= ps5

CXXFLAGS := -g -O1
LDFLAGS  := -lSDL2 -lSDL2main -lSDL2_ttf -lSDL2_image -lz -lpng -lbz2 -lfreetype

CXXFLAGS += $(shell $(PS5_PAYLOAD_SDK)/target/bin/sdl2-config --cflags)
LDFLAGS  += $(shell $(PS5_PAYLOAD_SDK)/target/bin/sdl2-config --libs)

SRCS := main.cpp
OBJS := $(SRCS:.cpp=.o)

ELF := menu.elf

all: $(ELF)

$(ELF): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(ELF) $(OBJS)

