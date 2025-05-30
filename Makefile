SRC             := src
HTML_SRC        := $(SRC)/html
SASS_SRC        := $(SRC)/css
COMPONENTS_SRC  := $(SRC)/components
MANUSCRIPTS_SRC := $(SRC)/manuscripts
BLOGS_SRC       := $(HTML_SRC)/blogs
OUT             := o

SRC_HTML_COMPONENTS := $(wildcard $(COMPONENTS_SRC)/*)

SRC_SASS := $(wildcard $(SASS_SRC)/*.scss)
OUT_SASS := $(SRC_SASS:$(SASS_SRC)/%.scss=$(OUT)/%.css)

SRC_HTML := $(wildcard $(HTML_SRC)/*.html)
OUT_HTML := $(SRC_HTML:$(HTML_SRC)/%.html=o/%.html)

SRC_MANUSCRIPTS := $(wildcard $(MANUSCRIPTS_SRC)/*.md)
OUT_MANUSCRIPTS := $(SRC_MANUSCRIPTS:$(MANUSCRIPTS_SRC)/%.md=$(HTML_SRC)/%.html.body)

SRC_BLOGS := $(wildcard $(HTML_SRC)/blogs/*.html)
OUT_BLOGS   := $(SRC_BLOGS:$(HTML_SRC)/blogs/%.html=o/blogs/%.html) 

null  :=
space := $(null) #
comma := ,

BLOGS_NAMESPACE_LIST := $(foreach file,$(SRC_BLOGS),$(basename $(notdir $(file))))

# we additionally add defines that allow each to know where the blog actually
# is in filepath space.
BLOGS_FILEPATH_DEFINES := $(foreach ns,$(BLOGS_NAMESPACE_LIST),-D$(ns)_FILEPATH=blogs/$(ns).html)

# we pass a list of all blog namespaces as -DBLOGS=title1,title2,...
BLOGS_NAMESPACE_LIST := $(subst $(space),$(comma),$(strip $(BLOGS_NAMESPACE_LIST)))

CC         := gcc
# -E (use preprocessor) -P (no comments) -x c (read as C)
# -w (supress all warnings) -Isrc (all includes are from src root)
CC_FLAGS   := -E -P -x c -w -Isrc

CC_DEFINES := -DBLOGS=$(BLOGS_NAMESPACE_LIST)
CC_DEFINES += $(BLOGS_FILEPATH_DEFINES)

CC_MACRO_INCLUDES := $(patsubst %,-imacros %,$(SRC_BLOGS))

CC_ALL := $(CC) $(CC_FLAGS) $(CC_DEFINES) $(CC_MACRO_INCLUDES)

all: $(OUT_HTML) $(OUT_SASS) $(OUT_BLOGS)
	rsync -a --delete static/ o/static/

src/html/%.html.body: $(MANUSCRIPTS_SRC)/%.md
	pandoc --mathjax -f markdown -t html $< -o $@

o/%.html: $(HTML_SRC)/%.html $(OUT_SASS) $(SRC_HTML_COMPONENTS) $(SRC_BLOGS) $(OUT_MANUSCRIPTS)
	mkdir -p $(dir $@) && $(CC_ALL) -o $@ $<

o/%.css: $(SRC_SASS)
	sass $< $@

.PHONY: clean
clean:
	rm -rf o/*

.PHONY: template-blog
template-blog:
	m4 src/templates/blog_template.m4 -Dfilename=$(NAME) > $(BLOGS_SRC)/$(NAME).html

.PHONY: server 
server:
	fswatch src Makefile | xargs -I{} -n1 make -j &\
	python -m http.server 7979 --directory o
