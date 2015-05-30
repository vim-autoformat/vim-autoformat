vim-autoformat
==============
Format your code with only one button press!
This plugin makes use of external formatprograms to achieve the best result.
Check the list of formatprograms to see which languages are supported by default.
You can easily customize or add your own formatprogram.
When no formatprogram exists (or no formatprogram is installed) for a certain filetype, vim-autoformat uses vim's indent functionality as a fallback.

How to install
-----------------------
###Vundle
Put this in your .vimrc

```vim
Plugin 'Chiel92/vim-autoformat'
```

Then restart vim and run `:PluginInstall`.
To update the plugin to the latest version, you can run `:PluginUpdate`.

###Pathogen
Download the source and extract in your bundle directory.
Updating has to be done manually, as far as I'm aware.

###Other
It is highly recommended to use a plugin manager such as Vundle, since this makes it easy to update plugins or uninstall them.
It also keeps your .vim directory clean.
Still you can decide to download this repository as a zip file or whatever and extract it to your .vim folder.

How to use
----------
First you should install an external program that can format code of the programming language you are using.
This can either be one of the programs that are listed below as defaultprograms, or a custom program.
For using a custom formatprogram, read the text below *How can I change the behaviour of formatters, or add one myself?*
If the formatprogram you want to use is installed correctly, in one of the following ways, vim automatically detects it.
* It suffices to make the formatprogram globally available, which is the case if you install it via your package manager.
* Alternatively you can point vim to the the binary by explicitly putting the absolute path in `g:formatdef_<some_indentifier>` in your .vimrc. TODO

Remember that when no formatprogram exists for a certain filetype, vim-autoformat uses vim's indent functionality as a fallback.
This will fix at least the indentation of your code, according to vim's indentfile for that filetype.

When you have installed the formatter you need, you can format the entire buffer with the command `:Autoformat`.
You can provide the command with a file type such as `:Autoformat json`, otherwise the buffer's filetype will be used.

For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F3> :Autoformat<CR><CR>
```

If you have multiple formatters installed that are supported, vim-autoformat just uses the
first that occurs in the list of available formatters.
You can either set this list manually in your vimrc (see section *How can I change the behaviour of formatters, or add one myself?*, or change the formatter with the highest priority by the commands `:NextFormatter` and `:PreviousFormatter`.

<!--If you don't want to format the entire buffer, you can alternatively format visually selected code with `gq`.-->
<!--However, some formatprograms will behave a bit weird this way, because they need the context of a piece of code.-->
<!--For more ways to perform autoformatting type `:help gq`.-->
<!--If you format a piece of code manually by using `gq`, vim will not fallback to auto indentation if there is no formatprogram available.-->
<!--This way, the default behaviour of `gq` will remain functional.-->

Default formatprograms
------------------------
Here is a list of formatprograms that are supported by default, and thus will be detected and used by vim when they are installed properly.

* `clang-format` for __C__, __C++__, __Objective-C__.
clang-format is a product of LLVM source builds.
If you `brew install llvm`, clang-format can be found in /usr/local/Cellar/llvm/bin/.
To to load style configuration from a .clang-format file, add to your .vimrc: `let g:formatdef_clangformat_objc = '"clang-format -style=file"'`.
Details: http://clang.llvm.org/docs/ClangFormat.html.

* `astyle` for __C#__, __C++__, __C__ and __Java__.
*Important*: version `2.0.4` or higher is required, since only those versions correctly support piping.
Download it here: http://astyle.sourceforge.net/.


* `autopep8` for __Python__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install python-autopep8` in a terminal.
Here is the link to the repository: https://github.com/hhatto/autopep8.
And here the link to its page on the python website: http://pypi.python.org/pypi/autopep8/0.5.2.

* `js-beautify` for __Javascript__ and __JSON__.
It can be installed by running `npm install -g js-beautify`.
Note that `nodejs` is needed for this to work.
The *python version is not supported by default* because it needs different arguments.
If you want (or need) to use the python version, you manually have to specify a formatter definition that is valid for the python version in your `.vimrc`. Example:
```vim
let g:formatdef_jsbeautify_javascript = '"-".(&expandtab ? "s ".&shiftwidth : "t").(&textwidth ? " -w ".&textwidth : "")." -"'
```
Here is the link to the repository: https://github.com/einars/js-beautify.

* `typescript-formatter` for __Typescript__.
`typescript-formatter` is a thin wrapper around the TypeScript compiler services.
It can be installed by running `npm install -g typescript-formatter`.
Note that `nodejs` is needed for this to work. 
Here is the link to the repository: https://github.com/vvakame/typescript-formatter.

* `html-beautify` for __HTML__.
It is shipped with `js-beautify`, which can be installed by running `npm install -g js-beautify`.
Note that `nodejs` is needed for this to work.
Here is the link to the repository: https://github.com/einars/js-beautify.

* `css-beautify` for __CSS__.
It is shipped with `js-beautify`, which can be installed by running `npm install -g js-beautify`.
Note that `nodejs` is needed for this to work.
Here is the link to the repository: https://github.com/einars/js-beautify.

