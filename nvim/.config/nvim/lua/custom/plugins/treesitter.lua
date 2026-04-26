return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  -- main 브랜치는 lazy-load를 지원하지 않음 (공식 README)
  lazy = false,
  build = ':TSUpdate',
  config = function()
    vim.treesitter.language.register('yaml', 'yaml.github')

    -- 설치 대상 parsers (master 브랜치 ensure_installed에서 그대로 가져옴)
    local parsers = {
      'bash',
      'c',
      'diff',
      'dockerfile',
      'html',
      'kcl',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      'go',
      'gomod',
      'gosum',
      'gowork',
      'proto',
      'yaml',
    }

    -- 누락된 parser만 설치 (첫 실행 시에만 동기 설치, 이후엔 no-op)
    local installed = require('nvim-treesitter.config').get_installed 'parsers'
    local to_install = vim.iter(parsers)
      :filter(function(p)
        return not vim.tbl_contains(installed, p)
      end)
      :totable()
    if #to_install > 0 then
      require('nvim-treesitter').install(to_install):wait(300000)
    end

    -- highlight + indent를 FileType에서 직접 활성화
    -- (main 브랜치는 자동 활성화를 제거했으므로 사용자가 직접 hook을 걸어야 함)
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('user-treesitter', { clear = true }),
      callback = function(args)
        if pcall(vim.treesitter.start) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
