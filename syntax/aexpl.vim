" Vim syntax file
" Language:	    AEXPL
" Maintainer:	Arvid Gerstmann <github@arvid.io>
" Last Change:	2019 Mar 20

" Quit when a (custom) syntax file was already loaded
if v:version < 600
	syntax clear
elseif exists('b:current_syntax')
	finish
endif

let s:cpo_save = &cpo
set cpo&vim

let s:ft = "aexpl"

syn case match

" Comments
syn keyword aexTodo TODO FIXME XXX contained
syn region aexCommentLine                                                 start="//"                      end="$"   contains=aexTodo
syn region aexCommentLineDoc                                              start="//\%(//\@!\|!\)"         end="$"   contains=aexTodo
syn region aexCommentLineDocError                                         start="//\%(//\@!\|!\)"         end="$"   contains=aexTodo contained
syn region aexCommentBlock             matchgroup=aexCommentBlock         start="/\*\%(!\|\*[*/]\@!\)\@!" end="\*/" contains=aexTodo,aexCommentBlockNest
syn region aexCommentBlockDoc          matchgroup=aexCommentBlockDoc      start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=aexTodo,aexCommentBlockDocNest
syn region aexCommentBlockDocError     matchgroup=aexCommentBlockDocError start="/\*\%(!\|\*[*/]\@!\)"    end="\*/" contains=aexTodo,aexCommentBlockDocNestError contained
syn region aexCommentBlockNest         matchgroup=aexCommentBlock         start="/\*"                     end="\*/" contains=aexTodo,aexCommentBlockNest contained transparent
syn region aexCommentBlockDocNest      matchgroup=aexCommentBlockDoc      start="/\*"                     end="\*/" contains=aexTodo,aexCommentBlockDocNest contained transparent
syn region aexCommentBlockDocNestError matchgroup=aexCommentBlockDocError start="/\*"                     end="\*/" contains=aexTodo,aexCommentBlockDocNestError contained transparent


" Folding
syn region aexFoldBraces start="{" end="}" transparent fold


" Highlighting
if v:version >= 508 || !exists('aexpl_syn_did_init')
    if v:version < 508
        lef aexpl_syn_did_init = 1
            command -nargs=+ HiLink hi link <args>
	else
	    command -nargs=+ HiLink hi def link <args>
	endif

    HiLink aexCommentLine          Comment
    HiLink aexCommentLineDoc       SpecialComment
    HiLink aexCommentLineDocError  Error
    HiLink aexCommentBlock         aexCommentLine
    HiLink aexCommentBlockDoc      aexCommentLineDoc
    HiLink aexCommentBlockDocError Error

    delcommand HiLink
endif

syn sync minlines=200
syn sync maxlines=500


let b:current_syntax = "aexpl"

unlet s:ft

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=4

