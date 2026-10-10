# Project logos in the shepherd family: a neon pixel-art icon on a screen
# with a hex texture and a statusline, in a bevelled metal frame, over dotted
# "pipes" tracing the icon. 704x768, shown at 180px in a two-column README
# header. One colour per project.
#
# usage: logo.py OUT_DIR   writes <name>.svg for every logo in LOGOS
#        then render each: resvg OUT_DIR/<name>.svg <name>.png
#
# needs fontTools (pip install fonttools) and Source Code Pro (Fedora:
# adobe-source-code-pro-fonts); text is drawn as paths, so the SVGs render
# the same anywhere.
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from textpath import text_path  # noqa: E402  (sits next to this file)

FONT = "/usr/share/fonts/adobe-source-code-pro-fonts/SourceCodePro-Medium.otf"
W, H = 704, 768
GW, GH = 32, 26  # icon grid


class Grid:
    def __init__(self):
        self.on = set()  # bright pixels
        self.dim = set()  # filled areas, drawn fainter

    def px(self, x, y, dim=False):
        if 0 <= x < GW and 0 <= y < GH:
            (self.dim if dim else self.on).add((x, y))

    def hline(self, x0, x1, y, dim=False):
        for x in range(x0, x1 + 1):
            self.px(x, y, dim)

    def vline(self, x, y0, y1, dim=False):
        for y in range(y0, y1 + 1):
            self.px(x, y, dim)

    def rect(self, x0, y0, x1, y1):
        self.hline(x0, x1, y0)
        self.hline(x0, x1, y1)
        self.vline(x0, y0, y1)
        self.vline(x1, y0, y1)

    def fill(self, x0, y0, x1, y1, dim=True):
        for y in range(y0, y1 + 1):
            self.hline(x0, x1, y, dim)

    def line(self, x0, y0, x1, y1):
        n = max(abs(x1 - x0), abs(y1 - y0))
        for i in range(n + 1):
            self.px(round(x0 + (x1 - x0) * i / n), round(y0 + (y1 - y0) * i / n))

    def ring(self, cx, cy, r, fill=False):
        for y in range(GH):
            for x in range(GW):
                d = math.hypot(x - cx, y - cy)
                if abs(d - r) < 0.6:
                    self.px(x, y)
                elif fill and d < r - 0.6:
                    self.px(x, y, True)


def keybars(g):
    # six keycap bars, bottom up, with a peak dot above each
    heights = [2, 4, 5, 3, 4, 1]
    peaks = [3, 5, 5, 4, 5, 3]
    for i, (h, p) in enumerate(zip(heights, peaks)):
        x = 2 + i * 5
        for level in range(5):
            y = 22 - level * 4
            if level < h:
                g.rect(x, y - 2, x + 3, y)
                g.fill(x + 1, y - 1, x + 2, y - 1)
            elif level + 1 == p:
                g.fill(x, y - 2, x + 3, y, dim=False)


def herdr_gh(g):
    # a pull request: branch from the base, merge arrow into it
    g.ring(8, 4, 2.5)
    g.ring(8, 21, 2.5)
    g.ring(23, 21, 2.5)
    g.vline(8, 7, 18)
    g.vline(23, 10, 18)
    g.line(23, 10, 19, 6)
    g.hline(13, 19, 6)
    g.line(13, 6, 16, 3)
    g.line(13, 6, 16, 9)


def herdr_zsa_lights(g):
    # a block of keycaps, one lit, with light rays
    for row in range(3):
        for col in range(5):
            x, y = 2 + col * 6, 10 + row * 5
            if (col, row) == (2, 0):
                g.rect(x, y, x + 4, y + 3)
                g.fill(x + 1, y + 1, x + 3, y + 2, dim=False)
            else:
                g.rect(x, y, x + 4, y + 3)
    g.vline(16, 2, 6)
    g.line(10, 4, 12, 7)
    g.line(22, 4, 20, 7)
    g.line(6, 7, 9, 8)
    g.line(26, 7, 23, 8)


def herdr_pomodoro(g):
    # a tomato with a stalk, its face a clock
    g.ring(16, 15, 9.5, fill=True)
    g.vline(16, 2, 5)
    g.line(16, 5, 12, 3)
    g.line(16, 5, 20, 3)
    g.vline(16, 9, 15)
    g.line(16, 15, 20, 18)
    g.px(16, 15)


