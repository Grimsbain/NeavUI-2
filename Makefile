VERSION ?= $(shell git tag --list --contains HEAD)

ifeq ($(strip $(VERSION)),)
VERSION := $(shell git rev-parse --short HEAD)
endif

NEAVUI-GRIM_ZIP = NeavUI-Grimsbain_$(VERSION).zip

PROJECTS = $(NEAVUI-GRIM_ZIP)

all: build

build: $(PROJECTS)

clean:
	$(RM) *.zip

$(NEAVUI-GRIM_ZIP):
	zip -r $@ Fonts Interface LICENSE -x '*.git*' '.DS_Store'
