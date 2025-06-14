.POSIX:

SRC       = ../src
TESTS     = ../tests
BUILD     = build

OBJS      = $(BUILD)/time.o $(BUILD)/Logger.o
LOGTEST   = $(BUILD)/LoggerTest

all: build

build:
	mkdir -p $(BUILD)
	cd $(BUILD) && voc $(SRC)/time.Mod $(SRC)/Logger.Mod

test: $(LOGTEST)
	cd $(BUILD) \
	&& ./LoggerTest > actual.txt \
	&& awk -f $(TESTS)/test.awk actual.txt $(TESTS)/expected.txt

$(LOGTEST): build
	cd $(BUILD) \
	&& voc $(SRC)/time.Mod $(SRC)/Logger.Mod $(TESTS)/LoggerTest.Mod -m

clean:
	rm -rf $(BUILD)
