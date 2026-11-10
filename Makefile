SYNTHS := $(notdir $(patsubst %/,%,$(wildcard synths/*/)))
ENGINE ?= $(shell if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then echo docker; \
                  elif command -v podman >/dev/null 2>&1; then echo podman; fi)
LV2_DIR ?= $(HOME)/.lv2


.PHONY: all clean install $(SYNTHS)

all: $(SYNTHS)

$(SYNTHS):
	@test -n "$(ENGINE)" || { echo "please install docker or podman" >&2; exit 1; }
	$(ENGINE) build -t synth-builder-$@ synths/$@
	rm -rf out/$@ && mkdir -p out/$@
	id=$$($(ENGINE) create synth-builder-$@) && \
	  $(ENGINE) cp $$id:/out/. out/$@/; rc=$$?; \
	  $(ENGINE) rm $$id >/dev/null; exit $$rc
	@echo "done: $(CURDIR)/out/$@"

install:
	@test -d out || { echo "nothing built yet, run make first" >&2; exit 1; }
	mkdir -p $(LV2_DIR)
	find out -type d -name '*.lv2' -prune -exec cp -r {} $(LV2_DIR)/ \;

clean:
	rm -rf out
