return {{
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  }, {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "Show available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
      end,
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- enable inlay hint
    vim.lsp.inlay_hint.enable(true, { 0 })

    local x = vim.diagnostic.severity
    vim.diagnostic.config({
      virtual_text = { prefix = "" },
      signs = {
        text = {
          [x.ERROR] = " ",
          [x.WARN] = " ",
          [x.HINT] = "󰠠 ",
          [x.INFO] = " ",
        },
      },
      underline = true,
      float = { prefix = "", header = "", severity_sort = true, source = true },
    })

    -- lsp server config

    -- html: disable wrap line
    vim.lsp.config("html", {
      settings = {
        html = {
          format = {
            wrapLineLength = 0,
          },
        },
      },
    })
    -- css: ignore unknown rules
    vim.lsp.config("cssls", {
      settings = {
        css = {
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    })
    -- json: validate using schema and pull from schemastore
    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
    -- lua: recognize "vim" and "mp" global
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "mp" },
          },
        },
      },
    })
  end,
}}
