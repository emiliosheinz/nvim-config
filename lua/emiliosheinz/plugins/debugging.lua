-- TODO: Needs improvements, currently I don't know how to close the UI :)
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    {
      "xdebug/vscode-php-debug",
      build = "npm i && npm run build"
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before["disconnect"]["dapui_config"] = function()
      dapui.close()
    end

    vim.keymap.set("n", "<Leader>?", function()
      dapui.eval(nil, { enter = true })
    end)

    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug Step Into" })
    vim.keymap.set("n", "<S-F10>", dap.step_back, { desc = "Debug Step Back" })
    vim.keymap.set("n", "<S-F11>", dap.step_out, { desc = "Debug Step Out" })
    vim.keymap.set("n", "<F12>", dap.terminate, { desc = "Debug Terminate" })

    dap.adapters.php = {
      command = "node",
      type = "executable",
      args = { vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-php-debug/out/phpDebug.js") },
    }

    dap.configurations.php = {
      {
        name = "Listen for Xdebug",
        type = "php",
        request = "launch",
        hostname = "0.0.0.0",
        port = 9003,
        pathMappings = {
          ["/var/www/accessa/"] = "${workspaceFolder}",
        },
      },
    }

    dapui.setup()
  end,
}
