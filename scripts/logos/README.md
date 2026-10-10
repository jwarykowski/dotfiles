# logos

Generates the README logos for keybars and the herdr plugins, in the style
of shepherd's: a neon pixel icon on a screen in a metal frame, a statusline,
and dotted pipes behind. Each project is one entry in `LOGOS` in
[`logo.py`](logo.py): a colour, an icon drawn on a 32x26 pixel grid, a corner
tag and a statusline mode and readout.

```sh
python3 -m venv /tmp/logos && /tmp/logos/bin/pip install fonttools
/tmp/logos/bin/python logo.py out
for f in out/*.svg; do resvg "$f" "${f%.svg}.png"; done
```

Copy `out/<project>.png` to the project's `assets/`, shown at 180px in its
README header.
