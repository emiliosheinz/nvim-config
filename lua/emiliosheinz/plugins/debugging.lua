-- TODO: Needs improvements, currently I don't know how to close the UI :)
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    -- Finda a way to install this through mason
    -- LazyVim has some cool examples I could try to follow
    {
      "xdebug/vscode-php-debug",
      build = "npm i && npm run build"
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dapUtils = require("dap.utils")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
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
    vim.keymap.set("n", "<F12>", function()
      dap.terminate()
      dapui.close()
    end, { desc = "Debug Terminate" })

    -- PHP Debugging
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

    -- JavaScript Debugging
    -- @see: https://github.com/ecosse3/nvim/blob/master/lua/plugins/dap.lua#L132
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        -- No the best but I can accept it for now.
        -- It would be better if I had not to hardcode the path.
        args = {
          vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}"
        },
      },
    }
    dap.configurations.typescript = {
      {
        name = "Attach",
        request = "attach",
        type = "pwa-node",
        cwd = "${workspaceFolder}",
        processId = dapUtils.pickProcess,
        skipFiles = { "<node_internals>/**" },
      },
      {
        name = "Debug Jest Tests",
        type = "pwa-node",
        request = "launch",
        runtimeArgs = {
          "--inspect-brk",
          "${workspaceFolder}/node_modules/.bin/jest",
          "--runInBand"
        },
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        cwd = "${workspaceFolder}",
      },
      {
        name = "Debug Vitest Tests",
        type = "pwa-node",
        request = "launch",
        runtimeArgs = {
          "--inspect-brk",
          "${workspaceFolder}/node_modules/vitest/vitest.mjs",
          "run",
          "${relativeFile}",
        },
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
        cwd = "${workspaceFolder}",
      }

    }

    dapui.setup()
  end,
}
