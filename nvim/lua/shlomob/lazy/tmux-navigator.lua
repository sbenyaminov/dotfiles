return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
    },
    keys = {
        { "<M-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate window left" },
        { "<M-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate window down" },
        { "<M-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate window up" },
        { "<M-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate window right" },
    },
}
