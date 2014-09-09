/*
Copyright (c) 2011-2014 Timur Gafarov 

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
*/

module main;

import std.stdio;

import project;
import cmdopt;
import conf;
import dmodule;
import session;

static string versionString = "2.0.0";

void main(string[] args)
{
    CmdOptions ops = new CmdOptions(args);

    if (ops.help)
    {
        printHelp(ops.program, versionString);
        return;
    }

    Config conf = new Config();
    BuildSession bs = new BuildSession(ops, conf);
    Project proj = new Project(ops, conf);
    bs.build(proj);
}

void printHelp(string programName, string programVersion)
{
    writeln
    (
        "Cook2 ", programVersion, "\n",
        "A tool for building projects in D programming language\n",
        "\n"
        "Usage:\n",
        programName, " [MAINMODULE] [OPTIONS]\n",
        "\n"
        "OPTIONS:\n"
        "\n"
        "--help            Display this information\n"
        "--emulate         Don't write anything to disk\n"
        "--quiet           Don't print messages\n"
        "--rebuild         Force rebuilding all modules\n"
        "--nocache         Disable reading/writing module cache\n"
        "--lib             Build a static library instead of an executable\n"
        "--release         Compile modules in release mode\n"
        "--noconsole       Under Windows, hide application console window\n"
        "--strip           Remove debug symbols from resulting binary using \"strip\"\n"
        "                  (currently works only under Linux)\n"
        "-o FILE           Compile to specified filename\n"
        "--clean           Remove temporary data (object files, cache, etc.)\n"
        "--cache FILE      Use specified cache file\n"
        "--rc FILE         Under Windows, compile and link specified resource file\n"
      "-c\"...\"           Pass specified option(s) to compiler\n"
      "-l\"...\"           Pass specified option(s) to linker\n"
        "--run             Run program after compilation (does't work in emulation mode)\n"
        "--dc FILE         Specify default configuration file (default \"default.conf\")\n"
    );
}

