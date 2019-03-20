" Vim filetype plugin file
" Language:	    AEXPL
" Maintainer:	Arvid Gerstmann <github@arvid.io>
" Last Change:	2019 Mar 20

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

augroup aexpl.vim
autocmd!

setlocal comments=s0:/*!,m:\ ,ex:*/,s1:/*,mb:*,ex:*/,:///,://!,://
setlocal commentstring=//\ %s
setlocal suffixesadd=.aex

let b:undo_ftplugin = 'setlocal comments< commentstring< suffixesadd<'

augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set noet sw=8 ts=8:
