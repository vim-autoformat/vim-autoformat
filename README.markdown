vim-autoformat
==============
This vim plugin integrates external code-formatting programs into vim automatically.
If you have installed a supported formatprogram, you can use it within vim out of the box.

How to install (Vundle)
-----------------------
Put this in your .vimrc

```vim
Bundle "Chiel92/vim-autoformat"
```

How to use
----------
First you have to install an external program that can format code of the programming language you are using.
It suffices to make the formatprogram either globally available
(which is the case if you installed it via your package manager)
or to put it in the `formatters/` folder.
Sometimes alternative installation methods are supported.

When you have installed the formatters you need, you can format the buffer with the command `:Autoformat`.
For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F7> :Autoformat<CR><CR>
```

If you don't want to format the whole vimbuffer, you can alternatively format visually selected code with `gq`.
For more ways to perform autoformatting type `:help gq`.

Supported formatprograms
------------------------
With most of the distro's, if you installed a formatprogram, it's automatically globally available.
If this is not the case, you can either make it globally available manually, or put it's binary in the `formatters/` directory.
Sometimes alternative installation methods are presented.
Here is a list of formatprograms that are currently supported.

* `astyle` for __C#, C++, C and Java__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install astyle` in a terminal.
Otherwise, download it here: http://astyle.sourceforge.net/

* `jsbeautify` (the python CLI version) for __Javascript__.
This one can also be installed as a vundle package, and I recommend to do so.
Put this in your .vimrc: `Bundle "einars/jsbeautify"`.
Note that we're only using the python version, so `node` doesn't have to be installed.
Here is the link to the repository: https://github.com/einars/js-beautify

* `autopep8` for __Python__.
It's probably in your distro's repository, so you can download it as a regular package.
For Ubuntu type `sudo apt-get install autopep8` in a terminal.
Here is the link to the repository: https://github.com/hhatto/autopep8
And here the link to its page on the python website: http://pypi.python.org/pypi/autopep8/0.5.2

* `phpCB` for __PHP__.
You can download it's binary here 
http://www.waterproof.fr/products/phpCodeBeautifier/download.php
I recommend putting the phpCB binary in the `formatters/` directory.

If you find yourself in need of support for another formatprogram, simply add a configuration file in the folder `vim-autoformat/ftplugin/`.
You can take the existing ones as an example.
Oh, and be sure to send me a patch. :)

How can I change the behaviour of formatters?
---------------------------------------------
Every formatter is called from a script in the `vim-autoformat/ftplugin/` directory.
E.g. the file that calls the C# formatter is named `vim-autoformat/ftplugin/cs.vim`.
You can change the arguments passed to the formatter in that file.


If you have any suggestions on this plugin or on this readme, or if you experience problems, please contact me by creating an issue in this repository.
I'm also curious to know if it works on windows (or if it doesn't). Let me know!
