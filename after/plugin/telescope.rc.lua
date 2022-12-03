local status, telescope = pcall(require, 'telescope')
if (not status) then return end
local actions = require('telescope.actions')

function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require 'telescope'.extensions.file_browser.actions

telescope.setup {
  defaults = {
    mapping = {
      n = {
        ['q'] = actions.close
      }
    }
  },
  extensions = {
    file_browser = {
      theme = 'dropdown',
      -- disables netrw add user telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ['i'] = {
          ['<C-w>'] = function () vim.cmd('normal vbd') end,
        },
        ['n'] = {
          ['a'] = fb_actions.create,
          ['h'] = fb_actions.goto_parent_dir,
          ['l'] = actions.select_default,
          ['v'] = actions.file_vsplit,
          ['s'] = actions.file_split,
          ['n'] = actions.file_tab,
          ['/'] = function () vim.cmd('startinsert') end
        }
      }
    }
  }
}

telescope.load_extension('file_browser')

local opts = { noremap = true, silent = true }

local function telescopeSetKeymap(data)
  for mode,value in pairs(data) do
    for key,command in pairs(value) do
      vim.keymap.set(mode, key, command)
    end
  end
end

telescopeSetKeymap(
  {
    n = {
      [';f'] = '<cmd>lua require("telescope.builtin").find_files({ no_ignore = false, hidden = true })<cr>, opts',
      [';r'] = '<cmd>lua require("telescope.builtin").live_grep()<cr>, opts',
      ['\\\\'] = '<cmd>lua require("telescope.builtin").buffers()<cr>, opts',
      [';t'] = '<cmd>lua require("telescope.builtin").help_tags()<cr>, opts',
      [';;'] = '<cmd>lua require("telescope.builtin").resume()<cr>, opts',
      [';e'] = '<cmd>lua require("telescope.builtin").resume()<cr>, opts',
      ['sf'] = '<cmd>lua require("telescope").extensions.file_browser.file_browser({path = "%:p:h", cwd = telescope_buffer_dir(), respect_git_ignore = false, hidden = true, grouped = true, previewer = false, initial_mode = "normal", layout_config = { height=40 }})<cr>, opts'
    }
  }
)
