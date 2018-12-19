
"
" This file contains default settings and all format program definitions and links these to filetypes
"


" Vim-autoformat configuration variables
if !exists('g:autoformat_autoindent')
    let g:autoformat_autoindent = 1
endif

if !exists('g:autoformat_retab')
    let g:autoformat_retab = 1
endif

if !exists('g:autoformat_remove_trailing_spaces')
    let g:autoformat_remove_trailing_spaces = 1
endif

if !exists('g:autoformat_verbosemode')
    let g:autoformat_verbosemode = 0
endif


" Python
if !exists('g:formatdef_autopep8')
    " Autopep8 will not do indentation fixes when a range is specified, so we
    " only pass a range when there is a visual selection that is not the
    " entire file. See #125.
    let g:formatdef_autopep8 = '"autopep8 -".(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? " --range ".a:firstline." ".a:lastline : "")." ".(&textwidth ? "--max-line-length=".&textwidth : "")'
endif

" There doesn't seem to be a reliable way to detect if are in some kind of visual mode,
" so we use this as a workaround. We compare the length of the file against
" the range arguments. If there is no range given, the range arguments default
" to the entire file, so we return false if the range comprises the entire file.
function! g:DoesRangeEqualBuffer(first, last)
    return line('$') != a:last - a:first + 1
endfunction

" Yapf supports multiple formatter styles: pep8, google, chromium, or facebook
if !exists('g:formatter_yapf_style')
    let g:formatter_yapf_style = 'pep8'
endif
if !exists('g:formatdef_yapf')
    let s:configfile_def   = "'yapf -l '.a:firstline.'-'.a:lastline"
    let s:noconfigfile_def = "'yapf --style=\"{based_on_style:'.g:formatter_yapf_style.',indent_width:'.shiftwidth().(&textwidth ? ',column_limit:'.&textwidth : '').'}\" -l '.a:firstline.'-'.a:lastline"
    let g:formatdef_yapf   = "g:YAPFFormatConfigFileExists() ? (" . s:configfile_def . ") : (" . s:noconfigfile_def . ")"
endif

function! g:YAPFFormatConfigFileExists()
    return len(findfile(".style.yapf", expand("%:p:h").";")) || len(findfile("setup.cfg", expand("%:p:h").";")) || filereadable(exists('$XDG_CONFIG_HOME') ? expand('$XDG_CONFIG_HOME/yapf/style') : expand('~/.config/yapf/style'))
endfunction

if !exists('g:formatdef_black')
    let g:formatdef_black = '"black -q ".(&textwidth ? "-l".&textwidth : "")." -"'
endif

if !exists('g:formatters_python')
    let g:formatters_python = ['autopep8','yapf', 'black']
endif


" C#
if !exists('g:formatdef_astyle_cs')
    if filereadable('.astylerc')
        let g:formatdef_astyle_cs = '"astyle --mode=cs --options=.astylerc"'
    elseif filereadable(expand('~/.astylerc')) || exists('$ARTISTIC_STYLE_OPTIONS')
        let g:formatdef_astyle_cs = '"astyle --mode=cs"'
    else
        let g:formatdef_astyle_cs = '"astyle --mode=cs --style=ansi --indent-namespaces -pcH".(&expandtab ? "s".shiftwidth() : "t")'
    endif
endif

if !exists('g:formatters_cs')
    let g:formatters_cs = ['astyle_cs']
endif


" Generic C, C++, Objective-C
if !exists('g:formatdef_clangformat')
    let s:configfile_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=file'"
    let s:noconfigfile_def = "'clang-format -lines='.a:firstline.':'.a:lastline.' --assume-filename=\"'.expand('%:p').'\" -style=\"{BasedOnStyle: WebKit, AlignTrailingComments: true, '.(&textwidth ? 'ColumnLimit: '.&textwidth.', ' : '').(&expandtab ? 'UseTab: Never, IndentWidth: '.shiftwidth() : 'UseTab: Always').'}\"'"
    let g:formatdef_clangformat = "g:ClangFormatConfigFileExists() ? (" . s:configfile_def . ") : (" . s:noconfigfile_def . ")"
