"
" This file contains all default format program definitions and links them to filetypes
"


" Python
if !exists('g:formatdef_autopep8')
    let g:formatdef_autopep8 = '"autopep8 - --line-range ".a:firstline." ".a:lastline." ".(&textwidth ? "--max-line-length=".&textwidth : "")'
endif

if !exists('g:formatters_python')
    let g:formatters_python = ['autopep8']
endif


" C#
if !exists('g:formatdef_astyle_cs')
    let g:formatdef_astyle_cs = '"astyle --mode=cs --style=ansi --indent-namespaces -pcH".(&expandtab ? "s".shiftwidth() : "t")'
endif

if !exists('g:formatters_cs')
    let g:formatters_cs = ['astyle_cs']
endif


" Generic C, C++, Objective-C
if !exists('g:formatdef_clangformat')
    let g:formatdef_clangformat = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename='.bufname('%').' -style=\"{BasedOnStyle: WebKit, AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(&expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() : 'UseTab: Always').'}\"'"
endif



" C
if !exists('g:formatdef_astyle_c')
    let g:formatdef_astyle_c = '"astyle --mode=c --style=ansi -pcH".(&expandtab ? "s".shiftwidth() : "t")'
endif

if !exists('g:formatters_c')
    let g:formatters_c = ['clangformat', 'astyle_c']
endif


" C++
if !exists('g:formatdef_astyle_cpp')
    let g:formatdef_astyle_cpp = '"astyle --mode=c --style=ansi -pcH".(&expandtab ? "s".shiftwidth() : "t")'
endif

if !exists('g:formatters_cpp')
    let g:formatters_cpp = ['clangformat', 'astyle_cpp']
endif


" Objective C
if !exists('g:formatters_objc')
    let g:formatters_objc = ['clangformat']
endif


" Java
if !exists('g:formatdef_astyle_java')
    let g:formatdef_astyle_java = '"astyle --mode=java --style=ansi -pcH".(&expandtab ? "s".shiftwidth() : "t")'
endif

if !exists('g:formatters_java')
    let g:formatters_java = ['astyle_java']
endif


" Javascript
if !exists('g:formatdef_jsbeautify_javascript')
    let g:formatdef_jsbeautify_javascript = '"js-beautify -f - -".(&expandtab ? "s ".shiftwidth() : "t").(&textwidth ? " -w ".&textwidth : "")'
endif

if !exists('g:formatdef_pyjsbeautify_javascript')
    let g:formatdef_pyjsbeautify_javascript = '"js-beautify -".(&expandtab ? "s ".shiftwidth() : "t").(&textwidth ? " -w ".&textwidth : "")." -"'
endif

if !exists('g:formatdef_jscs')
    let g:formatdef_jscs = '"jscs -x"'
endif

if !exists('g:formatters_javascript')
    let g:formatters_javascript = [
                \ 'jsbeautify_javascript',
                \ 'pyjsbeautify_javascript',
                \ 'jscs'
                \ ]
endif


" JSON
if !exists('g:formatdef_jsbeautify_json')
    let g:formatdef_jsbeautify_json = '"js-beautify -f - -".(&expandtab ? "s ".shiftwidth() : "t")'
endif

if !exists('g:formatdef_pyjsbeautify_json')
    let g:formatdef_pyjsbeautify_json = '"js-beautify -".(&expandtab ? "s ".shiftwidth() : "t")." -"'
endif

if !exists('g:formatters_json')
    let g:formatters_json = [
                \ 'jsbeautify_json',
                \ 'pyjsbeautify_json',
                \ ]
endif


" HTML
if !exists('g:formatdef_htmlbeautify')
    let g:formatdef_htmlbeautify = '"html-beautify -f - -s ".shiftwidth()'
endif

if !exists('g:formatdef_tidy_html')
    let g:formatdef_tidy_html = '"tidy -q --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".shiftwidth()." --vertical-space yes --tidy-mark no -wrap ".&textwidth'
endif

if !exists('g:formatters_html')
    let g:formatters_html = ['htmlbeautify', 'tidy_html']
endif



" XML
if !exists('g:formatdef_tidy_xml')
    let g:formatdef_tidy_xml = '"tidy -q -xml --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".shiftwidth()." --vertical-space yes --tidy-mark no -wrap ".&textwidth'
endif

if !exists('g:formatters_xml')
    let g:formatters_xml = ['tidy_xml']
endif


" XHTML
if !exists('g:formatdef_tidy_xhtml')
    let g:formatdef_tidy_xhtml = '"tidy -q --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".shiftwidth()." --vertical-space yes --tidy-mark no -asxhtml -wrap ".&textwidth'
endif

if !exists('g:formatters_xhtml')
    let g:formatters_xhtml = ['tidy_xhtml']
endif

" Ruby
if !exists('g:formatdef_rbeautify')
    let g:formatdef_rbeautify = '"rbeautify ".(&expandtab ? "-s -c ".shiftwidth() : "-t")'
endif

if !exists('g:formatters_ruby')
    let g:formatters_ruby = ['rbeautify']
endif


" CSS
if !exists('g:formatdef_cssbeautify')
    let g:formatdef_cssbeautify = '"css-beautify -f - -s ".shiftwidth()'
endif

if !exists('g:formatters_css')
    let g:formatters_css = ['cssbeautify']
endif


" SCSS
if !exists('g:formatdef_sassconvert')
    let g:formatdef_sassconvert = '"sass-convert -F scss -T scss --indent " . (&expandtab ? shiftwidth() : "t")'
endif

if !exists('g:formatters_scss')
    let g:formatters_scss = ['sassconvert']
endif


" Typescript
if !exists('g:formatdef_tsfmt')
    let g:formatdef_tsfmt = '"tsfmt --stdin %"'
endif

if !exists('g:formatters_typescript')
    let g:formatters_typescript = ['tsfmt']
endif


" Golang
" Two definitions are provided for two versions of gofmt.
" See issue #59
if !exists('g:formatdef_gofmt_1')
    let g:formatdef_gofmt_1 = '"gofmt -tabs=".(&expandtab ? "false" : "true")." -tabwidth=".shiftwidth()'
endif

if !exists('g:formatdef_gofmt_2')
    let g:formatdef_gofmt_2 = '"gofmt"'
endif

if !exists('g:formatters_go')
    let g:formatters_go = ['gofmt_1', 'gofmt_2']
endif

