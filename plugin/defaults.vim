if !exists("g:formatprg_cs") | let g:formatprg_cs = "astyle" | endif
if !exists("g:formatprg_args_expr_cs") && !exists("g:formatprg_args_cs")
    let g:formatprg_args_expr_cs = '"--mode=cs --style=ansi --indent-namespaces -pcH".(&expandtab ? "s".&shiftwidth : "t")'
endif

if !exists("g:formatprg_c") | let g:formatprg_c = "astyle" | endif
if !exists("g:formatprg_args_expr_c") && !exists("g:formatprg_args_c")
    let g:formatprg_args_expr_c = '"--mode=c --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
endif

if !exists("g:formatprg_cpp") | let g:formatprg_cpp = "astyle" | endif
if !exists("g:formatprg_args_expr_cpp")  && !exists("g:formatprg_args_cpp")
    let g:formatprg_args_expr_cpp = '"--mode=c --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
endif

if !exists("g:formatprg_java") | let g:formatprg_java = "astyle" | endif
if !exists("g:formatprg_args_expr_java")  && !exists("g:formatprg_args_java")
    let g:formatprg_args_expr_java = '"--mode=java --style=ansi -pcH".(&expandtab ? "s".&shiftwidth : "t")'
endif

if !exists("g:formatprg_python") | let g:formatprg_python = "autopep8" | endif
if !exists("g:formatprg_args_expr_python")  && !exists("g:formatprg_args_python")
    let g:formatprg_args_expr_python = '"/dev/stdin ".(&textwidth ? "--max-line-length=".&textwidth : "")'
endif

if !exists("g:formatprg_xml") | let g:formatprg_xml = "tidy" | endif
if !exists("g:formatprg_args_expr_xml")  && !exists("g:formatprg_args_xml") 
    let g:formatprg_args_expr_xml = '"-q -xml --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".&shiftwidth." --vertical-space yes --tidy-mark no -wrap ".&textwidth'
endif

if !exists("g:formatprg_xhtml") | let g:formatprg_xhtml = "tidy" | endif
if !exists("g:formatprg_args_expr_xhtml")  && !exists("g:formatprg_args_xhtml")
    let g:formatprg_args_expr_xhtml = '"-q --show-errors 0 --show-warnings 0 --force-output --indent auto --indent-spaces ".&shiftwidth." --vertical-space yes --tidy-mark no -asxhtml -wrap ".&textwidth'
endif

if !exists("g:formatprg_css") | let g:formatprg_css = "css-beautify" | endif
if !exists("g:formatprg_args_expr_css")  && !exists("g:formatprg_args_css")
    let g:formatprg_args_expr_css = '"-f - -s ".&shiftwidth'
endif

if !exists("g:formatprg_html") | let g:formatprg_html = "html-beautify" | endif
if !exists("g:formatprg_args_expr_html")  && !exists("g:formatprg_args_html")
    let g:formatprg_args_expr_html = '"-f - -s ".&shiftwidth'
endif

if !exists("g:formatprg_javascript") | let g:formatprg_javascript = "js-beautify" | endif
if !exists("g:formatprg_args_expr_javascript") && !exists("g:formatprg_args_javascript")
    let g:formatprg_args_expr_javascript = '"-f - -".(&expandtab ? "s ".&shiftwidth : "t").(&textwidth ? " -w ".&textwidth : "")'
endif

if !exists("g:formatprg_json") | let g:formatprg_json = "js-beautify" | endif
if !exists("g:formatprg_args_expr_json") && !exists("g:formatprg_args_json")
    let g:formatprg_args_expr_json = '"-f - -".(&expandtab ? "s ".&shiftwidth : "t")'
endif
