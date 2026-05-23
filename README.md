### Build (Nix)
```
nix run
```
Builds via Nix and writes `resume.pdf` to repo root (tracked in git). Commit it to publish updates.

Raw build (output in `result/cv_3.pdf`, not tracked):
```
nix build
```

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
