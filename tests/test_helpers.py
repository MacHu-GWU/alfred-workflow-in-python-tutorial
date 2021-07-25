# -*- coding: utf-8 -*-

import unittest
from afwf_rand_pass.helpers import random_password


class Test(unittest.TestCase):
    def test_random_password(self):
        assert len(random_password(8)) == 8


if __name__ == '__main__':
    unittest.main()
