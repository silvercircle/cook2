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

module conf;

import std.stdio;
import std.file;
import lexer;

version(Windows) 
	string OS = "windows";
else version(linux) string OS = "linux";

final class Config
{
    string[string] data;

    bool has(string key, bool platformSpecific = true)
    {
        if (platformSpecific)
        {
            immutable string oskey = OS ~ "." ~ key;
            if (oskey in data) return true;
        }
        if (key in data) return true;
        else return false;
    }

    string get(string key, bool platformSpecific = true)
    {
        if (platformSpecific)
        {
            string oskey = OS ~ "." ~ key;
            if (oskey in data) return data[oskey];
        }
        if (key in data) return data[key];
        else return "";
    }

    /*
     * TODO: The following should be rewrote in more clever way...
     */
    void set(string key, string value, bool platformSpecific = true)
    {
        if (platformSpecific)
        {
            if (key.length > 7 && (key[0..7] == "windows" || key[0..5] == "linux"))
            {
            }
            else
            {
                string oskey = OS ~ "." ~ key;
                data[oskey] = value;
            }
        }
        data[key] = value;
    }

    void append(string key, string value, bool platformSpecific = true)
    {
        if (platformSpecific)
        {
            if (key.length > 7 && (key[0..7] == "windows" || key[0..5] == "linux"))
            {
            }
            else
            {
                string oskey = OS ~ "." ~ key;
                data[oskey] ~= value;
            }
        }
        data[key] ~= value;
    }
}

/*
 * Parse configuration file
 */

enum
{
    tIdentifier,
    tColon,
    tValue,
    tSemicolon
}

void readConfiguration(Config options, string filename)
{
    auto text = readText(filename);
    auto lex = new Lexer(text);
    lex.addDelimiters();
    auto nextToken = tIdentifier;
    string tempId = "_default_";

    string lexeme = "";
    do 
    {
        lexeme = lex.getLexeme();
        if (lexeme.length > 0)
        {
            if (lexeme == ";")
            {
                if (nextToken == tSemicolon)
                    nextToken = tIdentifier;
                else throw new Exception("unexpected \"" ~ lexeme ~ "\"");
            }
            else if (lexeme == ":")
            {
                if (nextToken == tColon)
                    nextToken = tValue;
                else throw new Exception("unexpected \"" ~ lexeme ~ "\"");
            }
            else
            {
                if (nextToken == tIdentifier) 
                {
                    tempId = lexeme;
                    nextToken = tColon;
                }
                else if (nextToken == tValue) 
                {
                    if (lexeme[0] == '\"' && lexeme[$-1] == '\"')
                    {
                        if (lexeme.length > 2)
                            options.set(tempId, lexeme[1..$-1]);
                        else options.set(tempId, "");
                    }
                    else options.set(tempId, lexeme);
                    tempId = "_default_";
                    nextToken = tSemicolon;
                }
                else throw new Exception("unexpected \"" ~ lexeme ~ "\"");
            }
        }
    } 
    while (lexeme.length > 0);
}

string formatPattern(string pat, Config data, dchar formattingSymbol)
{
    string result;
    string temp;
    bool appending = true;
    foreach(c; pat)
    {
        if (c == formattingSymbol) 
        {
            if (appending)
            {
                appending = false;
            }
            else
            {
                appending = true;
                if (data.has(temp))
                    result ~= formatPattern(data.get(temp), data, formattingSymbol); //data[temp]
                temp = "";
            }
        }
        else
        {
            if (appending) result ~= c;
            else temp ~= c;
        }
    }
    return result;
}

