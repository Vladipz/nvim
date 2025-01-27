local local_app_data = os.getenv("LOCALAPPDATA")
function setup_c_sharp(dap)
  -- dap.adapters.netcoredbg = {
  --   type = 'executable',
  --   command = "C:\\Users\\vladd\\AppData\\Local\\nvim-data\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe",
  --   args = { '--interpreter=vscode' }
  -- }
  dap.adapters.netcoredbg = {
    type = 'executable',
    command = "C:\\Users\\Vlad\\AppData\\Local\\netcoredbg\\netcoredbg.exe",
    args = { '--interpreter=vscode' }
  }
  dap.configurations.cs   = {
    {
      type = "netcoredbg",
      name = ".NET - launch",
      request = "launch",
      justMyCode = false,
      program = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
    {
      type = "netcoredbg",
      name = ".NET - attach",
      request = "attach",
      console = "integratedTerminal",
      justMyCode = false,
      program = function()
        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
      processId = function()
        return vim.fn.input("Process ID: ")
      end,
    },
  }
end

-- function setup_python(dap)
--   dap.configurations.python = {
--     {
--       type = "python",
--       request = "launch",
--       name = "Launch file",
--       program = "${file}", -- This configuration will launch the current file if used.
--     },
--   }
-- end

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      main = "dapui",
      config = true,
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
    },
  },
  keys = {
    { "<F5>",   function() require("dap").continue() end,                                             desc = "F5 - start debugging or continue session" },
    { "<S-F5>", function() require("dap").terminate() end,                                            desc = "Shift + F5 - terminate debugging session" },
    { "<F9>",   function() require("dap").toggle_breakpoint() end,                                    desc = "F9 - toggle breakpoint" },
    { "<C-F9>", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Ctrl + F9 - set conditional breakpoint" },
    { "<S-F9>", function() require("dap").clear_breakpoints() end,                                    desc = "Shift + F9 - clear all of the breakpoints" },
    { "<F10>",  function() require("dap").step_over() end,                                            desc = "F10 - step over" },
    { "<F11>",  function() require("dap").step_into() end,                                            desc = "F11 - step into" },
    { "<F12>",  function() require("dap").step_out() end,                                             desc = "F12 - step out" },
  },
  cmd = "DapUiToggle",
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    setup_c_sharp(dap)
    -- setup_python(dap)
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "❌", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "❓", texthl = "", linehl = "", numhl = "" })
    vim.api.nvim_create_user_command("DapUiToggle", function() dapui.toggle() end, {})
    vim.api.nvim_create_user_command("DapUiReset", function() dapui.open({ reset = true }) end, {})
  end
}
