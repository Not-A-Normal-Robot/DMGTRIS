logo = b"\x01\x10\xCE\xEF\x00\x00\x44\xAA\x00\x74\x00\x18\x11\x95\x00\x34\x00\x1A\x00\xD5\x00\x22\x00\x69\x6F\xF6\xF7\x73\x09\x90\xE1\x10\x44\x40\x9A\x90\xD5\xD0\x44\x30\xA9\x21\x5D\x48\x22\xE0\xF8\x60"

with open('bin/DMGTRIS.GBC', 'rb+') as f:
    f.seek(0x104)
    f.write(logo)
