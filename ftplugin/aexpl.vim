" Vim filetype plugin file
" Language:	AEXPL
" Maintainer:	Arvid Gerstmann <github@arvid.io>
" Last Change:	2019 Mar 20

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
    finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

setlocal comments=s0:/*!,m: ,ex:*/,s1:/*,mb:*,ex:*/,:///,://!,://
setlocal commentstring=//\ %s

let b:undo_ftplugin = 'setlocal comments< commentstring<'

