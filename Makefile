#slideshow -t s5blank -o output derek
EXTENSION ?= .md
THEME ?= goozbach
OUTPUTDIR ?= output

NAMES := $(patsubst %.md,%,$(wildcard *.md))
IMAGES := $(wildcard *.jpg) $(wildcard *.png) $(wildcard *.gif)

$(OUTPUTDIR)/%.html: $(CONFIG) %.md $(IMAGES)
	slideshow b -t $(THEME) -o $(OUTPUTDIR) $(shell echo $@ | sed -e 's/$(OUTPUTDIR)\/\(.*\)\.html/\1.md/')
	cd $(OUTPUTDIR) && ln -sf $(shell echo $@ | sed -e 's/$(OUTPUTDIR)\/\(.*\.html\)/\1/') index.html && cd -
	if ls *.png &>/dev/null; then cp -v *.png $(OUTPUTDIR); fi
	if ls *.jpg &>/dev/null; then cp -v *.jpg $(OUTPUTDIR); fi
	if ls *.gif &>/dev/null; then cp -v *.gif $(OUTPUTDIR); fi

all: $(NAMES)

.SECONDEXPANSION:
$(NAMES): $$(patsubst %,output/%.html,$$@)

.PHONY: all $(NAMES) clean update remake

clean:
	rm -rf $(OUTPUTDIR)

remake: clean all
