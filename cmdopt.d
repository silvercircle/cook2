/*
Copyright (c) 2013-2014 Timur Gafarov 

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

module cmdopt;

import std.stdio;
import std.getopt;
import std.c.process;

class CmdOptions
{
    bool help = false;
    bool emulate = false;
    bool quiet = false;
    bool rebuild = false;
    bool nocache = false;
    bool lib = false;
    bool release = false;
    bool noconsole = false;
    bool strip = false;
    bool clean = false;
    bool run = false;
    bool _debug_ = false;
    bool nobacktrace = false;
	bool https = false;
    bool rsp = false;

    string output;
    string cache;
    string rc;
    string cflags;
    string lflags;
    string conf;
    string s;

    string dump;

    string program;
    string[] targets;

    this(string[] args)
    {
        try{ getopt(
          args,
          "help|h",    &help,
          "emulate|e", &emulate,
          "quiet|q",   &quiet,
          "rebuild|r", &rebuild,
          "nocache",   &nocache,
          "lib",       &lib,
          "release",   &release,
          "noconsole", &noconsole,
          "strip",     &strip,
          "output|o",  &output,
          "clean",     &clean,
          "cache",     &cache,
          "rc",        &rc,
          "cflags|c",  &cflags,
          "lflags|l",  &lflags,
          "run",       &run,
          "dc",        &conf,
          "conf",      &conf,
          "debug",     &_debug_,
          "nobacktrace", &nobacktrace,
          "s",         &s,
          "dump",      &dump,
		  "https",     &https,
          "rsp",       &rsp
        );}
        catch(Exception)
        {
            writeln("Illegal option");
            std.c.process.exit(1);
        }

        program = args[0];
        targets = args[1..$];
    }
}