endif

function! g:ClangFormatConfigFileExists()
    return len(findfile(".clang-format", expand("%:p:h").";")) || len(findfile("_clang-format", expand("%:p:h").";"))
endfunction



" C
if !exists('g:formatdef_astyle_c')
    if filereadable('.astylerc')
        let g:formatdef_astyle_c = '"astyle --mode=c --options=.astylerc"'
    elseif filereadable(expand('~/.astylerc')) || exists('$ARTISTIC_STYLE_OPTIONS')
        let g:formatdef_astyle_c = '"astyle --mode=c"'
    else
        let g:formatdef_astyle_c = '"astyle --mode=c --style=ansi -pcH".(&expandtab ? "s".shiftwidth() : "t")'
    endif
endif

if !exists('g:formatters_c')
    let g:formatters_c = ['clangformat', 'astyle_c']
endif


" C++
if !exists('g:formatdef_astyle_cpp')
    if filereadable('.astylerc')
        let g:formatdef_astyle_cpp = '"astyle --mode=c --options=.astylerc"'
    elseif filereadable(expand('~/.astylerc')) || exists('$ARTISTIC_STYLE_OPTIONS')
        let g:formatdef_astyle_cpp = '"astyle --mode=c"'
    else
        let g:formatdef_astyle_cpp = '"astyle --mode=c --style=ansi -pcH".(&expandtab ? "s".shiftwidth() : "t")'
    endif
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
    if filereadable('.astylerc')
        let g:formatdef_astyle_java = '"astyle --mode=java --options=.astylerc"'
    elseif filereadable(expand('~/.astylerc')) || exists('$ARTISTIC_STYLE_OPTIONS')
        let g:formatdef_astyle_java = '"astyle --mode=java"'
    else
        let g:formatdef_astyle_java = '"astyle --mode=java --style=java -pcH".(&expandtab ? "s".shiftwidth() : "t")'
    endif
endif

if !exists('g:formatters_java')
    let g:formatters_java = ['astyle_java']
endif


" Javascript
if !exists('g:formatdef_jsbeautify_javascript')
    if filereadable('.jsbeautifyrc')
        let g:formatdef_jsbeautify_javascript = '"js-beautify"'
    elseif filereadable(expand('~/.jsbeautifyrc'))
        let g:formatdef_jsbeautify_javascript = '"js-beautify"'
    else
        let g:formatdef_jsbeautify_javascript = '"js-beautify -X -".(&expandtab ? "s ".shiftwidth() : "t").(&textwidth ? " -w ".&textwidth : "")'
    endif
endif

if !exists('g:formatdef_jscs')
    let g:formatdef_jscs = '"jscs -x"'
endif

if !exists('g:formatdef_standard_javascript')
    let g:formatdef_standard_javascript = '"standard --fix --stdin"'
endif


if !exists('g:formatdef_prettier')
    let g:formatdef_prettier = '"prettier --stdin --stdin-filepath ".expand("%:p").(&textwidth ? " --print-width ".&textwidth : "")." --tab-width=".shiftwidth()'
endif


" This is an xo formatter (inspired by the above eslint formatter)
" To support ignore and overrides options, we need to use a tmp file
" So we create a tmp file here and then remove it afterwards
if !exists('g:formatdef_xo_javascript')
    function! g:BuildXOLocalCmd()
        let l:xo_js_tmp_file = fnameescape(tempname().".js")
        let content = getline('1', '$')
        call writefile(content, l:xo_js_tmp_file)
        return "xo --fix ".l:xo_js_tmp_file." 1> /dev/null; exit_code=$?
                     \ cat ".l:xo_js_tmp_file."; rm -f ".l:xo_js_tmp_file."; exit $exit_code"
    endfunction
    let g:formatdef_xo_javascript = "g:BuildXOLocalCmd()"
endif

