return {
    'folke/trouble.nvim',
    opts = {
        auto_preview = false,
    },
    cmd = "Trouble",
    keys = {
        {
            "<C-e>",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "]x",
            "next",
            desc = "Next Trouble item",
        },
        {
            "[x",
            "prev",
            desc = "Previous Trouble item",
        },
    }
}
