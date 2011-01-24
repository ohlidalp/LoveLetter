________________________________________________________________________________

 LöveLëtter

 LuaDoc extensions for object-oriented code
________________________________________________________________________________

 Intro
 =====

 LöveLëtter (LL) is an extension to LuaDoc, a documentation generator for Lua
 language. It provides a combo of taglet/doclet/templates which make LuaDoc
 support object oriented programming with Lua and modern oo libraries.

 The name was inspired by the LÖVE project (www.love2d.org)

________________________________________________________________________________

 License
 =======

 Copyright (C) 2011 by Petr Ohlídal

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

________________________________________________________________________________

 Features and TODO list
 ======================

 LL is in very early development stage (I call it unmarked alpha), so there's
 not much of 'added value' to it at the moment. Also, you may (probably will)
 encounter debugging messages and broken HTML output.
 However, it still does work!

 Features
 --------
     * On parsing error, prints file name and line number.

 TODO
 ----
     * Support hand-made packages (without using package() function)
     * Recognize classes
     * Support data-type declarations (with links to class definitions)
     * Support inheritance (print list of inherited methods)
     * Recognize MiddleClass (https://github.com/kikito/middleclass) constructs.
     * And more to come...

________________________________________________________________________________

 Installation and usage
 ======================

 Because the tool is in early development, it's usage is pretty cumbersome.

 The contents of taglet/ and doclet/ directories must be put or symlinked to
 your distribution's luadoc directories. On Fedora 14, this is:
     /usr/share/lua/5.1/luadoc/doclet
     /usr/share/lua/5.1/luadoc/taglet
 Theoretically, putting these elsewhere in LUA_PATH should work, but it
 wasn't tested.

 The templates/ directory can be located anywhere, but you must specify it
 by -t parameter when running luadoc.

 To invoke luadoc with LL, run it like this:
     luadoc -t /path/to/your/templates
            --taglet luadoc.taglet.LoveLetter
            --doclet luadoc.doclet.LoveLetter
            -d directory_for_documentation
            [.. sources ..]



