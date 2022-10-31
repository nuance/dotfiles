#!/usr/bin/env python3

from dataclasses import dataclass
from enum import Enum
import typing

class Mod(Enum):
    Control = "\\x18@c"
    Alt = "\\x1b"
    Command = "\\x18@s"

    Shift = ""

@dataclass
class Key:
    key: str
    lower: str
    shifted: str

    ctrl: typing.Optional[str] = None
    command: bool = True


ALL_KEYS = [
    Key(key='A', lower='a', shifted='A', ctrl='\\x01'),
    Key(key='B', lower='b', shifted='B', ctrl='\\x02'),
    Key(key='C', lower='c', shifted='C', ctrl='\\x03'),
    Key(key='D', lower='d', shifted='D', ctrl='\\x04'),
    Key(key='E', lower='e', shifted='E', ctrl='\\x05'),
    Key(key='F', lower='f', shifted='F', ctrl='\\x06'),
    Key(key='G', lower='g', shifted='G', ctrl='\\x07'),
    Key(key='H', lower='h', shifted='H', ctrl='\\x08'),
    Key(key='I', lower='i', shifted='I', ctrl='\\x09'),
    Key(key='J', lower='j', shifted='J', ctrl='\\x0A'),
    Key(key='K', lower='k', shifted='K', ctrl='\\x0B'),
    Key(key='L', lower='l', shifted='L', ctrl='\\x0C'),
    Key(key='M', lower='m', shifted='M', ctrl='\\x0D'),
    Key(key='N', lower='n', shifted='N', ctrl='\\x0E'),
    Key(key='O', lower='o', shifted='O', ctrl='\\x0F'),
    Key(key='P', lower='p', shifted='P', ctrl='\\x10'),
    Key(key='Q', lower='q', shifted='Q', ctrl='\\x11'),
    Key(key='R', lower='r', shifted='R', ctrl='\\x12'),
    Key(key='S', lower='s', shifted='S', ctrl='\\x13'),
    Key(key='T', lower='t', shifted='T', ctrl='\\x14'),
    Key(key='U', lower='u', shifted='U', ctrl='\\x15'),
    Key(key='V', lower='v', shifted='V', ctrl='\\x16', command=False),
    Key(key='W', lower='w', shifted='W', ctrl='\\x17'),
    Key(key='X', lower='x', shifted='X', ctrl='\\x18'),
    Key(key='Y', lower='y', shifted='Y', ctrl='\\x19'),
    Key(key='Z', lower='z', shifted='Z', ctrl='\\x1A'),

    Key(key='Key1', lower='1', shifted='!'),
    Key(key='Key2', lower='2', shifted='@'),
    Key(key='Key3', lower='3', shifted='#'),
    Key(key='Key4', lower='4', shifted='$'),
    Key(key='Key5', lower='5', shifted='%'),
    Key(key='Key6', lower='6', shifted='^'),
    Key(key='Key7', lower='7', shifted='&'),
    Key(key='Key8', lower='8', shifted='*'),
    Key(key='Key9', lower='9', shifted='('),
    Key(key='Key0', lower='0', shifted=')'),

    Key(key='Backslash', lower='\\\\', shifted='|'),
    Key(key='Comma', lower=',', shifted='<'),
    Key(key='Equals', lower='=', shifted='+'),
    Key(key='Grave', lower='`', shifted='~'),
    Key(key='LBracket', lower='[', shifted='{'),
    Key(key='Minus', lower='-', shifted='_'),
    Key(key='Period', lower='.', shifted='>'),
    Key(key='RBracket', lower=']', shifted='}'),
    Key(key='Semicolon', lower=';', shifted=':'),
    Key(key='Slash', lower='/', shifted='?'),

    Key(key='Back', lower='\x7f', shifted='\x7f'),
    # Key(key='Return', lower='\x0d', shifted='\x0d'),
]

@dataclass
class Binding:
    key: str
    mods: typing.Sequence[Mod]
    char: str
    send_mod: bool = True

    @property
    def yaml(self) -> str:
        return f"  - {{key: {self.key}, mods: {'|'.join(mod.name for mod in self.mods)}, chars: \"{self.mods[0].value if self.send_mod else ''}{self.char}\"}}"
    

if __name__ == '__main__':
    bindings = []

    for key in ALL_KEYS:
        for mod in [Mod.Alt, Mod.Command]:
            if mod == Mod.Command and not key.command:
                continue
            
            bindings.extend([
                Binding(
                    key=key.key,
                    mods=[mod],
                    char=key.lower,
                ),
                Binding(
                    key=key.key,
                    mods=[mod, mod.Shift],
                    char=key.shifted,
                ),
            ])

        bindings.append(
            Binding(
                key=key.key,
                mods=[Mod.Control],
                char=key.ctrl if key.ctrl else key.lower,
                send_mod=not key.ctrl)
            )
            
    with open('keybindings.yml', 'w') as keybindings:
        keybindings.write("key_bindings:\n")
        
        for binding in bindings:
            keybindings.write(binding.yaml + "\n")
