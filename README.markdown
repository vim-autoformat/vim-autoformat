vim-autoformat
==============
This vim plugin integrates external code-formatting programs into vim automatically.
If you have installed a supported formatprogram correctly, you can use it within vim immediately.
You don't have to configure anything.
It works out of the box.


How to install (Vundle)
-----------------------
Put this in your .vimrc

```vim
Bundle "Chiel92/vim-autoformat"
```

How to use
----------
To be able to use automatic code formatting, you have to install an external program that can format code of the programming language you are using.
Normally, it suffices to make the formatprogram either globally available or to put it in the `formatters/` folder.
In some cases this is inconvenient to accomplish and therefore sometimes alternative installation methods are supported.
It is said explicitly if this is the case.

When you have succeed installing the formatters you need, you can format visually selected code with `gq`.
For more info type `:help gq`.
You can also format the whole buffer with the command `:Autoformat`.
For convenience it is recommended that you assign a key for this, like so:

```vim
noremap <F7> :Autoformat<CR>
```


Supported formatprograms
------------------------
Here is a list of formatprograms that are currently supported.
* `astyle` for __C#, C++, C and Java__.
It's probably in your distro's repository, so you can download it as a regular package.

* `jsbeautify` (the python version) for __Javascript__.
This one can also installed as a vundle package (if you use the vundle plugin).
To do so, put this in your .vimrc:

```vim
Bundle "einars/jsbeautify"
```

* `autopep8` for __Python__.
It's probably in your distro's repository, so you can download it as a regular package.

If you find yourself in need of support for another formatprogram, simply add a configuration file in the folder `vim-autoformat/ftplugin/`.
You can take the existing ones as an example.
Oh, and be sure to send me a patch. :)

How can I change the behaviour of formatters?
---------------------------------------------
Every formatter is called from a script in the `vim-autoformat/ftplugin/` directory.
E.g. the file that calls the C# formatter is named `vim-autoformat/ftplugin/cs.vim`.
You can change the arguments passed to the formatter there.
