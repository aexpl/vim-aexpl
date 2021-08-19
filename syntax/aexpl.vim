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

" In AEXPL, '-' may be part of identifiers
" @ == isalpha(c)
" 48-57 == '0'-'9'
" @-@ == @
syn iskeyword @,48-57,_,-,$,!,?,192-255
setl isk=@,48-57,_,-,$,!,?,192-255

" Basic Keywords
syn keyword   aexKeyword     pub
syn keyword   aexKeyword     defer
syn keyword   aexKeyword     export
syn keyword   aexKeyword     extern
syn keyword   aexKeyword     atomic
syn keyword   aexKeyword     static
syn keyword   aexKeyword     in
syn keyword   aexKeyword     as
syn keyword   aexKeyword     or
syn keyword   aexKeyword     when
syn keyword   aexKeyword     This
syn keyword   aexKeyword     prop
syn keyword   aexKeyword     throws
syn keyword   aexKeyword     catch
syn keyword   aexKeyword     get
syn keyword   aexKeyword     set
syn keyword   aexKeyword     trait
syn keyword   aexKeyword     value
syn keyword   aexKeyword     virtual
syn keyword   aexKeyword     override
syn keyword   aexKeyword     requires
syn keyword   aexKeyword     ensures
syn keyword   aexKeyword     nobreak
syn keyword   aexKeyword     typeof
syn keyword   aexKeyword     sizeof
syn keyword   aexKeyword     cast
syn keyword   aexKeyword     test
syn keyword   aexKeyword     typename
syn keyword   aexKeyword     macro
syn keyword   aexKeyword     package
syn keyword   aexKeyword     import

" Keywords, followed by identifiers
syn keyword   aexKeyword     sub coro var const
syn keyword   aexKeyword     return break continue yield await throw
syn keyword   aexKeyword     record variant union class interface type alias

" Compile-time keywords
syn keyword   aexComptimeKeyword $attribute
syn keyword   aexComptimeKeyword $class
syn keyword   aexComptimeKeyword $macro
syn keyword   aexComptimeKeyword $sub

" Special Keywords
syn keyword   aexSpecial     try?
syn keyword   aexSpecial     try!
syn keyword   aexSpecial     try
syn keyword   aexSpecial     unreachable

" Assignment operators
" syn match     aexKeyword "operator="
" syn match     aexKeyword "operator+="
" syn match     aexKeyword "operator-="
" syn match     aexKeyword "operator*="
" syn match     aexKeyword "operator/="
" syn match     aexKeyword "operator%="
" syn match     aexKeyword "operator&="
" syn match     aexKeyword "operator|="
" syn match     aexKeyword "operator^="
" syn match     aexKeyword "operator<<="
" syn match     aexKeyword "operator>>="

" " Increment/Decrement
" syn match     aexKeyword "operator++"
" syn match     aexKeyword "operator--"

" " Arithmetic operators
" syn match     aexKeyword "operator+"
" syn match     aexKeyword "operator-"
" syn match     aexKeyword "operator*"
" syn match     aexKeyword "operator/"
" syn match     aexKeyword "operator%"
" syn match     aexKeyword "operator~"
" syn match     aexKeyword "operator&"
" syn match     aexKeyword "operator|"
" syn match     aexKeyword "operator^"
" syn match     aexKeyword "operator<<"
" syn match     aexKeyword "operator>>"

" " Logical operators
" syn match     aexKeyword "operator!"
" syn match     aexKeyword "operator||"
" syn match     aexKeyword "operator&&"

" " Comparison operators
" syn match     aexKeyword "operator=="
" syn match     aexKeyword "operator!="
" syn match     aexKeyword "operator<"
" syn match     aexKeyword "operator>"
" syn match     aexKeyword "operator<="
" syn match     aexKeyword "operator>="
" " syn match     aexKeyword "operator<=>"

" " Member access
" syn match     aexKeyword "operator[]"
" syn match     aexKeyword "operator()"
" syn match     aexKeyword "operator."

