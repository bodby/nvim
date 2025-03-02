-- FIXME: When this used the Lua implementation, I was able to get proper Neovim API LSP
--        suggestions. Maybe I should use that instead of the Rust impl.?
--        See https://github.com/Saghen/blink.cmp/pull/1356.

-- TODO: Finish config. Remove default values.
return {
  event = "BufEnter",
  pattern = "*",
  opts = {
    keymap = {
      preset = "none",

      ["<C-Space>"] = { "show" },
      ["<Tab>"] = { "select_and_accept", },
      ["<S-CR>"] = { "snippet_forward", "fallback" },

      ["<C-n>"] = {
        function(cmp)
          if not cmp.is_menu_visible() then
            cmp.show()
          end
          cmp.select_next()
        end
      },

      ["<C-p>"] = {
        function(cmp)
          if not cmp.is_menu_visible() then
            cmp.show()
          end
          cmp.select_prev()
        end
      }
    },

    completion = {
      list = { max_items = 1000 },
      accept = {
        auto_brackets = { enabled = false }
      },

      menu = {
        enabled = true,
        min_width = 8,
        max_height = 16,
        border = "none",
        scrolloff = 3,
        scrollbar = false,

        auto_show = function(ctx)
          return ctx.mode == "cmdline" or vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
        end,

        draw = {
          padding = 1,
          gap = 1,

          -- TODO: Add "label_description"?
          columns = {
            { "kind", "label", "source_name" }
          },

          components = {
            kind = {
              ellipsis = false,

              text = function(context)
                return context.kind_icon .. context.icon_gap
              end,

              highlight = function(context)
                return context.kind_hl
              end
            },

            label = {
              ellipsis = true,

              width = {
                max = 36,
                fill = true
              },

              text = function(context)
                return context.label .. context.label_detail
              end,

              highlight = function(context)
                local base = "BlinkCmpLabel"
                local label = context.label
                local highlights = {
                  { 0, #label, group = context.deprecated and base .. "Deprecated" or base }
                }

                if context.label_detail then
                  table.insert(highlights, {
                    #label,
                    #label + #context.label_detail,
                    group = base .. "Detail"
                  })
                end

                for _, i in ipairs(context.label_matched_indices) do
                  table.insert(highlights, { i, i + 1, group = base .. "Match" })
                end

                return highlights
              end
            }
          }
        }
      },

      documentation = { auto_show = false },
      ghost_text = { enabled = true }
    },

    fuzzy = {
      implementation = "prefer_rust",

      max_typos = function(keyword)
        return math.floor(#keyword / 4)
      end,

      use_frecency = true,
      use_proximity = true,

      prebuilt_binaries = { download = false }
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },

      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp"
        },

        path = {
          name = "Path",
          module = "blink.cmp.sources.path",

          opts = {
            trailing_slash = false,
            show_hidden_files_by_default = true,
            label_trailing_slash = true,

            get_cwd = function(context)
              return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
            end
          },

          enabled = true,
          score_offset = 50
        },

        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",

          opts = {
            friendly_snippets  = false,
            -- 'root_path' is set by nix/package.nix.
            search_paths = { vim.g.root_path .. "/snippets" },
            global_snippets = { "all" },
            extended_filetypes = { },
            ignored_filetypes = { },

            get_filetype = function(_)
              return vim.bo.filetype
            end
          },

          enabled      = true,
          score_offset = 100
        },

        buffer = {
          name   = "Buffer",
          module = "blink.cmp.sources.buffer",

          opts = {
            get_bufnrs = function()
              return vim.iter(vim.api.nvim_list_wins())
                :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                :filter(function(buf) return vim.bo[buf].buftype ~= "nofile" end)
                :totable()
            end
          },

          -- fallbacks = { "snippets" }
        },


        -- spell = {
        --   name   = "Spell",
        --   module = "blink-cmp-spell",
        --
        --   opts = {
        --     max_entries = 8,
        --
        --     -- enable_in_context = function() return true end
        --     -- Only enable in @spell TS captures.
        --     enable_in_context = function()
        --       for _, hl in pairs(vim.treesitter.get_captures_at_cursor(0)) do
        --         if hl == "spell" then
        --           return true
        --         end
        --       end
        --
        --       return false
        --     end
        --   },
        --
        --   enabled      = true,
        --   score_offset = 3
        -- }

        -- markdown = {
        --   name      = "RenderMarkdown",
        --   module    = "render-markdown.integ.blink",
        --   enabled   = true,
        --   fallbacks = { "buffer" }
        -- }
      }
    },


    cmdline = {
      enabled = true,
      keymap = {
        ["<Tab>"] = { "show", "accept" }
      },

      completion = {
        menu = {
          auto_show = true
        }
      }
    },

    snippets = {
      expand = function(snippet)
        vim.snippet.expand(snippet)
      end,

      active = function(filter)
        return vim.snippet.active(filter)
      end,

      jump = function(direction)
        vim.snippet.jump(direction)
      end
    },

    appearance = {
      highlight_ns            = vim.api.nvim_create_namespace "blink_cmp",
      use_nvim_cmp_as_default = false,
      nerd_font_variant       = "normal",

      kind_icons = {
        Text          = "b",
        Method        = "f",
        Function      = "f",
        Constructor   = "c",
        Field         = "v",
        Variable      = "v",
        Property      = "p",
        Class         = "t",
        Interface     = "i",
        Struct        = "s",
        Module        = "m",
        Unit          = "u",
        Value         = "v",
        Enum          = "e",
        EnumMember    = "e",
        Keyword       = "k",
        Constant      = "k",
        Snippet       = "s",
        Color         = "c",
        File          = "f",
        Reference     = "&",
        Folder        = "d",
        Event         = "e",
        Operator      = ":",
        TypeParameter = "t"
      }
    }
  }
}