" Setup ESLint local. Setup is done on formatter execution if ESLint and
" corresponding config is found they are used, otherwiese the formatter fails.
" No windows support at the moment.
if !exists('g:formatdef_eslint_local')
    function! g:BuildESLintLocalCmd()
        let l:path = fnamemodify(expand('%'), ':p')
        let l:ext = ".".expand('%:p:e')
        let verbose = &verbose || g:autoformat_verbosemode == 1
        if has('win32')
            return "(>&2 echo 'ESLint not supported on win32')"
        endif
        " find formatter & config file
        let l:prog = findfile('node_modules/.bin/eslint', l:path.";")
        if empty(l:prog)
            let l:prog = findfile('~/.npm-global/bin/eslint')
            if empty(l:prog)
                let l:prog = findfile('/usr/local/bin/eslint')
            endif
        endif

        "initial
        let l:cfg = findfile('.eslintrc.js', l:path.";")

        if empty(l:cfg)
            let l:cfg_fallbacks = [
                \'.eslintrc.yaml',
                \'.eslintrc.yml',
                \'.eslintrc.json',
                \'.eslintrc',
            \]

            for i in l:cfg_fallbacks
                let l:tcfg = findfile(i, l:path.";")
                if !empty(l:tcfg)
                    break
                endif
            endfor

            if !empty(l:tcfg)
                let l:cfg = fnamemodify(l:tcfg, ":p")
            else
                let l:cfg = findfile('~/.eslintrc.js')
                for i in l:cfg_fallbacks
                    if !empty(l:cfg)
                        break
                    endif
                    let l:cfg = findfile("~/".i)
                endfor
            endif
        endif

        if (empty(l:cfg) || empty(l:prog))
            if verbose
                return "(>&2 echo 'No local or global ESLint program and/or config found')"
            endif
            return
        endif

        " This formatter uses a temporary file as ESLint has not option to print
        " the formatted source to stdout without modifieing the file.
        let l:eslint_tmp_file = fnameescape(tempname().l:ext)
        let content = getline('1', '$')
        call writefile(content, l:eslint_tmp_file)
        return l:prog." -c ".l:cfg." --fix ".l:eslint_tmp_file." 1> /dev/null; exit_code=$?
                     \ cat ".l:eslint_tmp_file."; rm -f ".l:eslint_tmp_file."; exit $exit_code"
    endfunction
    let g:formatdef_eslint_local = "g:BuildESLintLocalCmd()"
endif

if !exists('g:formatters_javascript')
    let g:formatters_javascript = [
                \ 'eslint_local',
                \ 'jsbeautify_javascript',
                \ 'jscs',
                \ 'standard_javascript',
                \ 'prettier',
                \ 'xo_javascript',
                \ ]
endif

" JSON
if !exists('g:formatdef_jsbeautify_json')
    if filereadable('.jsbeautifyrc')
        let g:formatdef_jsbeautify_json = '"js-beautify"'
    elseif filereadable(expand('~/.jsbeautifyrc'))
        let g:formatdef_jsbeautify_json = '"js-beautify"'
    else
        let g:formatdef_jsbeautify_json = '"js-beautify -".(&expandtab ? "s ".shiftwidth() : "t")'
    endif
endif

if !exists('g:formatdef_fixjson')
    let g:formatdef_fixjson =  '"fixjson"'
endif

if !exists('g:formatters_json')
    let g:formatters_json = [
                \ 'jsbeautify_json',
                \ 'fixjson',
                \ 'prettier',
                \ ]
endif


" HTML
if !exists('g:formatdef_htmlbeautify')
    let g:formatdef_htmlbeautify = '"html-beautify - -".(&expandtab ? "s ".shiftwidth() : "t")'
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

" SVG
if !exists('g:formatters_svg')
    let g:formatters_svg = ['tidy_xml']
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

if !exists('g:formatdef_rubocop')
    " The pipe to sed is required to remove some rubocop output that could not
    " be suppressed.
    let g:formatdef_rubocop = "'rubocop --auto-correct -o /dev/null -s '.bufname('%').' \| sed -n 2,\\$p'"
endif

if !exists('g:formatters_ruby')
    let g:formatters_ruby = ['rbeautify', 'rubocop']
endif


" CSS
if !exists('g:formatdef_cssbeautify')
    let g:formatdef_cssbeautify = '"css-beautify -f - -s ".shiftwidth()'
