return {
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          {
            "<leader>du",
            function()
              require("dapui").toggle({})
            end,
            desc = "Dap UI",
          },
          {
            "<leader>de",
            function()
              require("dapui").eval()
            end,
            desc = "Eval",
            mode = { "n", "v" },
          },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
    },
    keys = {
      {
        "<leader>cc",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local filename = vim.fn.expand("%:p")
          local basename = vim.fn.expand("%:p:r")

          -- Create a new terminal for compilation and execution
          local cpp_term = Terminal:new({
            cmd = string.format("g++ -std=c++17 %s -o %s && %s", filename, basename, basename),
            direction = "float",
            close_on_exit = false,
            on_stdout = function(_, data)
              if data then
                print(data)
              end
            end,
            on_stderr = function(_, data)
              if data then
                print("Error: " .. data)
              end
            end,
            on_exit = function(_, code)
              if code == 0 then
                print("Compilation and execution successful!")
              else
                print("Compilation or execution failed!")
              end
            end,
          })

          cpp_term:toggle()
        end,
        desc = "Compile and Run C++",
      },

      -- Add a separate compile-only command
      {
        "<leader>cb",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local filename = vim.fn.expand("%:p")
          local basename = vim.fn.expand("%:p:r")

          local compile_term = Terminal:new({
            cmd = string.format("g++ -std=c++17 %s -o %s", filename, basename),
            direction = "float",
            close_on_exit = false,
            on_exit = function(_, code)
              if code == 0 then
                print("Compilation successful!")
              else
                print("Compilation failed!")
              end
            end,
          })

          compile_term:toggle()
        end,
        desc = "Compile C++ Only",
      },
    },
  },
}
