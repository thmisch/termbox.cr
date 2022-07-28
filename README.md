# termbox.cr
This is a crystal wrapper around the termbox library.

## Example
The following code includes a bit of everything what termbox offers.

```crystal
require "termbox"

Tb.init
Tb.set_cursor 0, 1

i = 0
bool = false
loop do
    Tb.puts x: 0, y: 0, str: "Ay yo, this is a test. Ünicode!"
    Tb.puts 0, 5, "Another test!: #{[i, Tb.height, Tb.width]}", fg: Tb::Color::Red
    Tb.show
    Tb.poll
    Tb.clear

    x = Tb.event.ch
    case x
    when 'q'
        break
    end
    Tb.puts 0, 1, "X" * Tb.width, bg: Tb::Color::Cyan
    Tb.puts 0, 1, "#{[Tb.event.ch, Tb.event.key, Tb.event.mod, bool]}"
    Tb.puts 0, 2, Tb::Key.from_value?(Tb.event.key).to_s
    Tb.puts 0, 3, Tb::CtrlKey.from_value?(Tb.event.key).to_s
    Tb.puts 0, 4, Tb::Mod.from_value?(Tb.event.mod).to_s
    Tb.show
    i += 1
    bool = !bool
end
Tb.end
```

## Getting started
Being a wrapper, you should first install the actual termbox2 library on your
system. This is how I do it:

```sh
git clone https://github.com/termbox/termbox2
cd termbox2
make libtermbox.so

# install the library system wide
sudo make install clean
```

when done, add the following to your project's `shard.yml`: 

```yaml
dependencies:
  termbox:
    github: thmisch/termbox.cr
```

Ready to code!

## Differences from termbox
termbox provides a really powerful interface with just a few functions,
this wrapper builds on that and simplifies the API even more, to suit the
*"crystal"* style of coding:

- Methods are provided in a class
- cooler method names
- Default values for these methods

## ToDo's
There's still some functionality that's missing, and i'm working on adding that.

## License
Unlicense
