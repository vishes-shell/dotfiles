return {
  "chrisgrieser/nvim-genghis",
  dependencies = "stevearc/dressing.nvim",
  keys = {
    {
      "<leader>yp",
      function()
        require("genghis").copyFilepath()
      end,
      desc = "Copy file path",
    },
    {
      "<leader>yn",
      function()
        require("genghis").copyFilename()
      end,
      desc = "Copy file name",
    },
    {
      "<leader>rf",
      function()
        require("genghis").renameFile()
      end,
      desc = "Rename file",
    },
    {
      "<leader>mf",
      function()
        require("genghis").moveAndRenameFile()
      end,
      desc = "Move and rename file",
    },
    {
      "<leader>nf",
      function()
        require("genghis").createNewFile()
      end,
      desc = "Create new file",
    },
    {
      "<leader>yf",
      function()
        require("genghis").duplicateFile()
      end,
      desc = "Duplicate file",
    },
  },
}
