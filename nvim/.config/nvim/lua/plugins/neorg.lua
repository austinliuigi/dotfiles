return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    ft = "norg",
    cmd = "Neorg",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = {
      load = {
        ["core.defaults"] = {
          config = {}
        },

        ["core.keybinds"] = {
            config = {
                default_keybinds = true,
                neorg_leader = "\\",
            }
        },

        ["core.concealer"] = {
          config = { -- Note that this table is optional and doesn't need to be provided
            icon_preset = "diamond",
            -- icons = nil,
            -- dim_code_blocks = nil,
            content_only = true,
            adaptive = true,
            width = "fullwidth",
            -- padding = nil,
            conceal = true,
          }
        },

        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          }
        },

        ["core.dirman"] = {
          config = {
            workspaces = {
              gtd = "~/.local/gtd",
            },
          },
        },

        ["core.export"] = {
          config = {
            export_dir = "<export-dir>/<language>-export"
          }
        },

        ["core.export.markdown"] = {
          config = {
            extensions = "all"
          }
        }

        -- ["core.gtd.base"] = {
        --   config = {
        --     workspace = "gtd",
        --   },
        -- },
      },
    },
  },
}
