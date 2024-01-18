return {
  { "morhetz/gruvbox", name = "gruvbox", lazy = true, priority = 1000 },
  {
    "dracula/vim",
    name = "dracula",
    lazy = true,
    priority = 1000,
    config = function()
      return { transparent = true }
    end,
  },
  { "fxn/vim-monochrome", name = "monochrome", lazy = true, priority = 1000 },
}