* `sass-convert` for __SCSS__.
It is shipped with `sass`, a CSS preprocessor written in Ruby, which can be installed by running `gem install sass`.
Here is the link to the SASS homepage: http://sass-lang.com/.

* `tidy` for __XHTML__ and __XML__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install tidy` in a terminal.

* `rbeautify` for __Ruby__.
It is shipped with `ruby-beautify`, which can be installed by running `gem install ruby-beautify`.
Note that compatible `ruby-beautify-0.94.0` or higher version.
Here is the link to the repository: https://github.com/erniebrodeur/ruby-beautify.
This beautifier developed and tested with ruby `2.0+`, so you can have weird results with earlier ruby versions.

How can I change the behaviour of formatters, or add one myself?
----------------------------------------------------------------
If you need a formatter that is not among the defaults, or if you are not satisfied with the default formatting behaviour that is provided by vim-autoformat, you can define it yourself.
*The formatprogram must read the unformatted code from the standard input, and write the formatted code to the standard output.*
The formatprograms that available for a certain `<filetype>` are defined in `g:formatters_<filetype>`.
This is a list containing string indentifiers.

The formatter definitions themselves are defined in `g:formatdef_<identifier>`.
Defining any of these variable manually in your .vimrc, will override the default value, if existing.
So, a complete definition in your .vimrc for C# files could look like this:

```vim
let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=ansi -pcHs4"'
let g:formatters_cs = ['my_custom_cs']
```
*Please note the double quotes in `g:formatdef_my_custom_cs`*.
This allows you to define the arguments dynamically:

```vim
let g:formatdef_my_custom_cs = '"--mode=cs --style=ansi -pcHs".&shiftwidth'
let g:formatters_cs = ['my_custom_cs']
```

Notice that `g:formatdef_my_custom_cs` contains an expression that can be evaluated, as required.
As you see, this allows us to dynamically define some parameters.
In this example, the indent width that astyle will use, depends on the buffer local value of `&shiftwidth`, instead of being fixed at 4.
So if you're editing a csharp file and change the `shiftwidth` (even at runtime), the `g:formatdef_my_custom_cs` will change correspondingly.

For the default formatprogram definitions, the options `expandtab`, `shiftwidth` and `textwidth` are taken into account whenever possible.
This means that the formatting style will match your current vim settings as much as possible.
For the exact default definitions, have a look in `vim-autoformat/plugin/defaults.vim`.

If you have a composite filetype with dots (like `django.python` or `php.wordpress`), vim-autoformat internally replaces the dots with underscores so you can specify formatters through `g:formatters_django_python` and so on.

### Ranged Definitions
If your format program supports formatting ranges, you can additionally provide a format
definition which allows to make use of this.
The first and last line of the range can be retrieved by the variables `a:firstline` and
`a:lastline`. They default to the first and last line of your file, if no range was explicitly
specified.
So, a ranged definition could look like this.
```vim
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']
```


Debugging
---------
If you're struggling with getting a formatter to work, it may help to set vim-autoformat in
verbose-mode. Vim-autoformat will then output errors on formatters that failed.
```vim
let g:autoformat_verbosemode = 1
```
To read all messages in a vim session type `:messages`.

Things that are not (yet) implemented
--------------------------------------
* Make `:Autoformat` command accept ranges and provide range information to formatter if they support that, as requested and described in #47.
* Automatically check for formatters of supertypes, as requested and described in #50.
* Option for on-the-fly code-formatting, like visual studio (If ever. When you have a clever idea about how to do this, I'd be glad to hear.)

Pull requests are welcome.
Any feedback is welcome.
If you have any suggestions on this plugin or on this readme, if you have some nice default formatter definition that can be added to the defaults, or if you experience problems, please contact me by creating an issue in this repository.

Change log
----------
### May 21 2015
* *Backwards incompatible patch!*
* Multiple formatters per filetype are now supported
* Configuration variable names changed
* `gq` no longer supported

### Dec 9 2014
* Added `rbeautify` to the defaults for formatting ruby files

### May 30 2014
* Added `css-beautify` to the defaults for formatting CSS files

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
The `dynamic_indent_width` branch has been merged into the master branch.
* The options `expandtab`, `shiftwidth`, `tabstop` and `softtabstop` are not overwritten anymore.
* This obsoletes `g:autoformat_no_default_shiftwidth`
* `g:formatprg_args_expr_<filetype>` is introduced.

### March 13 2013
* It is now possible to prevent vim-autoformat from overwriting your settings for  `tabstop`, `softtabstop`, `shiftwidth` and `expandtab` in your .vimrc.

### March 10 2013
* When no formatter is installed or defined, vim will now auto-indent the file instead. This uses the indentfile for that specific filetype.

### March 9 2013
The `custom_config` branch has been merged into the master branch.
* Customization of formatprograms can be done easily now, as explained above.
* I set the default tabwidth to 4 for all formatprograms as well as for vim itself.
* The default parameters for astyle have been slightly modified: it will wrap spaces around operators.
* phpCB has been removed from the defaults, due to code-breaking behaviour.
* XHTML default definition added
