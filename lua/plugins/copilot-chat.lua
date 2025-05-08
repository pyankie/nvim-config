return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        config = function()
          require("render-markdown").setup({
            file_types = { "markdown", "copilot-chat" },
          })
        end,
      },
    },
    build = function()
      return "make tiktoken"
    end,
    event = "VeryLazy",
    opts = {
      debug = false,
      show_help = "yes",
      window = {
        layout = "float",
        relative = "cursor",
        width = 0.8,
        height = 0.4,
        row = 1,
      },
      mappings = {
        complete = { insert = "<Tab>" },
        close = { normal = "q", insert = "<C-c>" },
        reset = { normal = "<C-l>", insert = "<C-l>" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        accept_diff = { normal = "<C-y>", insert = "<C-y>" },
        show_diff = { normal = "gd" },
        show_help = { normal = "gh" },
      },
      prompts = {
        Explain = {
          prompt = "Explain how the selected code works in English.",
          mapping = "<leader>ce",
          description = "Explain selected code",
        },
        Review = {
          prompt = "Review the selected code and suggest improvements.",
          mapping = "<leader>cr",
          description = "Review code",
        },
        Tests = {
          prompt = "Generate unit tests for the selected code.",
          mapping = "<leader>ct",
          description = "Generate tests",
        },
        Refactor = {
          prompt = "Refactor the selected code for better readability and performance.",
          mapping = "<leader>co",
          description = "Refactor code",
        },
        Docs = {
          prompt = "Generate documentation for the selected code.",
          mapping = "<leader>cd",
          description = "Generate documentation",
        },
        Commit = {
          prompt = "Write a commit message for the staged changes.",
          mapping = "<leader>ccw",
          description = "Generate commit message",
          selection = function()
            return require("CopilotChat.select").gitdiff()
          end,
        },
        Summarize = {
          prompt = "Summarize the selected text.",
          mapping = "<leader>cs",
          description = "Summarize text",
        },
        FixGrammar = {
          prompt = "Correct grammar and spelling in the selected text.",
          mapping = "<leader>cg",
          description = "Fix grammar",
        },
      },
      model = "gpt-4o",
      temperature = 0.7,
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)

      -- Quick chat keybinding
      vim.keymap.set({ "n", "v" }, "<leader>ccq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
        end
      end, { desc = "CopilotChat - Quick chat" })

      -- PerplexityAI keybinding
      vim.keymap.set({ "n", "v" }, "<leader>ccp", function()
        local input = vim.fn.input("Perplexity: ")
        if input ~= "" then
          require("CopilotChat").ask(
            input,
            { agent = "perplexityai", selection = require("CopilotChat.select").visual }
          )
        end
      end, { desc = "CopilotChat - Perplexity Search" })

      -- Chat history save/load
      vim.keymap.set("n", "<leader>ccs", "<cmd>CopilotChatSave my_session<cr>", { desc = "CopilotChat - Save session" })
      vim.keymap.set("n", "<leader>ccl", "<cmd>CopilotChatLoad my_session<cr>", { desc = "CopilotChat - Load session" })

      -- Model selection
      vim.keymap.set("n", "<leader>ccm", function()
        local model = vim.fn.input("Select model (gpt-4o, claude-3.7-sonnet, gemini-2.0-flash): ")
        if model ~= "" then
          require("CopilotChat").reset()
          require("CopilotChat").setup(vim.tbl_extend("force", opts, { model = model }))
          vim.notify("Switched to model: " .. model, vim.log.levels.INFO)
        end
      end, { desc = "CopilotChat - Select model" })

      -- Show current model
      vim.api.nvim_create_user_command("CopilotChatCurrentModel", function()
        local model = require("CopilotChat.config").model or "unknown"
        vim.notify("Current CopilotChat model: " .. model, vim.log.levels.INFO)
      end, { desc = "Show current CopilotChat model" })
    end,
    keys = {
      { "<leader>cc", "<cmd>CopilotChat<cr>", desc = " CopilotChat - Open chat" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = " CopilotChat - Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = " CopilotChat - Review code" },
      { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = " CopilotChat - Generate tests" },
      { "<leader>co", "<cmd>CopilotChatRefactor<cr>", desc = " CopilotChat - Refactor code" },
      { "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = " CopilotChat - Generate docs" },
      { "<leader>cc", "<cmd>CopilotChatCommit<cr>", desc = " CopilotChat - Generate commit message" },
      { "<leader>cs", "<cmd>CopilotChatSummarize<cr>", desc = "CopilotChat - Summarize text" },
      { "<leader>cg", "<cmd>CopilotChatFixGrammar<cr>", desc = "CopilotChat - Fix grammar" },
      { "<leader>ccm", desc = "CopilotChat - Select model" },
      { "<leader>cM", "<cmd>CopilotChatCurrentModel<cr>", desc = "CopilotChat - Show current model" },
    },
  },
}
