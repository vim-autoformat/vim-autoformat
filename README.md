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

Then restart vim and run `:BundleInstall`.
To update the plugin to the latest version, you can run `:BundleUpdate`.

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
* Alternatively you can point vim to the the binary by explicitly putting the absolute path in `g:formatprg_<filetype>` in your .vimrc.

Remember that when no formatprogram exists for a certain filetype, vim-autoformat uses vim's indent functionality as a fallback.
This will fix at least the indentation of your code, according to vim's indentfile for that filetype.

When you have installed the formatters you need, you can format the entire buffer with the command `:Autoformat`.
You can provide the command with a file type such as `:Autoformat json`, otherwise the buffer's filetype will be used.

For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F3> :Autoformat<CR><CR>
```

If you don't want to format the entire buffer, you can alternatively format visually selected code with `gq`.
However, some formatprograms will behave a bit weird this way, because they need the context of a piece of code.
For more ways to perform autoformatting type `:help gq`.
If you format a piece of code manually by using `gq`, vim will not fallback to auto indentation if there is no formatprogram available.
This way, the default behaviour of `gq` will remain functional.

Default formatprograms
------------------------
Here is a list of formatprograms that are supported by default, and thus will be detected and used by vim when they are installed properly.

* `astyle` for __C#__, __C++__, __C__ and __Java__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install astyle` in a terminal.
Otherwise, download it here: http://astyle.sourceforge.net/.

* `autopep8` for __Python__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install python-autopep8` in a terminal.
Here is the link to the repository: https://github.com/hhatto/autopep8.
And here the link to its page on the python website: http://pypi.python.org/pypi/autopep8/0.5.2.

* `js-beautify` for __Javascript__ and __JSON__.
It can be installed by running `npm install -g js-beautify`.
Note that `nodejs` is needed for this to work.
Here is the link to the repository: https://github.com/einars/js-beautify.

* `html-beautify` for __HTML__.
It is shipped with `js-beautify`, which can be installed by running `npm install -g js-beautify`.
Note that `nodejs` is needed for this to work.
Here is the link to the repository: https://github.com/einars/js-beautify.

* `css-beautify` for __CSS__.
It is shipped with `js-beautify`, which can be installed by running `npm install -g js-beautify`.
Note that `nodejs` is needed for this to work.
Here is the link to the repository: https://github.com/einars/js-beautify.

* `tidy` for __XHTML__ and __XML__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install tidy` in a terminal.

How can I change the behaviour of formatters, or add one myself?
---------------------------------------------
If you need a formatter that is not among the defaults, or if you are not satisfied with the default formatting behaviour that is provided by vim-autoformat, you can define it yourself.
*The formatprogram must read the unformatted code from the standard input, and write the formatted code to the standard output.*
The formatprogram that is used for a certain `<filetype>` is defined in `g:formatprg_<filetype>`.
The arguments that are passed to the formatprogram are either defined in `g:formatprg_args_expr_<filetype>` as an expression which can be evaluated, or else in `g:formatprg_args_<filetype>` as a plain string.
Defining any of these variable manually in your .vimrc, will override the default value, if existing.
So, a complete definition in your .vimrc for C# files could look like this:

```vim
let g:formatprg_cs = "astyle"
let g:formatprg_args_cs = "--mode=cs --style=ansi -pcHs4"
```

If you want to define the arguments dynamically, you can use the more powerful `g:formatprg_args_expr_<filetype>` instead.
Then, a similar definition would look like this:

```vim
let g:formatprg_cs = "astyle"
let g:formatprg_args_expr_cs = '"--mode=cs --style=ansi -pcHs".&shiftwidth'
```

Notice that `g:formatprg_args_expr_cs` now contains an expression that can be evaluated, as required.
As you see, this allows us to dynamically define some parameters.
In this example, the indent width that astyle will use, depends on the buffer local value of `&shiftwidth`, instead of being fixed at 4.
So if you're editing a csharp file and change the `shiftwidth` (even runtime), the `formatprg_args_expr_<filetype>` will change correspondingly.

For the default formatprogram definitions, the options `expandtab`, `shiftwidth` and `textwidth` are taken into account whenever possible.
This means that the formatting style will match your current vim settings as much as possible.
For the exact default definitions, have a look in `vim-autoformat/plugin/defaults.vim`.


Things that are not (yet) implemented
----------------------------------------------------------
* Check for windows support.
* Option for on-the-fly code-formatting, like visual studio (If ever. When you have a clever idea about how to do this, I'd be glad to hear.)

Pull requests are welcome.
Any feedback is welcome.
If you have any suggestions on this plugin or on this readme, if you have some nice default formatprg definition that can be added to the defaults, or if you experience problems, please contact me by creating an issue in this repository.

Change log
----------
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
