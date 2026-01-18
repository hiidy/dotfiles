return {
  -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
  -- used for completion, annotations and signatures of Neovim apis
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      --  This function gets run when an LSP attaches to a particular buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          local fzf = require 'fzf-lua'

          -- [Fzf-Lua] Find references
          map('grr', fzf.lsp_references, '[G]oto [R]eferences')

          -- [Fzf-Lua] Goto Implementation
          map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')

          -- [Fzf-Lua] Goto Definition
          map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')

          -- [Fzf-Lua] Document Symbols
          map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')

          -- [Fzf-Lua] Workspace Symbols
          map('gW', fzf.lsp_workspace_symbols, 'Open Workspace Symbols')

          -- [Fzf-Lua] Type Definition
          map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')

          -- Goto Declaration
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- Highlight references of the word under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP capabilities with blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Language servers configuration
      local servers = {
        gopls = {
          init_options = {
            usePlaceholders = true,
          },
          root_dir = require('lspconfig.util').root_pattern('go.mod', '.git'),
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              hints = {
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                functionTypeParameters = false,
                rangeVariableTypes = false,
              },
              staticcheck = false,
              gofumpt = true,
            },
          },
        },
        buf_ls = {
          root_dir = require('lspconfig.util').root_pattern('buf.yaml', '.git'),
        },
        yamlls = {},
        sqls = {
          on_attach = function(client, bufnr)
            if client.name == 'sqls' then
              client.server_capabilities.executeCommandProvider = true
            end
          end,
          settings = {
            sqls = {
              connections = {
                {
                  driver = 'mysql',
                  dataSourceName = 'root:password@tcp(127.0.0.1:3306)/simpleblog',
                },
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Tools to install via Mason
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'goimports',
        'gofumpt',
        'golangci-lint',
        'buf',
        'yamllint',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
