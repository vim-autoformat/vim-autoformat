let s:CliOptions = "-d"
let s:bundleDir = fnamemodify(expand("<sfile>"), ":h:h:h")
let &formatprg=s:bundleDir."/js-beautify/python/js-beautify -i ".s:CliOptions

set expandtab
set tabstop=4
set shiftwidth=4
