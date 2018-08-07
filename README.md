# vim-autoformat

Format code with one button press.

This plugin makes use of external formatting programs to achieve the best results.
Check the list of formatprograms below to see which languages are supported by default.
You can easily customize these or add your own formatprogram.
When no formatprogram exists (or no formatprogram is installed) for a certain filetype,
vim-autoformat falls back by default to indenting, (using vim's auto indent functionality), retabbing and removing trailing whitespace.

## How to install

This plugin is supported by Vim 7.4+.
It is required that your vim has builtin python support. You can check whether this is the case
by running `vim --version` and check that `+python` or `+python3` is listed among features.

#### Vundle

Put this in your `.vimrc`.

```vim
Plugin 'Chiel92/vim-autoformat'
```

Then restart vim and run `:PluginInstall`. Alternatively, you could run `:source $MYVIMRC`
to reload your `.vimrc` without restarting vim.
To update the plugin to the latest version, you can run `:PluginUpdate`.

#### Pathogen

Download the source and extract in your bundle directory.
Updating has to be done manually, as far as I'm aware.

#### Other

It is highly recommended to use a plugin manager such as Vundle, since this makes it easy to update plugins or uninstall them.
It also keeps your .vim directory clean.
Still you can decide to download this repository as a zip file or whatever and extract it to your .vim folder.

## How to use

First you should install an external program that can format code of the programming language you are using.
This can either be one of the programs that are listed below as defaultprograms, or a custom program.
For defaultprograms, vim-autoformat knows for which filetypes it can be used.
For using a custom formatprogram, read the text below *How can I change the behaviour of formatters, or add one myself?*
If the formatprogram you want to use is installed in one of the following ways, vim automatically detects it:

* It suffices to make the formatprogram globally available, which is the case if you install it via your package manager.
* Alternatively you can point vim-autoformat to folders containing formatters, by putting the absolute paths to these folders in `g:formatterpath` in your .vimrc, like:

```vim
let g:formatterpath = ['/some/path/to/a/folder', '/home/superman/formatters']
```

Remember that when no formatprograms exists for a certain filetype,
vim-autoformat falls back by default to indenting, retabbing and removing trailing whitespace.
This will fix at least the most basic things, according to vim's indentfile for that filetype.

When you have installed the formatter you need, you can format the entire buffer with the command `:Autoformat`.
You can provide the command with a file type such as `:Autoformat json`, otherwise the buffer's filetype will be used.

Some formatters allow you to format only a part of the file, for instance `clang-format` and
`autopep8`.
To use this, provide a range to the `:Autoformat` command, for instance by visually selecting a
part of your file, and then executing `:Autoformat`.
For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F3> :Autoformat<CR>
```

Or to have your code be formatted upon saving your file, you could use something like this:

```vim
au BufWrite * :Autoformat
```

To disable the fallback to vim's indent file, retabbing and removing trailing whitespace, set the following variables to 0.

```vim
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
```

To disable or re-enable these option for specific buffers, use the buffer local variants:
`b:autoformat_autoindent`, `b:autoformat_retab` and `b:autoformat_remove_trailing_spaces`.
So to disable autoindent for filetypes that have incompetent indent files, use

```vim
autocmd FileType vim,tex let b:autoformat_autoindent=0
```

You can manually autoindent, retab or remove trailing whitespace with the following respective
commands.

```vim
gg=G
:retab
:RemoveTrailingSpaces
```

For each filetype, vim-autoformat has a list of applicable formatters.
If you have multiple formatters installed that are supported for some filetype, vim-autoformat
tries all formatters in this list of applicable formatters, until one succeeds.
You can set this list manually in your vimrc (see section *How can I change the behaviour of formatters, or add one myself?*,
or change the formatter with the highest priority by the commands `:NextFormatter` and `:PreviousFormatter`.
To print the currently selected formatter use `:CurrentFormatter`.
These latter commands are mostly useful for debugging purposes.
If you have a composite filetype with dots (like `django.python` or `php.wordpress`),
vim-autoformat first tries to detect and use formatters for the exact original filetype, and
then tries the same for all supertypes occurring from left to right in the original filetype
separated by dots (`.`).

## Default formatprograms

Here is a list of formatprograms that are supported by default, and thus will be detected and used by vim when they are installed properly.

* `clang-format` for __C__, __C++__, __Objective-C__ (supports formatting ranges).
  Clang-format is a product of LLVM source builds.
  If you `brew install llvm`, clang-format can be found in /usr/local/Cellar/llvm/bin/.
  Vim-autoformat checks whether there exists a `.clang-format` or a `_clang-format` file up in
  the current directory's ancestry. Based on that it either uses that file or tries to match
  vim options as much as possible.
  Details: http://clang.llvm.org/docs/ClangFormat.html.

* `astyle` for __C#__, __C++__, __C__ and __Java__.
  Download it here: http://astyle.sourceforge.net/.
  *Important: version `2.0.5` or higher is required, since only those versions correctly support piping and are stable enough.*

* `autopep8` for __Python__ (supports formatting ranges).
  It's probably in your distro's repository, so you can download it as a regular package.
  For Ubuntu type `sudo apt-get install python-autopep8` in a terminal.
  Here is the link to the repository: https://github.com/hhatto/autopep8.
  And here the link to its page on the python website: http://pypi.python.org/pypi/autopep8/0.5.2.

* `yapf` for __Python__ (supports formatting ranges).
  Vim-autoformat checks whether there exists a `.style.yapf` or a `setup.cfg` file up in the current directory's ancestry.
  Based on that it either uses that file or tries to match vim options as much as possible.
  It is readily available through PIP.
  Most users can install with the terminal command `sudo pip install yapf` or `pip  install --user yapf`.
  YAPF has one optional configuration variable to control the formatter style.
  For example:

  ```vim
  let g:formatter_yapf_style = 'pep8'
   ```

  `pep8` is the default value, or you can choose: `google`, `facebook`, `chromium`.

  Here is the link to the repository: https://github.com/google/yapf

* `js-beautify` for __Javascript__ and __JSON__.
  It can be installed by running `npm install -g js-beautify`.
  Note that `nodejs` is needed for this to work.
  The python version version is also supported by default, which does not need `nodejs` to run.
  Here is the link to the repository: https://github.com/einars/js-beautify.

* `JSCS` for __Javascript__. http://jscs.info/

* `standard` for __Javascript__.
  It can be installed by running `npm install -g standard` (`nodejs` is required). No more configuration needed.
  More information about the style guide can be found here: http://standardjs.com/.

* `ESlint` for __Javascript__. http://eslint.org/
  It can be installed by running `npm install eslint` for a local project or by running `npm install -g eslint` for global use. The linter is then installed locally at `$YOUR_PROJECT/node_modules/.bin/eslint` or globally at `~/.npm-global/bin/eslint`.
  When running the formatter, vim will walk up from the current file to search for such local installation and a ESLint configuration file (either `.eslintrc.js` or `eslintrc.json`). When the local version is missing it will fallback to the global version in your home directory. When both requirements are found eslint is executed with the `--fix` argument.
  Note that the formatter's name is still `eslint_local` for legacy reasons even though it already supports global `eslint`.
  Currently only working on \*nix like OS (Linux, MacOS etc.) as it requires the OS to provide sh like shell syntax.

* `xo` for __Javascript__.
  It can be installed by running `npm install -g xo` (`nodejs` is required).
  Here is the link to the repository: https://github.com/sindresorhus/xo.

* `html-beautify` for __HTML__.
  It is shipped with `js-beautify`, which can be installed by running `npm install -g js-beautify`.
  Note that `nodejs` is needed for this to work.
  Here is the link to the repository: https://github.com/einars/js-beautify.

* `css-beautify` for __CSS__.
  It is shipped with `js-beautify`, which can be installed by running `npm install -g js-beautify`.
  Note that `nodejs` is needed for this to work.
  Here is the link to the repository: https://github.com/einars/js-beautify.

* `typescript-formatter` for __Typescript__.
  `typescript-formatter` is a thin wrapper around the TypeScript compiler services.
  It can be installed by running `npm install -g typescript-formatter`.
  Note that `nodejs` is needed for this to work.
  Here is the link to the repository: https://github.com/vvakame/typescript-formatter.

* `sass-convert` for __SCSS__.
  It is shipped with `sass`, a CSS preprocessor written in Ruby, which can be installed by running `gem install sass`.
  Here is the link to the SASS homepage: http://sass-lang.com/.

* `tidy` for __HTML__, __XHTML__ and __XML__.
  It's probably in your distro's repository, so you can download it as a regular package.
  For Ubuntu type `sudo apt-get install tidy` in a terminal.

* `rbeautify` for __Ruby__.
  It is shipped with `ruby-beautify`, which can be installed by running `gem install ruby-beautify`.
  Note that compatible `ruby-beautify-0.94.0` or higher version.
  Here is the link to the repository: https://github.com/erniebrodeur/ruby-beautify.
  This beautifier developed and tested with ruby `2.0+`, so you can have weird results with earlier ruby versions.

* `rubocop` for __Ruby__.
  It can be installed by running `gem install rubocop`.
  Here is the link to the repository: https://github.com/bbatsov/rubocop

* `gofmt` for __Golang__.
  The default golang formatting program is shipped with the golang distribution. Make sure `gofmt` is in your PATH (if golang is installed properly, it should be).
  Here is the link to the installation: https://golang.org/doc/install

* `rustfmt` for __Rust__.
  It can be installed using `cargo`, the Rust package manager. Up-to-date installation instructions are on the project page: https://github.com/nrc/rustfmt/#installation.

* `dartfmt` for __Dart__.
  Part of the Dart SDK (make sure it is on your PATH). See https://www.dartlang.org/tools/dartfmt/ for more info.

* `perltidy` for __Perl__.
  It can be installed from CPAN `cpanm Perl::Tidy` . See https://metacpan.org/pod/Perl::Tidy and http://perltidy.sourceforge.net/ for more info.

* `stylish-haskell` for __Haskell__
  It can be installed using [`cabal`](https://www.haskell.org/cabal/) build tool. Installation instructions are available at https://github.com/jaspervdj/stylish-haskell#installation

* `remark` for __Markdown__.
  A Javascript based markdown processor that can be installed with `npm install -g remark-cli`. More info is available at https://github.com/wooorm/remark.

* `fprettify` for modern __Fortran__.
  Download from [official repository](https://github.com/pseewald/fprettify). Install with `./setup.py install` or `./setup.py install --user`.

* `mix format` for __Elixir__.
  `mix format` is included with Elixir 1.6+.

* `fixjson` for JSON.
  It is a JSON file fixer/formatter for humans using (relaxed) JSON5. It fixes various failures while humans writing JSON and formats JSON codes.
  It can be installed with `npm install -g fixjson`. More info is available at https://github.com/rhysd/fixjson.

* `shfmt` for __Shell__.
  A shell formatter written in Go supporting POSIX Shell, Bash and mksh that can be installed with `go get -u mvdan.cc/sh/cmd/shfmt`. See https://github.com/mvdan/sh for more info.

* `sqlformat` for __SQL__.
  Install `sqlparse` with `pip`.


## Help, the formatter doesn't work as expected!

If you're struggling with getting a formatter to work, it may help to set vim-autoformat in
verbose-mode. Vim-autoformat will then output errors on formatters that failed.

```vim
let g:autoformat_verbosemode=1
" OR:
let verbose=1
```

To read all messages in a vim session type `:messages`.  Since one cannot always easily copy
the contents of messages (e.g. for posting it in an issue), vim-autoformats command `:PutMessages` may
help. It puts the messages in the current buffer, allowing you to do whatever you want.

#### Reporting bugs

Please report bugs by creating an issue in this repository.
When there are problems with getting a certain formatter to work, provide the output of verbose
mode in the issue.

## How can I change the behaviour of formatters, or add one myself?

If you need a formatter that is not among the defaults, or if you are not satisfied with the default formatting behaviour that is provided by vim-autoformat, you can define it yourself.
*The formatprogram must read the unformatted code from the standard input, and write the formatted code to the standard output.*

#### Basic definitions

The formatprograms that available for a certain `<filetype>` are defined in `g:formatters_<filetype>`.
This is a list containing string identifiers, which point to corresponding formatter definitions.
The formatter definitions themselves are defined in `g:formatdef_<identifier>` as a string
expression.
Defining any of these variable manually in your .vimrc, will override the default value, if existing.
For example, a complete definition in your .vimrc for C# files could look like this:

```vim
let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=ansi -pcHs4"'
let g:formatters_cs = ['my_custom_cs']
```

In this example, `my_custom_cs` is the identifier for our formatter definition.
The first line defines how to call the external formatter, while the second line tells
vim-autoformat that this is the only formatter that we want to use for C# files.
*Please note the double quotes in `g:formatdef_my_custom_cs`*.
This allows you to define the arguments dynamically:

```vim
let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=ansi -pcHs".&shiftwidth'
let g:formatters_cs = ['my_custom_cs']
```

Please notice that `g:formatdef_my_custom_cs` contains an expression that can be evaluated, as required.
As you see, this allows us to dynamically define some parameters.
In this example, the indent width that astyle will use, depends on the buffer local value of `&shiftwidth`, instead of being fixed at 4.
So if you're editing a csharp file and change the `shiftwidth` (even at runtime), the `g:formatdef_my_custom_cs` will change correspondingly.

For the default formatprogram definitions, the options `expandtab`, `shiftwidth` and `textwidth` are taken into account whenever possible.
This means that the formatting style will match your current vim settings as much as possible.
You can have look look at the exact default definitions for more examples.
They are defined in `vim-autoformat/plugin/defaults.vim`.
As a small side note, in the actual defaults the function `shiftwidth()` is used instead of the
property. This is because it falls back to the value of `tabstop` if `shiftwidth` is 0.

If you have a composite filetype with dots (like `django.python` or `php.wordpress`),
vim-autoformat internally replaces the dots with underscores so you can specify formatters
through `g:formatters_django_python` and so on.

To override these options for a local buffer, use the buffer local variants:
`b:formatters_<filetype>` and `b:formatdef_<identifier>`. This can be useful, for example, when
working with different projects with conflicting formatting rules, with each project having settings
in its own vimrc or exrc file:

```vim
let b:formatdef_custom_c='"astyle --mode=c --suffix=none --options=/home/user/special_project/astylerc"'
let b:formatters_c = ['custom_c']
```

#### Ranged definitions

If your format program supports formatting specific ranges, you can provide a format
definition which allows to make use of this.
The first and last line of the current range can be retrieved by the variables `a:firstline` and
`a:lastline`. They default to the first and last line of your file, if no range was explicitly
specified.
So, a ranged definition could look like this.

```vim
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']
```

This would allow the user to select a part of the file and execute `:Autoformat`, which
would then only format the selected part.


## Contributing

Pull requests are welcome.
Any feedback is welcome.
If you have any suggestions on this plugin or on this readme, if you have some nice default
formatter definition that can be added to the defaults, or if you experience problems, please
contact me by creating an issue in this repository.

## Major Change Log

### March 2016
* We don't use the option formatprg internally anymore, to always have the possible of using the default `gq`
  command.
* More fallback options have been added.

### June 2015

* *Backward incompatible patch!*
* Multiple formatters per filetype are now supported.
* Configuration variable names changed.
* Using `gq` as alias for `:Autoformat` is no longer supported.
* `:Autoformat` now suppports ranges.
* Composite filetypes are fully supported.

### December 20 2013

* `html-beautify` is now the default for HTML since it seems to be better maintained, and seems to handle inline javascript neatly.
* The `formatters/` folder is no longer supported anymore, because it is unnecessary.
* `js-beautify` can no longer be installed as a bundle, since it only makes this plugin unnecessarily complex.

### March 27 2013

* The default behaviour of gq is enabled again by removing the fallback on auto-indenting.
  Instead, the fallback is only used when running the command `:Autoformat`.
* For HTML,XML and XHTML, the option `textwidth` is taken into account when formatting.
  This extends the way the formatting style will match your current vim settings.

### March 16 2013

* The options `expandtab`, `shiftwidth`, `tabstop` and `softtabstop` are not overwritten anymore.
* This obsoletes `g:autoformat_no_default_shiftwidth`
* `g:formatprg_args_expr_<filetype>` is introduced.

### March 13 2013

* It is now possible to prevent vim-autoformat from overwriting your settings for  `tabstop`, `softtabstop`, `shiftwidth` and `expandtab` in your .vimrc.

### March 10 2013

* When no formatter is installed or defined, vim will now auto-indent the file instead. This uses the indentfile for that specific filetype.

### March 9 2013

* Customization of formatprograms can be done easily now, as explained in the readme.
* I set the default tabwidth to 4 for all formatprograms as well as for vim itself.
* The default parameters for astyle have been slightly modified: it will wrap spaces around operators.
* phpCB has been removed from the defaults, due to code-breaking behaviour.
* XHTML default definition added
