"
" This file contains all default format program definitions and links them to filetypes
"


" Python
let g:formatdef_autopep8 = '"autopep8 - ".(&textwidth ? "--max-line-length=".&textwidth : "")'
"let g:formatdef_ranged_autopep8 = "'autopep8 - --range '.line(\"'<\").' '.line(\"'>\").' '.(&textwidth ? '--max-line-length='.&textwidth : '')"
let g:formatdef_ranged_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline.' '.(&textwidth ? '--max-line-length='.&textwidth : '')"
let g:formatdef_test = '"asdf"'
let g:formatdef_another_autopep8 = '"autopep8 - --indent-size 2 ".(&textwidth ? "--max-line-length=".&textwidth : "")'
if !exists('g:formatters_python')
    let g:formatters_python = [
                \ 'autopep8',
                \ ]
                "\ 'test',
                "\ 'another_autopep8',
endif


" C#
let g:formatdef_astyle_cs = '"astyle --mode=cs --style=ansi --indent-namespaces -pcH".(&expandtab ? "s".&shiftwidth : "t")'
if !exists('g:formatters_cs')
    let g:formatters_cs = ['astyle_cs']
endif


" Generic C, C++, Objective-C
let g:formatdef_clangformat = '"clang-format --assume-filename=".bufname("%")." -style=\"{BasedOnStyle: WebKit, AlignTrailingComments: true, ".(&textwidth ? "ColumnLimit: ".&textwidth.", " : "").(&expandtab ? "UseTab: Never, IndentWidth: ".&shiftwidth : "UseTab: Always")."}\""'
let g:formatdef_ranged_clangformat = "'clang-format -lines='.line(\"'<\").':'.line(\"'>\").' --assume-filename='.bufname('%').' -style=\"{BasedOnStyle: WebKit, AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(&expandtab ? 'UseTab: Never, IndentWidth: '.&shiftwidth : 'UseTab: Always').'}\"'"


" C
let g:formatdef_astyle_c = '"astyle --mode=c --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
if !exists('g:formatters_c')
    let g:formatters_c = ['clangformat', 'astyle_c']
    "let g:formatters_c = ['astyle_c']
endif


" C++
let g:formatdef_astyle_cpp = '"astyle --mode=c --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
if !exists('g:formatters_cpp')
    let g:formatters_cpp = ['clangformat', 'astyle_cpp']
endif


" Objective C
if !exists('g:formatters_objc')
    let g:formatters_objc = ['clangformat']
endif


" Java
let g:formatdef_astyle_java = '"astyle --mode=java --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
if !exists('g:formatters_java')
    let g:formatters_java = ['astyle_java']
endif


" HTML
let g:formatdef_htmlbeautify = '"html-beautify -f - -s ".&shiftwidth'
if !exists('g:formatters_html')
    let g:formatters_html = ['htmlbeautify']
endif


" Javascript
let g:formatdef_jsbeautify_javascript = '"js-beautify -f - -".(&expandtab ? "s ".&shiftwidth : "t").(&textwidth ? " -w ".&textwidth : "")'
if !exists('g:formatters_javascript')
    let g:formatters_javascript = ['jsbeautify_javascript']
endif


" JSON
let g:formatdef_jsbeautify_json = '"js-beautify -f - -".(&expandtab ? "s ".&shiftwidth : "t")'
if !exists('g:formatters_json')
    let g:formatters_json = ['jsbeautify_json']
endif


" Ruby
let g:formatdef_rbeautify = 'rbeautify (&expandtab ? "-s -c ".&shiftwidth : "-t")'
if !exists('g:formatters_ruby')
    let g:formatters_ruby = ['rbeautify']
endif


" CSS
let g:formatdef_cssbeautify = '"css-beautify -f - -s ".&shiftwidth'
if !exists('g:formatters_css')
    let g:formatters_css = ['cssbeautify']
endif


" SCSS
let g:formatdef_sassconvert = '"sass-convert -F scss -T scss --indent " . (&expandtab ? &shiftwidth : "t")'
if !exists('g:formatters_scss')
    let g:formatters_scss = ['sassconvert']
endif


" Typescript
let g:formatdef_tsfmt = '"tsfmt --stdin %"'
if !exists('g:formatters_typescript')
    let g:formatters_typescript = ['tsfmt']
endif


" XML
let g:formatdef_tidy_xml = '"tidy -q -xml --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".&shiftwidth." --vertical-space yes --tidy-mark no -wrap ".&textwidth'
if !exists('g:formatters_xml')
    let g:formatters_xml = ['tidy_xml']
endif


" XHTML
let g:formatdef_tidy_xhtml = '"tidy -q --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".&shiftwidth." --vertical-space yes --tidy-mark no -asxhtml -wrap ".&textwidth'
if !exists('g:formatters_xhtml')
    let g:formatters_xhtml = ['tidy_xhtml']
endif


