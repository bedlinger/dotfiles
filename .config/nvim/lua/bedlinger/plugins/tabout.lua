return {
	{
    "kawre/neotab.nvim",
    event = "InsertEnter",
    opts = {
    tabkey = "<Tab>",
    reverse_key = "<S-Tab>",
    act_as_tab = true,
    behavior = "nested", ---@type ntab.behavior
    pairs = { ---@type ntab.pair[]
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "<", close = ">" },
    },
    exclude = {},
},
},
}
