*golden_ratio.txt*  Resize windows automatically using the Golden Ratio
*golden-ratio*

===============================================================================
CONTENTS                                                *golden-ratio-contents*

    1.Intro...................................|golden-ratio-intro|
    2.Options.................................|golden-ratio-options|
    3.Mappings................................|golden-ratio-mappings|
    4.Credits.................................|golden-ratio-license|
    5.License.................................|golden-ratio-license|

===============================================================================
1. Intro                                                   *golden-ratio-intro*


When working with many windows at the same time, each window has a size
that is not convenient for editing.

golden-ratio helps on this issue by resizing automatically the windows you are
working on to the size specified in the "Golden Ratio". The window that has the
main focus will have the perfect size for editing, while the ones that are
not being actively edited will be re-sized to a smaller size that doesn't get
in the way, but at the same time will be readable enough to know it's content.

For more info about the golden ratio check out

http://en.wikipedia.org/wiki/Golden_ratio


===============================================================================
2. Options                                               *golden-ratio-options*

                                                        *'loaded-golden-ratio'*
Use this option to disable golden-ratio plugin completely: >
  let g:loaded_golden_ratio = 1
<

                                                   *'golden_ratio_autocommand'*
Use this option to disable the autocommand events for golden ratio
(on by default): >
  let g:golden_ratio_autocommand = 0
<

===============================================================================
3. Mappings                                             *golden-ratio-mappings*

                                                        *golden-ratio-resize*
<Plug>GoldenRatioResize
  It will perform the resizing of the current window to the golden ratio, by
  default is mapped to <LEADER>g if not mapped already.

===============================================================================
4. Credits                                               *golden-ratio-credits*

This plugin was developed by Roman Gonzalez (romanandreg [at] gmail.com), if
you have any suggestions to improve the code/functionality please send an email
or even better, send a pull request to the github repo:

http://github.com/roman/golden_ratio

Thanks particuarly to ujihisa for the inspiration to develop this plugin.

===============================================================================
5. License                                               *golden-ratio-license*

golden-ratio is relased under the MIT license.
check LICENSE file
