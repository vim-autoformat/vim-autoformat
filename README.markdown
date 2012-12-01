vim-autoformat
==============

This vim plugin provides bindings for external code-formatting programs.
If you have installed a supported formatprogram correctly, it will integrate with vim automatically.


How to install (Vundle)
-----------------------

Put this in your .vimrc

```vim
Bundle "Chiel92/vim-autoformat"
```

Supported formatprograms
------------------------
* einars/jsbeautify for javascript (has to be installed as a pathogen-compatible plugin)
* autopep8 for python (must be globally available)

If you find yourself in need of support for another formatprogram, simply add a configuration file in the folder ```ftplugin```.
You can take the existing ones as an example.
Oh, and be sure to send me a patch. :)

