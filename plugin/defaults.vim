if !exists("g:formatters_python") | let g:formatters_python = [] | endif
let g:formatters_python += [
            \ '"autopep8 - ".(&textwidth ? "--max-line-length=".&textwidth : "")',
            \ '"asdf"',
            \ '"autopep8 - --indent-size 2 ".(&textwidth ? "--max-line-length=".&textwidth : "")'
            \ ]

"if !exists("g:formatters_cs")
    "let g:formatters_cs = ['"astyle --mode=cs --style=ansi --indent-namespaces -pcH".(&expandtab ? "s".&shiftwidth : "t")']
"endif

"if !exists("g:formatters_c")
    "let g:formatters_c = ['"astyle --mode=c --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")']
"endif

"if !exists("g:formatprg_cpp") | let g:formatprg_cpp = "astyle" | endif
"if !exists("g:formatprg_args_expr_cpp")  && !exists("g:formatprg_args_cpp")
    "let g:formatprg_args_expr_cpp = '"--mode=c --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
"endif

"if !exists("g:formatprg_objc") | let g:formatprg_objc = "clang-format" | endif
"if !exists("g:formatprg_args_expr_objc") && !exists("g:formatprg_args_objc")
    "let g:formatprg_args_expr_objc = '"-style=\"{BasedOnStyle: WebKit, AlignTrailingComments: true, ".(&textwidth ? "ColumnLimit: ".&textwidth.", " : "").(&expandtab ? "UseTab: Never, IndentWidth: ".&shiftwidth : "UseTab: Always")."}\""'
    "endif

"if !exists("g:formatprg_java") | let g:formatprg_java = "astyle" | endif
"if !exists("g:formatprg_args_expr_java")  && !exists("g:formatprg_args_java")
    "let g:formatprg_args_expr_java = '"--mode=java --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
"endif

"if !exists("g:formatprg_xml") | let g:formatprg_xml = "tidy" | endif
"if !exists("g:formatprg_args_expr_xml")  && !exists("g:formatprg_args_xml") 
    "let g:formatprg_args_expr_xml = '"-q -xml --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".&shiftwidth." --vertical-space yes --tidy-mark no -wrap ".&textwidth'
"endif

"if !exists("g:formatprg_xhtml") | let g:formatprg_xhtml = "tidy" | endif
"if !exists("g:formatprg_args_expr_xhtml")  && !exists("g:formatprg_args_xhtml")
    "let g:formatprg_args_expr_xhtml = '"-q --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".&shiftwidth." --vertical-space yes --tidy-mark no -asxhtml -wrap ".&textwidth'
"endif

"if !exists("g:formatprg_css") | let g:formatprg_css = "css-beautify" | endif
"if !exists("g:formatprg_args_expr_css")  && !exists("g:formatprg_args_css")
    "let g:formatprg_args_expr_css = '"-f - -s ".&shiftwidth'
"endif

"if !exists("g:formatprg_scss") | let g:formatprg_scss = "sass-convert" | endif
"if !exists("g:formatprg_args_expr_scss") && !exists("g:formatprg_args_scss")
    "let g:formatprg_args_expr_scss = '"-F scss -T scss --indent " . (&expandtab ? &shiftwidth : "t")'
"endif

"if !exists("g:formatprg_html") | let g:formatprg_html = "html-beautify" | endif
"if !exists("g:formatprg_args_expr_html")  && !exists("g:formatprg_args_html")
    "let g:formatprg_args_expr_html = '"-f - -s ".&shiftwidth'
"endif

"if !exists("g:formatprg_javascript") | let g:formatprg_javascript = "js-beautify" | endif
"if !exists("g:formatprg_args_expr_javascript") && !exists("g:formatprg_args_javascript")
    "let g:formatprg_args_expr_javascript = '"-f - -".(&expandtab ? "s ".&shiftwidth : "t").(&textwidth ? " -w ".&textwidth : "")'
"endif

"if !exists("g:formatprg_typescript") | let g:formatprg_typescript = "tsfmt" | endif
"if !exists("g:formatprg_args_expr_typescript") && !exists("g:formatprg_args_typescript")
    "let g:formatprg_args_expr_typescript = '"--stdin %"'
"endif

"if !exists("g:formatprg_json") | let g:formatprg_json = "js-beautify" | endif
"if !exists("g:formatprg_args_expr_json") && !exists("g:formatprg_args_json")
    "let g:formatprg_args_expr_json = '"-f - -".(&expandtab ? "s ".&shiftwidth : "t")'
"endif

"if !exists("g:formatprg_ruby") | let g:formatprg_ruby = "rbeautify" | endif
"if !exists("g:formatprg_args_expr_ruby") && !exists("g:formatprg_args_ruby")
    "let g:formatprg_args_expr_ruby = '(&expandtab ? "-s -c ".&shiftwidth : "-t")'
"endif
