vim-autoformat
==============
Format your code with only one button press!
This plugin makes use of external formatprograms to achieve the best result.
You can specify how to use which formatprograms for which filetypes.
A set of reasonable defaults are given, so you should be able to use it right away.
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
It suffices to make the formatprogram either globally available, which is the case if you install it via your package manager.
Alternatively, you can put the binary (or a link to it) in the `formatters/` folder.

When you have installed the formatters you need, you can format the entire buffer with the command `:Autoformat`.
For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F7> :Autoformat<CR><CR>
```

If you don't want to format the entire buffer, you can alternatively format visually selected code with `gq`.
However, some formatprograms will behave a bit weird then, because they need the context of a piece of code.
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

* `phpCB` for __PHP__.
You can download it's binary here:
http://www.waterproof.fr/products/phpCodeBeautifier/download.php.
I recommend putting the phpCB binary in the `formatters/` directory.

* `tidy` for __HTML__ and __XML__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install tidy` in a terminal.

How can I change the behaviour of formatters?
---------------------------------------------
The formatprg for a filetype is defined in `g:formatprg_<filetype>`.
The arguments given to the formatprogram are defined in `g:formatprg_args_<filetype>`.
So for example, if you want to set the arguments passed to `astyle` for formatting a C# file, you would put a line like this in your .vimrc:

```vim
let g:formatprg_args_cs = "--mode=cs --style=java -H"
```

How can I define a formatprogram myself?
---------------------------------
You can define one in your .vimrc.
A definition looks like this:

```vim
let g:formatprg_cs = "astyle"
let g:formatprg_args_cs = "--mode=cs --style=ansi -p -c -H"
```

If you change the tabwidth for a formatprogram, I would suggest to change the indent options of vim correspondingly for that filetype:

```vim
au filetype *.cs set tabstop=4
au filetype *.cs set softtabstop=4
au filetype *.cs set shiftwidth=4
```


Todo list
---------
* Check for windows support.
* Option for on-the-fly code-formatting (like visual studio)


If you have any suggestions on this plugin or on this readme or if you experience problems, please contact me by creating an issue in this repository.
