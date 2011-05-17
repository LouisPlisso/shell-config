if exists('b:did_my_haskell_plugin')
    finish
endif
let b:did_my_haskell_plugin = 1

so <sfile>:h/program.vim

setl isk+=' et sts=4 sw=4
setl nospell

compiler ghc

if !exists('*s:HaskellExtractImportParts')
    function s:HaskellExtractImportParts(line) abort
        let import_re = '^\s*import\>' .
                      \ '\%(\s\+\(qualified\>\)\)\=' .
                      \ '\%(\s*\("[^"]*"\)\)\=' .
                      \ '\s*\(\k\+\%(\.\k\+\)*\)' .
                      \ '\%(\s\+\(\S.*\)\)\='
        let c = matchlist(a:line, import_re)
        if !empty(c)
            let c = [c[1] . (len(c[1]) && len(c[2]) ? ' ' : '') . c[2], c[3], c[4]]
        endif
        return c
    endfunction
endif

if !exists('*s:HaskellAlignImports')
    function s:HaskellAlignImports() range abort
        let m = repeat([0], 3)
        let i = a:firstline
        while i <= a:lastline
            let c = s:HaskellExtractImportParts(getline(i))
            if !empty(c)
                call map(c, 'strlen(v:val)')
                let j = 0
                while j < len(m)
                    let m[j] = max([m[j], c[j]])
                    let j += 1
                endwhile
            endif
            let i += 1
        endwhile
        let i = a:firstline
        while i <= a:lastline
            let c = s:HaskellExtractImportParts(getline(i))
            if !empty(c)
                call setline(i,
                \            substitute(printf('import%s%-*s %-*s %-*s',
                \                              m[0] ? ' ' : '',
                \                              m[0], c[0],
                \                              m[1], c[1],
                \                              m[2], c[2]),
                \                       '\s\+$',
                \                       '',
                \                       ''))
            endif
            let i += 1
        endwhile
    endfunction
endif

if !exists('*s:PreservingCursor')
    function s:PreservingCursor(cmd)
        let sp = getpos('.')
        execute a:cmd
        call setpos('.', sp)
    endfunction
endif

command! -range=% -bar -buffer HaskellAlignImports call s:PreservingCursor('<line1>,<line2>call s:HaskellAlignImports()')
