-- Go buffer-local 키맵
-- (글로벌 매핑이 vim 내장 f<char> 검색·<leader>f format·<leader>t Toggle 그룹과 충돌해서 분리)

local map = function(lhs, rhs, desc)
  vim.keymap.set('n', lhs, rhs, { buffer = true, desc = 'Go: ' .. desc })
end

map('<leader>ge',  '<cmd>GoIfErr<CR>',      '[E]rr block')
map('<leader>gf',  '<cmd>GoFillStruct<CR>', '[F]ill struct')
map('<leader>gs',  '<cmd>GoFillSwitch<CR>', '[S]witch fill')
map('<leader>gi',  '<cmd>GoImports<CR>',    '[I]mports')
map('<leader>gTa', '<cmd>GoAddTag<CR>',     'Tag [A]dd')
map('<leader>gTr', '<cmd>GoRmTag<CR>',      'Tag [R]emove')
map('<leader>gTc', '<cmd>GoClearTag<CR>',   'Tag [C]lear')
