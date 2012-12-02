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
To be able to use automatic code formatting, you have to install an external program that can format code of the programming language you are using.
It suffices to make the formatprogram either globally available or to put it in the `formatters/` folder.
Sometimes alternative installation methods are supported.

When you have installed the formatters you need, you can format visually selected code with `gq`.
You can also format the whole buffer with the command `:Autoformat`.
For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F7> :Autoformat<CR>
```

For more ways to perform autoformatting type `:help gq`.

Supported formatprograms
------------------------
Here is a list of formatprograms that are currently supported.
* `astyle` for __C#, C++, C and Java__.
It's probably in your distro's repository, so you can download it as a regular package.
(For Ubuntu type `sudo apt-get install astyle` in a terminal)

* `jsbeautify` (the python version) for __Javascript__.
This one can also be installed as a vundle package (if you use the vundle plugin).
To do so, put this in your .vimrc: `Bundle "einars/jsbeautify"`.

* `autopep8` for __Python__.
It's probably in your distro's repository, so you can download it as a regular package.
(For Ubuntu type `sudo apt-get install autopep8` in a terminal)

If you find yourself in need of support for another formatprogram, simply add a configuration file in the folder `vim-autoformat/ftplugin/`.
You can take the existing ones as an example.
Oh, and be sure to send me a patch. :)

How can I change the behaviour of formatters?
---------------------------------------------
Every formatter is called from a script in the `vim-autoformat/ftplugin/` directory.
E.g. the file that calls the C# formatter is named `vim-autoformat/ftplugin/cs.vim`.
You can change the arguments passed to the formatter in that file.
