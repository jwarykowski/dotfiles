# text_path(font, text, x, y, size) -> SVG path data for text set in a font,
# baseline at y, so the logo needs no installed fonts to render
from fontTools.ttLib import TTFont
from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen

_fonts = {}

def text_path(font, text, x, y, size, tracking=0):
    f = _fonts.setdefault(font, TTFont(font))
    gs, cmap = f.getGlyphSet(), f.getBestCmap()
    scale = size / f["head"].unitsPerEm
    pen = SVGPathPen(gs)
    for ch in text:
        g = cmap[ord(ch)]
        gs[g].draw(TransformPen(pen, (scale, 0, 0, -scale, x, y)))
        x += gs[g].width * scale + tracking
    return pen.getCommands(), x