" Control Flow
syn keyword   aexConditional match if else
syn keyword   aexLoop        for while do foreach

" Assert & Panic
syn keyword   aexAssert      assert
syn keyword   aexAssert      assert-contract
syn keyword   aexPanic       panic

" Attributes
syn match     aexAttribute "@!\?\<[a-zA-Z_][a-zA-Z_\-!?*]*"

" Built-in types
syn keyword   aexType i8 i16 i32 i64 i128
syn keyword   aexType u8 u16 u32 u64 u128
syn keyword   aexType f16 f32 f64
syn keyword   aexType void int uint float bool

" Literals
syn keyword   aexBoolean true false

syn match     aexEscapeError        display contained /\\./
syn match     aexEscape             display contained /\\\([nrt0\\'"]\|x\x\{2}\)/
syn match     aexEscapeUnicode      display contained /\\u{\x\{1,6}}/
syn match     aexStringContinuation display contained /\\\n\s*/
syn region    aexString             start=+b"+ skip=+\\\\\|\\"+ end=+"+ contains=aextEscape,aextEscapeError,aextStringContinuation
syn region    aexString             start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=aextEscape,aextEscapeUnicode,aextEscapeError,aextStringContinuation,@Spell
syn region    aexString             start='b\?r\z(#*\)"' end='"\z1' contains=@Spell

syn match     aexDecNumber   display "\<[0-9][0-9_]*\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     aexHexNumber   display "\<0x[a-fA-F0-9_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     aexOctNumber   display "\<0o[0-7_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="
syn match     aexBinNumber   display "\<0b[01_]\+\%([iu]\%(size\|8\|16\|32\|64\|128\)\)\="

" Special case for numbers of the form "1." which are float literals, unless followed by
" an identifier, which makes them integer literals with a method call or field access,
" or by another ".", which makes them integer literals followed by the ".." token.
" (This must go first so the others take precedence.)
syn match     aexFloat       display "\<[0-9][0-9_]*\.\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\|\.\)\@!"
" To mark a number as a normal float, it must have at least one of the three things integral values don't have:
" a decimal point and more numbers; an exponent; and a type suffix.
syn match     aexFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\%([eE][+-]\=[0-9_]\+\)\=\(f\|d\|f32\|f64\)\="
syn match     aexFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\(f\|d\|f32\|f64\)\="
syn match     aexFloat       display "\<[0-9][0-9_]*\%(\.[0-9][0-9_]*\)\=\%([eE][+-]\=[0-9_]\+\)\=\(f\|d\|f32\|f64\)"

" Identifier
syn match     aexIdentifier  "\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct:][:space:]]\|_\)*" display contained


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


    hi def link aexDecNumber            aexNumber
    hi def link aexHexNumber            aexNumber
    hi def link aexOctNumber            aexNumber
    hi def link aexBinNumber            aexNumber

    " Grey
    hi def link aexCommentLine          Comment
    hi def link aexCommentBlock         aexCommentLine

    " Turqoise
    hi def link aexFloat                Float
    hi def link aexBoolean              Boolean
    hi def link aexNumber               Number
    hi def link aexString               String

    " Yellow
    hi def link aexType                 Type

    " Orange
    hi def link aexAssert               PreCondit
    hi def link aexDie                  PreCondit
    hi def link aexAttribute            Macro
    hi def link aexComptimeKeyword      PreProc

    " Green
    hi def link aexConditional          Conditional
    hi def link aexLoop                 Conditional
    hi def link aexKeyword              Keyword

    " Red
    hi def link aexSpecial              Special
    hi def link aexStringContinuation   Special
    hi def link aexCommentLineDoc       SpecialComment
    hi def link aexCommentBlockDoc      aexCommentLineDoc

    " Red Bold
    hi def link aexCommentLineDocError  Error
    hi def link aexCommentBlockDocError Error

    " Purple

    " Purple Bold
    hi def link aexTodo                 Todo

    delcommand HiLink
endif

syn sync minlines=200
syn sync maxlines=500


let b:current_syntax = "aexpl"

unlet s:ft

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=4

