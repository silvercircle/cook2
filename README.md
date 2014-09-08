﻿Cook2
=====
Cook is a fast incremental build tool intended for projects in D language. In contrast to most other build automation programs, Cook by default requires no project hierarchy description - it automatically collects information about imports from D source files in project directory. Moreover, Cook caches dependencies between modules, and then uses this cache to find out which modules had been changed and need recompiling.

This is a revamped version of the project, original Сook 1.x.x сan be found here: http://github.com/gecko0307/cook.

Requirements
------------
Cook is written in D and supports Windows and Linux. By default it works with Digital Mars D compiler (DMD), but you can use it with other compilers (and, for some extent, even with other languages!) as well by writing proper configuration file. Documentation is on the way, stay tuned.

License
-------
Copyright (c) 2011-2014 Timur Gafarov. Distributed under the Boost Software License, Version 1.0. (See accompanying file COPYING or at http://www.boost.org/LICENSE_1_0.txt)

