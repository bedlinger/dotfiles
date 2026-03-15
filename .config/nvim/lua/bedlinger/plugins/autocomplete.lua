return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  build = "cargo build --release",
  dependencies = {
    "onsails/lspkind.nvim",
    "L3MON4D3/LuaSnip",
  },
  opts = {
    snippets = { preset = "luasnip" },
    keymap = {
      preset = "enter",
      ["<C-space>"] = {},
      ["<C-p>"] = { "select_prev", "show", "fallback_to_mappings" },
      ["<C-n>"] = { "select_next", "show", "fallback_to_mappings" },
    },
    sources = {
      default = {
        "lsp",
        "snippets",
        "lazydev",
        "buffer",
        "path",
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbol_map[ctx.kind] or ""
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
      },
    },
  },
}
