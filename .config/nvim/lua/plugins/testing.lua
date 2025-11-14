return {
  -- nvim-dap for debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-python",
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "Toggle REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup DAP UI with recommended configuration
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.6,
          max_width = 0.6,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
      })

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
      })

      -- Auto open/close DAP UI on debugging events
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Setup Python debugging with nvim-dap-python
      -- This automatically configures the debugpy adapter and basic configurations
      require("dap-python").setup("python")

      -- Load project-specific config at setup time
      local config_file = vim.fn.getcwd() .. "/.nvim-test-config.lua"
      local project_config = {}
      if vim.fn.filereadable(config_file) == 1 then
        local ok, config = pcall(dofile, config_file)
        if ok then
          project_config = config
        end
      end

      -- Add custom pytest configuration
      table.insert(dap.configurations.python, {
        type = "python",
        request = "launch",
        name = "Debug pytest with args",
        module = "pytest",
        args = function()
          local args = vim.deepcopy(project_config.pytest_args or {})

          -- Add the test path
          local test_path = vim.fn.input("Test path: ", "tests/", "file")
          table.insert(args, test_path)

          return args
        end,
        env = project_config.env or {},
        console = "integratedTerminal",
        justMyCode = false,
      })
    end,
  },

  -- neotest for test running
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run Nearest Test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run Test File",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.fn.getcwd())
        end,
        desc = "Run All Tests",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle Test Summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Show Test Output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Debug Nearest Test",
      },
      {
        "<leader>tS",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop Test",
      },
    },
    config = function()
      -- Load project-specific test configuration once at setup time
      local config_file = vim.fn.getcwd() .. "/.nvim-test-config.lua"
      local project_config = {}
      if vim.fn.filereadable(config_file) == 1 then
        local ok, config = pcall(dofile, config_file)
        if ok then
          project_config = config
        end
      end

      -- Handle uv or other command wrappers
      local python_path = "python"
      local runner = "pytest"
      local extra_args = project_config.pytest_args or {}

      if project_config.python and project_config.python:match("^uv run") then
        -- For uv projects, get the actual python path from the uv environment
        local handle = io.popen("uv run which python 2>/dev/null")
        if handle then
          local result = handle:read("*a")
          handle:close()
          if result and result ~= "" then
            python_path = result:gsub("%s+$", "")
          end
        end
      elseif project_config.python then
        python_path = project_config.python
      end

      -- Extract actual runner name (pytest, unittest, etc.)
      if project_config.runner then
        if project_config.runner:match("^uv run") then
          -- Extract just the test runner name from "uv run pytest"
          runner = project_config.runner:match("^uv run%s+(.+)$") or "pytest"
        else
          runner = project_config.runner
        end
      end

      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            args = extra_args,
            runner = runner,
            python = python_path,
            env = project_config.env or {},
          }),
        },
        -- discovery = {
        --   enabled = true,
        --   concurrent = 0, -- Auto-detect based on CPU
        -- },
        -- running = {
        --   concurrent = true,
        -- },
        -- summary = {
        --   enabled = true,
        --   animated = true,
        --   follow = true,
        --   expand_errors = true,
        --   open = "botright vsplit | vertical resize 50",
        --   mappings = {
        --     expand = { "<CR>", "<2-LeftMouse>" },
        --     expand_all = "e",
        --     output = "o",
        --     short = "O",
        --     attach = "a",
        --     jumpto = "i",
        --     stop = "u",
        --     run = "r",
        --     debug = "d",
        --     mark = "m",
        --     run_marked = "R",
        --     debug_marked = "D",
        --     clear_marked = "M",
        --     target = "t",
        --     clear_target = "T",
        --     next_failed = "J",
        --     prev_failed = "K",
        --     watch = "w",
        --   },
        -- },
        -- output = {
        --   enabled = true,
        --   open_on_run = "short",
        -- },
        -- output_panel = {
        --   enabled = true,
        --   open = "botright split | resize 15",
        -- },
        -- quickfix = {
        --   enabled = true,
        --   open = false,
        -- },
        -- status = {
        --   enabled = true,
        --   virtual_text = false,
        --   signs = true,
        -- },
      })
    end,
  },
}
