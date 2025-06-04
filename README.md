# dsuh.sh

This repo contains the source and output for `dsuh.sh` -- my personal website.


It uses the C preprocessor (`cpp` called through `gcc -E`) as a templating
system to generate static content for my blog. The system is pretty hacky and
idiosyncractic so I don't expect anyone to use the skeleton of what I have
here, but feel free to take a look and take whatever you want (well, other than
my actual manuscripts). I use `sass` for my css and `pandoc` for embedding my
Markdown manuscripts into HTML. Math is rendered using katex.


## Dev Setup
I use a nix-shell to setup my dev environment.

```
git clone https://github.com/dvdhs/dsuh.sh
cd dsuh.sh
nix-shell
make -j
```

This builds the website into the output directory `o/`.

To automatically rebuilt when files are saved/changed, you can use the provided
`server` command.

```
make server
```
Unfortunately, automatic reload is not supported so you will still need to
manually reload the pages to observe changes.