def herdr_nvim(g):
    # an editor window whose selection is sent out to an agent
    g.rect(1, 3, 21, 22)
    g.hline(1, 21, 6)
    for x in (3, 5, 7):
        g.px(x, 4)
    g.hline(4, 13, 9)
    g.hline(4, 17, 12, dim=True)
    g.hline(4, 15, 13, dim=True)
    g.hline(4, 10, 16)
    g.hline(4, 14, 19)
    g.hline(22, 29, 12)
    g.line(29, 12, 26, 9)
    g.line(29, 12, 26, 15)


LOGOS = [
    # name, colour, icon, corner tag, statusline mode, statusline readout
    ("keybars", "#3dff7a", keybars, "~/cava", "LIVE", "30fps"),
    ("herdr-gh", "#c18cff", herdr_gh, "herdr", "PR", "#412 ok"),
    ("herdr-zsa-lights", "#3de0ff", herdr_zsa_lights, "herdr", "AGENT", "blocked"),
    ("herdr-pomodoro", "#ff5a4a", herdr_pomodoro, "herdr", "WORK", "24:59"),
    ("herdr.nvim", "#ffa23d", herdr_nvim, ":w", "NORMAL", ":HerdrSend"),
]


def shade(hex_colour, f):
    """lighten (f > 0) or darken (f < 0) a #rrggbb colour"""
    r, g, b = (int(hex_colour[i : i + 2], 16) for i in (1, 3, 5))
    t = 255 if f > 0 else 0
    f = abs(f)
    return "#%02x%02x%02x" % tuple(round(c + (t - c) * f) for c in (r, g, b))


def bounds(g):
    pts = g.on | g.dim
    xs, ys = [x for x, _ in pts], [y for _, y in pts]
    return min(xs), min(ys), max(xs) + 1, max(ys) + 1


def pixels(g, ox, oy, cell, colour, opacity_on, opacity_dim):
    out = []
    x0, y0, _, _ = bounds(g)
    for pts, op in ((g.dim, opacity_dim), (g.on, opacity_on)):
        for x, y in sorted(pts):
            x, y = x - x0, y - y0
            out.append(
                f'<rect x="{ox + x * cell + 1}" y="{oy + y * cell + 1}" width="{cell - 2}" '
                f'height="{cell - 2}" rx="1.5" fill="{colour}" opacity="{op}"/>'
            )
    return "".join(out)


def edges(g):
    """only the outline pixels of a shape, for the background pipes"""
    pts = g.on | g.dim
    out = Grid()
    for x, y in pts:
        if any((x + dx, y + dy) not in pts for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1))):
            out.on.add((x, y))
    return out


def label(text, x, y, size, fill, anchor="start", filt=""):
    d, end = text_path(FONT, text, 0, 0, size)
    if anchor == "end":
        x -= end
    elif anchor == "middle":
        x -= end / 2
    d, _ = text_path(FONT, text, x, y, size)
    return f'<path d="{d}" fill="{fill}"{filt}/>'


