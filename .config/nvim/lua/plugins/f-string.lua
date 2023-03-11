return {
  {
    "roobert/f-string-toggle.nvim",
    keys = {
      {
        "<leader>fs",
        function()
          require("f-string-toggle").toggle_fstring()
        end,
        desc = "Toffle f-string",
      },
    },
  },
}
