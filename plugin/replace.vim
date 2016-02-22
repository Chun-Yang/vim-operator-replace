" File: replace.vim
" Author: romgrk
" Description: R-operator
" Exec: !::exe [echo 'NOT AUTOSOURCED']

" Mappings
nnoremap <silent> <Plug>ReplaceOperator :set opfunc=<SID>replaceOperatorFunction<CR>g@
vnoremap <silent> <Plug>ReplaceOperator :<C-u>call <SID>replaceOperatorFunction(visualmode())<CR>
nnoremap <silent> <Plug>ReplaceOperatorWithLastReplaced :set opfunc=<SID>replaceOperatorWithLastReplacedFunction<CR>g@
vnoremap <silent> <Plug>ReplaceOperatorWithLastReplaced :<C-u>call <SID>replaceOperatorWithLastReplacedFunction(visualmode())<CR>

" Public: s:replace() wrappers
fu! s:replaceOperatorFunction (motion)
    call s:replace(a:motion, '*')
endfu

fu! s:replaceOperatorWithLastReplacedFunction (motion)
    " by default - register is used to save inline-deleted content
    call s:replace(a:motion, '-')
endfu

" Private: replace operation
function! s:replace (type, register_from)
    let type          = get(a:, 'type')
    let register_from = get(a:, 'register_from')

    if     type==#'char' | let expr = "`[v`]"
    elseif type==#'line' | let expr = "'[v']"
    elseif type==#'v'    | let expr = "`<v`>"
    elseif type==#'V'    | let expr = "'<V'>"
    else | return | end

    exe 'normal! '.expr

    " by default, " register will be changed, we do not want that happen
    let unnamed_register_original = getreg('"')
    let delete_register_original  = getreg('-')
    " by by default deleted content is saved to " register
    exe 'normal! ""d'
    " normally, we save deleted content to - register
    " if we want to use the content of the
    let delete_register_new = register_from ==# '-' ?
        \ delete_register_original :
        \ getreg('"')
    call setreg('-', delete_register_new)
    call setreg('"', unnamed_register_original)

    exe 'normal! "'.register_from.'P'
endfu
