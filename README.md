# Golden Ratio

When working with many windows at the same time, each window has a size that is
not convenient for editing.

golden-ratio helps on this issue by resizing automatically the windows you are
working on to the size specified in the "Golden Ratio". The window that has the
main focus will have the perfect size for editing, while the ones that are not
being actively edited will be re-sized to a smaller size that doesn't get in
the way, but at the same time will be readable enough to know it's content.

![Example of autocmd resizing.](https://camo.githubusercontent.com/55aac943a3c4a0f24c7095ab83c7383c542ef7b1/687474703a2f2f692e696d6775722e636f6d2f456352465739642e676966)

You can also disable the automatic resizing and use a mapping to resize on
demand.

For more info about the golden ratio check out [Golden Ratio on Wikipedia](http://en.wikipedia.org/wiki/Golden_ratio).

## Options

Refer to `:help golden-ratio` for options.

## Installation

- With [pathogen](https://github.com/tpope/vim-pathogen):

```
cd ~/.vim/bundle 
git clone git://github.com/roman/golden-ratio.git
```

- With [Vundle](https://github.com/gmarik/vundle):

```
" .vimrc
Bundle 'roman/golden-ratio'
```

## Credits

This plugin was developed by Roman Gonzalez (romanandreg [at] gmail.com), if
you have any suggestions to improve the code/functionality please send a pull
request to the github repo:

http://github.com/roman/golden-ratio

Thanks particuarly to ujihisa for the inspiration to develop this plugin.

## License

golden-ratio is released under the MIT license. Check LICENSE file.
