set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
colorscheme markai

highlight Cursor guifg=white guibg=orange
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=n-v-c:blinkwait3000
set guicursor+=i:ver100-iCursor
set guicursor+=i:blinkwait3000

set guifont=Fira_Code:h11:cANSI:qDRAFT

highlight CursorLine cterm=NONE ctermbg=yellow ctermfg=White guibg=gray20 guifg=White