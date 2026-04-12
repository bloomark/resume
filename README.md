### Build (Nix)
```
nix build
```
Output: `result/cv_3.pdf`

### Dev shell
```
nix develop
xelatex cv_3.tex
```

### Troubleshooting

**`experimental Nix feature 'nix-command' is disabled`**

Add to `~/.config/nix/nix.conf`:
```
experimental-features = nix-command flakes
```

**View build logs**
```
nix log .
```
