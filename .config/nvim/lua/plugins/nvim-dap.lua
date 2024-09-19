return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    "mxsdev/nvim-dap-vscode-js",
    {
      "microsoft/vscode-js-debug",
      version = "1.x",
      build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
    },
  },
  keys = {
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
    },
    {
      "<C-'>",
      function()
        require("dap").step_over()
      end,
    },
    {
      "<C-;>",
      function()
        require("dap").step_into()
      end,
    },
    {
      "<C-:>",
      function()
        require("dap").step_out()
      end,
    },
  },
  config = function()
    require("dap-vscode-js").setup({
      debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    })

    for _, language in ipairs({ "typescript", "typescriptreact", "javascript" }) do
      require("dap").configurations[language] = {
        -- attach to a node process that has been started with
        -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
        -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
        {
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          name = "Attach debugger to existing `node --inspect` process",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
          cwd = "${workspaceFolder}/src",
          skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
        },
        {
          type = "pwa-chrome",
          name = "Launch Chrome to debug client",
          request = "launch",
          url = "http://localhost:3000",
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}/src",
          skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
        },
        language == "javascript" and {
          type = "pwa-node",
          request = "launch",
          name = "Launch file in new node process",
          program = "${file}",
          cwd = "${workspaceFolder}",
        } or nil,
      }
    end

    require("dapui").setup()

    local dap, dapui = require("dap"), require("dapui")

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({ reset = true })
    end

    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
  end,
}
