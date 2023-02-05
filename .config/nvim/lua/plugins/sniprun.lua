return {
  {
    "michaelb/sniprun",
    build = "bash install.sh 1",
    ft = 'markdown',
    keys = {
      {
        "<leader>r",
        "<cmd>SnipRun<cr>",
        desc = "Run code"
      }
    },
  }
}
