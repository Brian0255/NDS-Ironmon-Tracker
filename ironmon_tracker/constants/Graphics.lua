Graphics = {}

Graphics.SIZES = {
    UP_GAP = 0,
    DOWN_GAP = 0,
    MAIN_SCREEN_WIDTH = 150,
    MAIN_SCREEN_HEIGHT = 141,
    DEFAULT_TEXT_OFFSET = { x = 0, y = 0 },
    SCREEN_HEIGHT = 160,
    SCREEN_WIDTH = 256,
    BORDER_MARGIN = 5,
    MAIN_SCREEN_PADDING = 199,
    BADGE_COLOR_EDIT_PADDING = 349
}
Graphics.ALIGNMENT_TYPE = {
    HORIZONTAL = 0,
    VERTICAL = 1,
    NONE = 2
}
Graphics.HOVER_ALIGNMENT_TYPE = {
    ALIGN_ABOVE = 0,
    ALIGN_BELOW = 1
}
Graphics.BADGE_ALIGNMENT_TYPE = {
    ABOVE = 0,
    BELOW = 1,
    RIGHT = 2,
    LEFT = 3,
    BOTH_LEFT = 4,
    BOTH_RIGHT = 5,
    BOTH_ABOVE = 6,
    BOTH_BELOW = 7,
    ABOVE_AND_BELOW = 8,
    LEFT_AND_RIGHT = 9
}
Graphics.BADGE_ORIENTATION = {
    [Graphics.BADGE_ALIGNMENT_TYPE.ABOVE] = "HORIZONTAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.BELOW] = "HORIZONTAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.LEFT] = "VERTICAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.RIGHT] = "VERTICAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_LEFT] = "VERTICAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_RIGHT] = "VERTICAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_ABOVE] = "HORIZONTAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_BELOW] = "HORIZONTAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.ABOVE_AND_BELOW] = "HORIZONTAL",
    [Graphics.BADGE_ALIGNMENT_TYPE.LEFT_AND_RIGHT] = "VERTICAL",

}
Graphics.BUTTON_TEXT = {
    CHECKMARK = 0,
    FILLED_SQUARE = 1,
}
Graphics.LETTER_PIXEL_LENGTHS = {
    [" "] = 1,
    ["%"] = 7,
    ["1"] = 3,
    ["2"] = 3,
    ["3"] = 3,
    ["4"] = 3,
    ["5"] = 3,
    ["6"] = 3,
    ["7"] = 3,
    ["8"] = 3,
    ["9"] = 3,
    ["="] = 4,
    [","] = 2,
    ["-"] = 2,
    a = 4,
    A = 5,
    b = 4,
    B = 4,
    c = 3,
    C = 3,
    d = 4,
    D = 5,
    e = 4,
    ["\233"] = 4,
    E = 4,
    f = 3,
    F = 4,
    g = 4,
    G = 5,
    h = 4,
    H = 5,
    i = 1,
    I = 1,
    j = 2,
    J = 2,
    k = 4,
    K = 5,
    l = 1,
    L = 3,
    m = 7,
    M = 6,
    n = 4,
    N = 5,
    o = 3,
    O = 4,
    p = 3,
    P = 4,
    q = 3,
    Q = 5,
    r = 2,
    R = 5,
    s = 3,
    S = 4,
    t = 3,
    T = 3,
    u = 4,
    U = 4,
    v = 3,
    V = 5,
    w = 5,
    W = 7,
    x = 3,
    X = 4,
    y = 4,
    Y = 5,
    z = 3,
    Z = 5,
}
Graphics.FONT = {
    DEFAULT_FONT_SIZE = 9,
    DEFAULT_FONT_FAMILY = "Franklin Gothic Medium"
}
Graphics.TEXT = {
    PLACEHOLDER = "---",
    NO_PP = "---",
    NO_POWER = "---",
    ALWAYS_HITS = "---"
}
Graphics.TYPE_COLORS = {
    NORMAL = 0xFFA7A879,
    FIGHTING = 0xFFB82A23,
    FLYING = 0xFFA88FEF,
    POISON = 0xFF9B3C9E,
    GROUND = 0xFFDCC06A,
    ROCK = 0xFFB5A03B,
    BUG = 0xFFA8B92A,
    GHOST = 0xFF6F5797,
    STEEL = 0xFFB8B8D0,
    FIRE = 0xFFE87E2E,
    WATER = 0xFF708FEF,
    GRASS = 0xFF80C956,
    ELECTRIC = 0xFFF3D036,
    PSYCHIC = 0xFFEF5285,
    ICE = 0xFF9FD9D8,
    DRAGON = 0xFF7131F6,
    DARK = 0xFF6E5848,
    FAIRY = 0xFFEE99AC,
    UNKNOWN = 0xFF68A090 -- For the "Curse" move in Gen 2 - 4
}

