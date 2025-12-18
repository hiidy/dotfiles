-- lua/plugins/blink.lua
return {
  'saghen/blink.cmp',
  opts = {
    keymap = {
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
      ['<C-e>'] = { 'cancel', 'fallback' },
      ['<C-Space>'] = { 'show', 'fallback' },
    },
  },
}