endif

if !exists('g:formatters_css')
    let g:formatters_css = ['cssbeautify', 'prettier']
endif

" SCSS
if !exists('g:formatdef_sassconvert')
    let g:formatdef_sassconvert = '"sass-convert -F scss -T scss --indent " . (&expandtab ? shiftwidth() : "t")'
endif

if !exists('g:formatters_scss')
    let g:formatters_scss = ['sassconvert', 'prettier']
endif

" Less
if !exists('g:formatters_less')
    let g:formatters_less = ['prettier']
endif

" Typescript
if !exists('g:formatdef_tsfmt')
    let g:formatdef_tsfmt = "'tsfmt --stdin '.bufname('%')"
endif

if !exists('g:formatters_typescript')
    let g:formatters_typescript = ['tsfmt', 'prettier']
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

if !exists('g:formatdef_goimports')
    let g:formatdef_goimports = '"goimports"'
endif

if !exists('g:formatters_go')
    let g:formatters_go = ['gofmt_1', 'goimports', 'gofmt_2']
endif

" Rust
if !exists('g:formatdef_rustfmt')
    let g:formatdef_rustfmt = '"rustfmt"'
endif

if !exists('g:formatters_rust')
    let g:formatters_rust = ['rustfmt']
endif

" Dart
if !exists('g:formatdef_dartfmt')
    let g:formatdef_dartfmt = '"dartfmt"'
endif

if !exists('g:formatters_dart')
    let g:formatters_dart = ['dartfmt']
endif

" Perl
if !exists('g:formatdef_perltidy')
    " use perltidyrc file if readable
    if (has("win32") && (filereadable("perltidy.ini") ||
                \ filereadable($HOMEPATH."/perltidy.ini"))) ||
                \ ((has("unix") ||
                \ has("mac")) && (filereadable(".perltidyrc") ||
                \ filereadable(expand("~/.perltidyrc")) ||
                \ filereadable("/usr/local/etc/perltidyrc") ||
                \ filereadable("/etc/perltidyrc")))
        let g:formatdef_perltidy = '"perltidy -q -st"'
    else
        let g:formatdef_perltidy = '"perltidy --perl-best-practices --format-skipping -q "'
    endif
endif

if !exists('g:formatters_perl')
    let g:formatters_perl = ['perltidy']
endif

" Haskell
if !exists('g:formatdef_stylish_haskell')
    let g:formatdef_stylish_haskell = '"stylish-haskell"'
endif

if !exists('g:formatters_haskell')
    let g:formatters_haskell = ['stylish_haskell']
endif

" Markdown
if !exists('g:formatdef_remark_markdown')
    let g:formatdef_remark_markdown = '"remark --silent --no-color"'
endif

if !exists('g:formatters_markdown')
    let g:formatters_markdown = ['remark_markdown', 'prettier']
endif

" Graphql
if !exists('g:formatters_graphql')
    let g:formatters_graphql = ['prettier']
endif

" Fortran
if !exists('g:formatdef_fprettify')
    let g:formatdef_fprettify = '"fprettify --no-report-errors --indent=".shiftwidth()'
endif

if !exists('g:formatters_fortran')
    let g:formatters_fortran = ['fprettify']
endif

" Elixir
if !exists('g:formatdef_mix_format')
    let g:formatdef_mix_format = '"mix format -"'
endif

if !exists('g:formatters_elixir')
    let g:formatters_elixir = ['mix_format']
endif

" Shell
if !exists('g:formatdef_shfmt')
    let g:formatdef_shfmt = '"shfmt -i ".(&expandtab ? shiftwidth() : "0")'
endif

if !exists('g:formatters_sh')
    let g:formatters_sh = ['shfmt']
endif

" SQL
if !exists('g:formatdef_sqlformat')
    let g:formatdef_sqlformat = '"sqlformat --reindent --indent_width ".shiftwidth()." --keywords upper --identifiers lower -"'
endif
if !exists('g:formatters_sql')
    let g:formatters_sql = ['sqlformat']
endif
