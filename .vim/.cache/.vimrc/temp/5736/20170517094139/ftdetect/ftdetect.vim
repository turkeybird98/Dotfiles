au BufNewFile,BufRead *.{js,jsm,es,es6},Jakefile setf javascript

fun! s:SourceFlowSyntax()
  if !exists('javascript_plugin_flow') && !exists('b:flow_active') &&
        \ search('\v\C%^\_s*%(//\s*|/\*[ \t\n*]*)\@flow>','nw')
    runtime extras/flow.vim
    let b:flow_active = 1
  endif
endfun
au FileType javascript au BufRead,BufWritePost <buffer> call s:SourceFlowSyntax()

fun! s:SelectJavascript()
  if getline(1) =~# '^#!.*/bin/\%(env\s\+\)\?node\>'
    set ft=javascript
  endif
endfun
au BufNewFile,BufRead * call s:SelectJavascript()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim ftdetect file
"
" Language: JSX (JavaScript)
" Maintainer: Max Wang <mxawng@gmail.com>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Whether the .jsx extension is required.
if !exists('g:jsx_ext_required')
  let g:jsx_ext_required = 1
endif

" Whether the @jsx pragma is required.
if !exists('g:jsx_pragma_required')
  let g:jsx_pragma_required = 0
endif

if g:jsx_pragma_required
  " Look for the @jsx pragma.  It must be included in a docblock comment before
  " anything else in the file (except whitespace).
  let s:jsx_pragma_pattern = '\%^\_s*\/\*\*\%(\_.\%(\*\/\)\@!\)*@jsx\_.\{-}\*\/'
  let b:jsx_pragma_found = search(s:jsx_pragma_pattern, 'npw')
endif

" Whether to set the JSX filetype on *.js files.
fu! <SID>EnableJSX()
  if g:jsx_pragma_required && !b:jsx_pragma_found | return 0 | endif
  if g:jsx_ext_required && !exists('b:jsx_ext_found') | return 0 | endif
  return 1
endfu

autocmd BufNewFile,BufRead *.jsx let b:jsx_ext_found = 1
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.js
  \ if <SID>EnableJSX() | set filetype=javascript.jsx | endif
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript
autocmd BufNewFile,BufRead *.json setlocal filetype=json
autocmd BufNewFile,BufRead *.jsonp setlocal filetype=json
autocmd BufNewFile,BufRead *.geojson setlocal filetype=json
autocmd BufNewFile,BufRead *.ts,*.tsx set filetype=typescript
" Detect syntax file.
autocmd BufNewFile,BufRead *.snip,*.snippets set filetype=neosnippet
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=markdown |
      \ else |
      \   setf markdown |
      \ endif
au BufNewFile,BufRead .tern-project setf json
au BufNewFile,BufRead .tern-config setf json
" Language:    CoffeeScript
" Maintainer:  Mick Koch <mick@kochm.co>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *Cakefile set filetype=coffee
autocmd BufNewFile,BufRead *.coffeekup,*.ck set filetype=coffee
autocmd BufNewFile,BufRead *._coffee set filetype=coffee

function! s:DetectCoffee()
    if getline(1) =~ '^#!.*\<coffee\>'
        set filetype=coffee
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectCoffee()
" Language:   Literate CoffeeScript
" Maintainer: Michael Smith <michael@diglumi.com>
" URL:        https://github.com/mintplant/vim-literate-coffeescript
" License:    MIT

autocmd BufNewFile,BufRead *.litcoffee set filetype=litcoffee
autocmd BufNewFile,BufRead *.coffee.md set filetype=litcoffee

autocmd BufNewFile,BufRead {.,}tmux*.conf set ft=tmux | compiler tmux
