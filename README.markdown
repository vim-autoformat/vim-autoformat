vim-autoformat
==============
Format your code with only one button press!
This plugin makes use of external formatprograms to achieve the best result.
Check the list of formatprograms to see which languages are supported by default.
You can easily customize or add your own formatprogram.

How to install (Vundle)
-----------------------
Put this in your .vimrc

```vim
Bundle "Chiel92/vim-autoformat"
```

How to use
----------
First you have to install an external program that can format code of the programming language you are using.
It suffices to make the formatprogram globally available, which is the case if you install it via your package manager.
Alternatively, you can put its binary (or a link to it) in the `formatters/` folder.

When you have installed the formatters you need, you can format the entire buffer with the command `:Autoformat`.
For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F7> :Autoformat<CR><CR>
```

If there is no formatprogram available for the current filetype, vim will auto-indent the buffer, instead of auto-formatting it.
This will fix at least the indentation of your code, according to vim's indentfile for that filetype.

If you don't want to format the entire buffer, you can alternatively format visually selected code with `gq`.
However, some formatprograms will behave a bit weird this way, because they need the context of a piece of code.
For more ways to perform autoformatting type `:help gq`.

Default formatprograms
------------------------
Here is a list of formatprograms that are supported by default.

* `astyle` for __C#__, __C++__, __C__ and __Java__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install astyle` in a terminal.
Otherwise, download it here: http://astyle.sourceforge.net/.

* `jsbeautify` (the python CLI version) for __Javascript__.
This one can also be installed as a vundle package, and I recommend to do so.
Put this in your .vimrc: `Bundle "einars/jsbeautify"`.
Note that we're only using the python version, so `node` doesn't have to be installed.
Here is the link to the repository: https://github.com/einars/js-beautify.

* `autopep8` for __Python__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install autopep8` in a terminal.
Here is the link to the repository: https://github.com/hhatto/autopep8.
And here the link to its page on the python website: http://pypi.python.org/pypi/autopep8/0.5.2.

* `tidy` for __HTML__, __XHTML__ and __XML__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install tidy` in a terminal.

How can I change the behaviour of formatters?
---------------------------------------------
If you are not satisfied with the default configuration for a certain filetype, you can override it by defining it yourself.
The formatprogram used for a `<filetype>` is defined in `g:formatprg_<filetype>`.
The arguments passed to the formatprogram are defined in `g:formatprg_args_<filetype>`.
The formatprogram must read the unformatted code from the standard input, and write the formatted code to the standard output.
By defining one or both of these variable in your .vimrc, you override any possible default value.
So, a complete definition for C# files could look like this:

```vim
let g:formatprg_cs = "astyle"
let g:formatprg_args_cs = "--mode=cs --style=ansi -p -c -H"
```

The default tabwidth is set to 4 for all formatprograms as well as for vim itself.
If you change the tabwidth for a certain formatprogram, I would suggest to change the indent options of vim correspondingly for that filetype.

```vim
au filetype *.cs set tabstop=2
au filetype *.cs set softtabstop=2
au filetype *.cs set shiftwidth=2
```


Todo list
---------
* Check for windows support.
* Option for on-the-fly code-formatting (like visual studio)


If you have any suggestions on this plugin or on this readme, if you think some default formatprg definition is missing, or if you experience problems, please contact me by creating an issue in this repository.

Change log
----------
### March 9 2013
The custom_config branch has been merged into the master branch.
* Customization of formatprograms can be done easily now, as explained above.
* I set the default tabwidth to 4 for all formatprograms as well as for vim itself.
* The default parameters for astyle have been slightly modified: it will wrap spaces around operators.
* phpCB has been removed from the defaults, due to code-breaking behaviour.
* XHTML default definition added
### March 10 2013
* When no formatter is installed or defined, vim will now auto-indent the file instead. This uses the indentfile for that specific filetype.
