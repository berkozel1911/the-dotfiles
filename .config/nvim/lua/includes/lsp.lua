local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

mason.setup()

mason_lsp.setup({
  ensure_installed = {
    "bashls",
    "pyright",
    "yamlls",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.bashls = {
  filetypes = { 'sh', 'bash' },
}

vim.lsp.config.yamlls = {
  settings = {
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
      },
      validate = true,
      schemaStore = {
        enable = true,
      },
    },
  },
}

vim.lsp.config.pyright = {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
        typeCheckingMode = 'basic', -- or "strict"
      },
    },
  },
}

vim.lsp.enable({
  'bashls',
  'yamlls',
  'pyright',
})

