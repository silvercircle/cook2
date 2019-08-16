Cook2
=====
Cook is a fast incremental build tool intended for projects in D language. In contrast to most other build automation programs, Cook by default requires no project hierarchy description - it automatically collects information about imports from D source files in project directory. Moreover, Cook caches dependencies between modules, and then uses this cache to find out which modules had been changed and need recompiling.

> NOTE: Cook is not being developed anymore. This repository is in maintainance mode, and there will be only bugfix releases. Please, consider using Dub instead of Cook.

This has been forked from https://github.com/gecko0307/cook2

I have made changes so that it compiles with latest DMD (2.087.1 currently) and LDC2 (1.14 or later). No other changes were made so far.


License
-------
Copyright (c) 2011-2019 Timur Gafarov. Distributed under the Boost Software License, Version 1.0. (See accompanying file COPYING or at http://www.boost.org/LICENSE_1_0.txt)

