Graphics = {}

Graphics.SIZES = {
    UP_GAP = 0,
    DOWN_GAP = 0,
    MAIN_SCREEN_WIDTH = 150,
    MAIN_SCREEN_HEIGHT = 141,
    DEFAULT_TEXT_OFFSET = {x = 0, y = 0},
    SCREEN_HEIGHT = 192,
    SCREEN_WIDTH = 256,
    BORDER_MARGIN = 5,
    MAIN_SCREEN_PADDING = 199,
    BADGE_COLOR_EDIT_PADDING = 349
}
Graphics.LOG_VIEWER = {
    TAB_WIDTH = 45,
    TAB_HEIGHT = 17
}
Graphics.ALIGNMENT_TYPE = {
    HORIZONTAL = 0,
    VERTICAL = 1,
    GRID = 2,
    NONE = 3
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
    [Graphics.BADGE_ALIGNMENT_TYPE.LEFT_AND_RIGHT] = "VERTICAL"
}
Graphics.SCROLL_DIRECTION = {
    UP = 0,
    DOWN = 1
}
Graphics.BUTTON_TEXT = {
    CHECKMARK = 0,
    FILLED_SQUARE = 1
}
Graphics.LETTER_PIXEL_LENGTHS = {
    ["<"] = 4,
    [">"] = 4,
    [" "] = 1,
    ["%"] = 7,
    ["0"] = 4,
    ["1"] = 4,
    ["2"] = 4,
    ["3"] = 4,
    ["4"] = 4,
    ["5"] = 4,
    ["6"] = 4,
    ["7"] = 4,
    ["8"] = 4,
    ["9"] = 4,
    ["="] = 4,
    [","] = 2,
    ["-"] = 2,
    ["."] = 1,
    ["("] = 2,
    [")"] = 2,
    ["+"] = 4,
    ["/"] = 4,
    a = 4,
    A = 5,
    b = 4,
    B = 4,
    c = 3,
    C = 4,
    d = 4,
    D = 5,
    e = 4,
    E = 4,
    f = 2,
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
    o = 4,
    O = 5,
    p = 4,
    P = 4,
    q = 4,
    Q = 5,
    r = 2,
    R = 5,
    s = 3,
    S = 4,
    t = 2,
    T = 3,
    u = 4,
    U = 4,
    v = 3,
    V = 5,
    w = 5,
    W = 7,
    x = 3,
    X = 4,
    y = 3,
    Y = 5,
    z = 3,
    Z = 4
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
    FLYING = 0xFF8797FF,
    POISON = 0xFF9B3C9E,
    GROUND = 0xFFEAC975,
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
    UNKNOWN = 0xFF68A090
}
Graphics.THEME_COLORS = {
    WHITE = 0xFFFFFFFF,
    BLACK = 0xFF000000,
    DARK_POSITIVE = 0xFF0343B0,
    DARK_NEGATIVE = 0xFFB40002,
    LIGHT_POSITIVE = 0xFFC8DDFF,
    LIGHT_NEGATIVE = 0xFFFDCDCD
}
Graphics.PATHS = {
    TRAINER_IMAGES = "ironmon_tracker/images/trainers/"
}
Graphics.MAIN_SCREEN_CONSTANTS = {
    STAT_PREDICTION_STATES = {
        {text = "", color = "Top box text color"},
        {text = "+", color = "Positive text color"},
        {text = "_", color = "Negative text color"},
        {text = "=", color = "Top box text color"}
    },
    BADGE_HORIZONTAL_WIDTH = 140,
    BADGE_HORIZONTAL_HEIGHT = 19,
    BADGE_VERTICAL_WIDTH = 19,
    BADGE_VERTICAL_HEIGHT = 131,
    STAT_INFO_HEIGHT = 73,
    HEALS_ACC_EVA_HEIGHT = 52,
    MOVE_HEADER_HEIGHT = 14,
    MOVE_ENTRY_HEIGHT = 10,
    MOVE_Y_START = 97,
    MOVE_FRAME_Y = 94,
    MOVE_INFO_HEIGHT = 46,
    BOTTOM_BOX_HEIGHT = 19,
    POKEMON_INFO_STAT_OFFSET = 10,
    POKEMON_INFO_X_OFFSET = 31,
    POKEMON_INFO_Y_START = 0,
    POKEMON_INFO_WIDTH = 96,
    POKEMON_INFO_HEIGHT = 51,
    STAT_FRAME_HEIGHT = 10
}
Graphics.MAIN_FRAME_BADGE_INDICES = {
    [Graphics.BADGE_ALIGNMENT_TYPE.ABOVE] = 1,
    [Graphics.BADGE_ALIGNMENT_TYPE.BELOW] = 3,
    [Graphics.BADGE_ALIGNMENT_TYPE.LEFT] = 1,
    [Graphics.BADGE_ALIGNMENT_TYPE.RIGHT] = 3,
    [Graphics.BADGE_ALIGNMENT_TYPE.ABOVE_AND_BELOW] = {1, 3},
    [Graphics.BADGE_ALIGNMENT_TYPE.LEFT_AND_RIGHT] = {1, 3},
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_ABOVE] = {1, 2},
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_BELOW] = {3, 3},
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_LEFT] = {1, 2},
    [Graphics.BADGE_ALIGNMENT_TYPE.BOTH_RIGHT] = {3, 3}
}
