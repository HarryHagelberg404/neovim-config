#### NEOVIM paired with KITTY (terminal) and TMUX (terminal multiplexor)

## A very pleasant duo with powerfull and useful plugins

very pog

will be updated each time when configured differently

Current terminal: kitty
Works really well and is very clean whe title bar is removed.
A lot of configurability.
Make sure to use firacode and specify accordingly in kitty.conf
I've included kitty.conf so the current config wont get lost.

## Prerequties

npm + node
python
perl
vim-plug (paru)
icons for chadtree
fira code font
kitty (terminal)
...

Currently using coc-tsserver for linting, make sure its installed and configured
Have been using telescope for mac window resizing

## Shortcuts / cheatsheet

will be updated when more shortcuts is added

```
--- TMUX ---
ctrl + b }: move pane
ctrl + b ": split H
ctrl + b %: split V
ctrl + b (any arrow): switch active pane
(hold) ctrl + b (any arrow): resize pane
ctrl + b c: create new window
ctrl + b n: move to next window
ctrl + b n: move to prev window
ctrl + b [: enable scroll in window
ctrl + b alt + 1: even V
ctrl + b alt + 2 even H
ctrl + b space: cycle
ctrl + b x: kill pane
ctrl + b !: kill all but pane
ctrl + b &: kill window
ctrl + b q: list pane NRs
ctrl + b: : enter tmux command
ctrl + b ;: rename window
ctrl + b <: menu
ctrl + b s: list windows
ctrl + b .: (arrow up or down) move window
ctrl + shift b: backwards search
--- NEOVIM ---
ctrl + c:		comment line
ctrl + e:		exit
ctrl + s:		save
shift + d: clear line after marker
ggyG: go to first line yank to last line
v + y: visual + yank
2yy: copy 2 lines
y2l/h: copy left/right
alt + any arrow:	switch pane
a:			create new file
a:			create new dir if it ends with a "/"
d:			delete the current file
ctrl + alt:		resize
--- ChadTree ---
C : move up from dir
c : move down to selected dir
b : set homedir to selected dir
s : select file or dir
S : clear selection
p : copy to selected dir
x : move to selected dir
X : mark file or dir
+ : size dir tree up
- : size dir tree down
w : open file vertically
W : open file remotely
rc : remote connect
rd : remote disconnect
re : edit hosts file
ff : find file
--- KITTY ---
Mouse selction: copy contents into clipboard
Right click: paste clipboard contents
```