def svg(name, colour, draw, tag, mode, readout):
    g = Grid()
    draw(g)
    light, dark, deep = shade(colour, 0.45), shade(colour, -0.55), shade(colour, -0.85)
    fx, fy, fw, fh = 132, 150, 440, 480  # frame, leaving room for the pipes
    x0, y0, x1, y1 = bounds(g)
    iw, ih = x1 - x0, y1 - y0
    cell = min(14, (fw - 90) // iw, (fh - 230) // ih)
    ox = fx + (fw - iw * cell) // 2
    oy = fy + 62 + (fh - 230 - ih * cell) // 2
    # background: the icon's outline as oversized pixel pipes
    big = round(cell * 2.5)
    bx, by = (W - iw * big) // 2, (H - ih * big) // 2
    # each pipe pixel as a 2x2 of small dots, like nvim-shepherd's dotted lines
    dots = []
    x0e, y0e, _, _ = bounds(g)
    q = big / 2
    for x, y in sorted(edges(g).on):
        for dx in (0, 1):
            for dy in (0, 1):
                dots.append(
                    f'<rect x="{bx + (x - x0e) * big + dx * q + q * 0.2:.1f}" '
                    f'y="{by + (y - y0e) * big + dy * q + q * 0.2:.1f}" width="{q * 0.6:.1f}" '
                    f'height="{q * 0.6:.1f}" rx="1" fill="{colour}" opacity="0.32"/>'
                )
    pipes = "".join(dots)
    icon = pixels(g, ox, oy, cell, "url(#pix)", 1, 0.32)
    size = min(70, 380 / (0.6 * len(name)))
    title = label(name, fx + fw / 2, fy + fh - 84, size, "url(#word)", "middle", ' filter="url(#glow)"')
    # statusline: mode pill, file, readout
    sy = fy + fh - 52
    pill_w = 18 + 11 * len(mode)
    status = (
        f'<rect x="{fx + 26}" y="{sy}" width="{fw - 52}" height="24" rx="5" fill="{deep}" opacity="0.9"/>'
        f'<rect x="{fx + 26}" y="{sy}" width="{pill_w}" height="24" rx="5" fill="{colour}"/>'
        + label(mode, fx + 26 + pill_w / 2, sy + 17, 15, "#0b0d10", "middle")
        + label(readout, fx + fw - 38, sy + 17, 15, light, "end")
    )
    corner = label(tag, fx + 30, fy + 44, 20, shade(colour, -0.15))
    star = (
        f'<path d="M{fx + fw + 6} {fy + fh - 34} l6 18 l18 6 l-18 6 l-6 18 l-6 -18 l-18 -6 l18 -6 z" '
        f'fill="#e8ecf2" opacity="0.85"/>'
    )
    return f'''<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">
  <defs>
    <radialGradient id="bg" cx="0.5" cy="0.4" r="0.8">
      <stop offset="0" stop-color="#20252d"/><stop offset="1" stop-color="#0c0e12"/>
    </radialGradient>
    <linearGradient id="metal" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#4a525e"/><stop offset="0.5" stop-color="#1c2027"/><stop offset="1" stop-color="#2e343d"/>
    </linearGradient>
    <linearGradient id="pix" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="{light}"/><stop offset="1" stop-color="{colour}"/>
    </linearGradient>
    <linearGradient id="word" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="{light}"/><stop offset="1" stop-color="{colour}"/>
    </linearGradient>
    <radialGradient id="screen" cx="0.5" cy="0.42" r="0.7">
      <stop offset="0" stop-color="{shade(colour, -0.88)}"/><stop offset="1" stop-color="#07080b"/>
    </radialGradient>
    <pattern id="hex" width="28" height="48" patternUnits="userSpaceOnUse">
      <path d="M14 0 L28 8 L28 24 L14 32 L0 24 L0 8 Z M14 32 L14 48" fill="none" stroke="{colour}" stroke-width="1"/>
    </pattern>
    <filter id="glow" x="-30%" y="-30%" width="160%" height="160%">
      <feGaussianBlur stdDeviation="5" result="b"/>
      <feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge>
    </filter>
    <filter id="haze" x="-30%" y="-30%" width="160%" height="160%">
      <feGaussianBlur stdDeviation="18"/>
    </filter>
    <clipPath id="inner"><rect x="{fx + 12}" y="{fy + 12}" width="{fw - 24}" height="{fh - 24}" rx="16"/></clipPath>
  </defs>
  <rect width="{W}" height="{H}" rx="28" fill="url(#bg)"/>
  <g filter="url(#glow)">{pipes}</g>
  <rect x="{fx - 6}" y="{fy - 6}" width="{fw + 12}" height="{fh + 12}" rx="30" fill="url(#metal)"/>
  <rect x="{fx}" y="{fy}" width="{fw}" height="{fh}" rx="24" fill="url(#screen)"/>
  <g clip-path="url(#inner)">
    <rect x="{fx}" y="{fy}" width="{fw}" height="{fh}" fill="url(#hex)" opacity="0.10"/>
    <ellipse cx="{fx + fw / 2}" cy="{oy + ih * cell / 2}" rx="{iw * cell * 0.55}" ry="{ih * cell * 0.55}"
             fill="{colour}" opacity="0.16" filter="url(#haze)"/>
  </g>
  <rect x="{fx + 12}" y="{fy + 12}" width="{fw - 24}" height="{fh - 24}" rx="16" fill="none"
        stroke="{colour}" stroke-width="4" filter="url(#glow)"/>
  <rect x="{fx + 20}" y="{fy + 20}" width="{fw - 40}" height="{fh - 40}" rx="11" fill="none"
        stroke="{colour}" stroke-width="1" opacity="0.35"/>
  {corner}
  <g filter="url(#glow)">{icon}</g>
  {title}
  {status}
  {star}
</svg>
'''


if __name__ == "__main__":
    out = sys.argv[1]
    os.makedirs(out, exist_ok=True)
    for name, *rest in LOGOS:
        open(os.path.join(out, f"{name}.svg"), "w").write(svg(name, *rest))
