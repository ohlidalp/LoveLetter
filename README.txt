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

 Features and roadmap
 ======================

 LL is in very early development stage, so there's
 not much of 'added value' to it at the moment. Also, you may (probably will)
 encounter debugging messages and broken HTML output.
 However, it still does work!

 Features
 --------
     * On parsing error, prints file name and line number.
     * Supports data-type declaration for variables.
     * Supports grouping files into packages; a files in package will have
       a 'package' page in resulting doc, showing contents of all files together

 TODO
 ----
     * Support hand-made packages (without using package() function)
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

________________________________________________________________________________

 Documentation guidelines
 ========================

 LL is an extension of LuaDoc, so to understand it well you should read LuaDoc's
 manual first. LL preserves meanings of standart tags, only extends some and
 adds new. Unknown tags are reported as warnings, but parsing continues.

 Tags
 ----

     @type:enum      ~ Type of documented entity = [table | function | class]
                     ~ Alias for LuaDoc's @class
     @package:string ~ Package name.
                     ~ Allows grouping multiple files/modules into one package.

 Datatypes
 ---------

 LL supports optional specifying data types for @param, @field and @return.
 To specify datatype, use this syntax:
     @tag name : datatype [description]
 The spaces around the ':' are optional. Without ':', all text is treated as
 description (standart behaviour).

 For return types, specify datatype as follows
     @return : datatype [description]
 Again, the space after ':' is optional. Without ':', all text is treated as
 description (standart behaviour).

________________________________________________________________________________

 Documentation object reference
 ==============================

 LuaDoc works in two phases:
 * The taglet parses source files and generates Documentation object
 * The doclet reads Documentation and renders target files.

 Documentation
 {
     files:HashMap   = <string, DocumentationElement> -- files without package, indexed by file name
     modules:HashMap = <string, DocumentationElement> -- modules without package, indexed by module
     packages:HashMap = <string, Package>             -- indexed by package name
     classes          = <string, string>              -- List of file names indexed by class names
 }

 Package -- LL
 {
     name:string
     description:string
     files:HashMap   = <string, DocumentationElement> -- indexed by file name
     modules:HashMap = <string, DocumentationElement> -- indexed by module
     functions:HashMap = <string, Block>              -- only functions, indexed by function name
     tables:HashMap    = <string, Block>              -- only table definitions, indexed by table name
     classes           = <string, string>             -- List of file names indexed by class names
 }

 DocumentationElement
 {
     type:string       = [ "file" | "module" ]
     name:string                             -- full path of file or name of module
     doc:List          = <Block>             -- all documentation blocks, number-indexed
     functions:HashMap = <string, Block>     -- only functions, indexed by function name
     tables:HashMap    = <string, Block>     -- only table definitions, indexed by table name
 }

 Block
 {
     class:string  = ["module" | "function" | "table" | "class" ]
     name:string
     summary:string
     description:string
     comment:List  = <string>
     code:List     = <string>
     param:HashMap = <string, table{datatype,description}>
     methods:HashMap = <string, Block>
     superclasses:List = <string, Block>
 }
