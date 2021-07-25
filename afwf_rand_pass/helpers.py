# -*- coding: utf-8 -*-

from __future__ import unicode_literals
import random
import string

charset_upper = set(string.uppercase)
charset_lower = set(string.lowercase)
charset_digits = set(string.digits)
charset_symbols = set("!%@#&^*")
charset_banned = set("lIO0")
charset = set.union(
    charset_upper,
    charset_lower,
    charset_digits,
    charset_symbols,
).difference(charset_banned)
charset_list = list(charset)


def random_password(length, uppercase=True, symbol=True):
    password = "".join([random.choice(charset_list) for _ in range(length)])
    if uppercase:
        if len(charset_upper.intersection(password)) == 0:
            return random_password(length, uppercase=uppercase, symbol=symbol)
    if symbol:
        if len(charset_symbols.intersection(password)) == 0:
            return random_password(length, uppercase=uppercase, symbol=symbol)
    return password
