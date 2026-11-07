SYNTHS := $(notdir $(patsubst %/,%,$(wildcard synths/*/)))
ENGINE ?= $(shell if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then echo docker; \
                  elif command -v podman >/dev/null 2>&1; then echo podman; fi)

.PHONY: all clean $(SYNTHS)

all: $(SYNTHS)

$(SYNTHS):
	@test -n "$(ENGINE)" || { echo "please install docker or podman" >&2; exit 1; }
	$(ENGINE) build -t synth-builder-$@ synths/$@
	rm -rf out/$@ && mkdir -p out/$@
	id=$$($(ENGINE) create synth-builder-$@) && \
	  $(ENGINE) cp $$id:/out/. out/$@/; rc=$$?; \
	  $(ENGINE) rm $$id >/dev/null; exit $$rc
	@echo "완료: $(CURDIR)/out/$@"

clean:
	rm -rf out
