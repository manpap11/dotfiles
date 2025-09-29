return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = { enabled = true },
                filtered_items = { visible = true, },
                hijack_netrw_behavior = "open_default",
            },
            window = {
                width = 30,  
            },
        })
    end,
  }
}
