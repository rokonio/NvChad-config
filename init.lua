local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- I've never found status line to be useful
vim.o.laststatus = 0
vim.opt.cmdheight = 0
vim.opt.relativenumber = true

autocmd("QuitPre", {
  callback = function()
    vim.cmd "NvimTreeClose"
  end,
})
local function open_nvim_tree(data)
  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end
autocmd({ "VimEnter" }, { callback = open_nvim_tree })
