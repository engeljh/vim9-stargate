vim9script
# JE: Added new global variable (stargate_onechar) that should be set to 1 to
# restrict single-character search to a single line.  Uses an internal global
# variable stargate_oneline.

import '../import/stargate/workstation.vim' as ws
import '../import/stargate/vim9000.vim' as vim
import '../import/stargate/galaxies.vim'

g:stargate_ignorecase = get(g:, 'stargate_ignorecase', true)
g:stargate_limit = get(g:, 'stargate_limit', 300)
g:stargate_chars = get(g:, 'stargate_chars', 'fjdklshgaewiomc')->split('\zs')
g:stargate_name = get(g:, 'stargate_name', 'Human')
g:stargate_keymaps = get(g:, 'stargate_keymaps', {})
#JE Set g:stargate_onechar = 1 to restrict one-character search to current line
g:stargate_onechar = get(g:, 'stargate_onechar', 0) 

# Initialize highlights
ws.CreateHighlights()

# Apply highlights on a colorscheme change
augroup StargateReapplyHighlights
    autocmd!
    autocmd ColorScheme * ws.CreateHighlights()
augroup END

# Initialize hidden popup windows for stargates hints
ws.CreateLabelWindows()


# Public API functions - modified by JE
export def OKvim(mode: any)
    if type(mode) == v:t_number 
       g:stargate_oneline = mode ==# 1 && g:stargate_onechar  ==# 1 ? 1 : 0
    else
       g:stargate_oneline = 0 
    endif
    vim.OkVIM(mode)
enddef

export def Galaxy()
    galaxies.ChangeGalaxy(true)
enddef

# vim: sw=4
