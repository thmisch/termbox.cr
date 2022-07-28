@[Link("termbox")]

lib LibTermbox
    struct TbEvent
        #type : UInt8
        #mod : UInt8
        #w : Int32
        #h : Int32
        #x : Int32
        #y : Int32

        type, mod : UInt8
        key  : UInt16
        ch   : Char
        w, h, x, y : Int32
    end
    fun tb_init     : Int32
    fun tb_shutdown : Int32
    
    fun tb_width  : Int32
    fun tb_height : Int32

    fun tb_clear   : Int32
    fun tb_present : Int32

    fun tb_set_cursor(cx : Int32, cy : Int32) : Int32 
    fun tb_hide_cursor : Int32
    
    fun tb_set_cell(x : Int32, y : Int32, ch : UInt32, fg : UInt32, bg : UInt32) : Int32
    fun tb_peek_event(tb_event : TbEvent*, timeout_ms : Int32) : Int32
    fun tb_poll_event(tb_event : TbEvent*) : Int32

    fun tb_print(x : Int32, y : Int32, fg : UInt32, bg : UInt32, str : LibC::Char*) : Int32
    # this isn't usually needed
    # fun tb_printf(x : Int32, y : Int32, fg : UInt32, bg : UInt32, fmt : LibC::Char*, ...) : Int32
end

module Tb
    @@event = LibTermbox::TbEvent.new

    # Event types
    enum Event
        Key = 1
        Resize
        Mouse
    end

    # Key modifiers
    @[Flags]
    enum Mod
        Alt
        Ctrl
        Shift
        Motion
    end

    # Colors
    enum Color
        Default
        Black
        Red
        Green
        Yellow
        Blue
        Magenta
        Cyan
        White
    end

    # color attributes
    @[Flags]
    enum Attr
        Bold = 0x0100
        Underline
        Reverse
        Italic
        Blink = 0x1000
    end 
    
    # special keys
    enum Key
        Backspace = 0x08
        Tab
        Enter = 0x0d
        Esc = 0x1b
        Space = 0x20
    end

    # all the ctrl key combinations
    enum CtrlKey
        A = 0x01
        B
        C
        D
        E
        F
        G
        H
        I
        J
        K
        L
        M
        N
        O
        P
        Q
        R
        S
        T
        U
        V
        W
        X
        Y
        Z
    end

    # Input modes
    @[Flags]
    enum Input
        Current
        Esc
        Alt
        Mouse
    end

    # Output modes
    enum Output
        Current
        Normal
        Color256
        Color216
        Grayscale
    end
    # TODO: also add terminal dependent keys somwhere

    def self.init
        LibTermbox.tb_init
    end

    def self.end
        LibTermbox.tb_shutdown
    end

    def self.width
        LibTermbox.tb_width
    end

    def self.height
        LibTermbox.tb_height
    end

    def self.clear
        LibTermbox.tb_clear
    end

    def self.show
        LibTermbox.tb_present
    end

    def self.set_cursor(to_x, to_y)
        LibTermbox.tb_set_cursor(to_x, to_y)
    end

    def self.hide_cursor
        LibTermbox.tb_hide_cursor
    end

    def self.set_cell(at_x, at_y, chr, fg = Color::Default, bg = Color::Default)
        LibTermbox.tb_set_cell(at_x, at_y, chr, fg, bg)
    end

    def self.poll
        LibTermbox.tb_poll_event(pointerof(@@event))
    end

    # wait up to `time_ms` milliseconds for an event 
    def self.poll(time time_ms)
        LibTermbox.tb_peek_event(pointerof(@@event), time_ms)
    end

    def self.puts(x, y, str, fg = Color::Default, bg = Color::Default)
        LibTermbox.tb_print(x, y, fg, bg, str)
    end

    def self.event
        @@event
    end
end
