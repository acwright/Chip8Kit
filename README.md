# Chip8Kit

A Swift package for interpreting Chip-8 ROMs

## Usage
--------

```swift
// ROM
let rom: [Byte] = [...]

// Initialize Chip8 with ROM data loaded at address 0x200
let chip8 = Chip8(rom: rom)

// Or load ROM data at specific address
let address: Word = 0x0200

chip8.load(rom: rom, address: address)

// Reset and erase the RAM
chip8.reset()

// Reset without erasing the RAM
chip8.reset(soft: true)

// Emulate one CPU cycle
chip8.cycle()

// Emulate one timer tick
chip8.tick()
```

## More Info
------------

- [https://en.wikipedia.org/wiki/CHIP-8](https://en.wikipedia.org/wiki/CHIP-8)
- [http://devernay.free.fr/hacks/chip8/C8TECH10.HTM](http://devernay.free.fr/hacks/chip8/C8TECH10.HTM)
- [http://www.multigesture.net/articles/how-to-write-an-emulator-chip-8-interpreter/](http://www.multigesture.net/articles/how-to-write-an-emulator-chip-8-interpreter/)
