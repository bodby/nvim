require("blink.cmp").setup({
  signature = { enabled = false },
  keymap = {
    preset    = "default",
    ["<Tab>"] = { "select_and_accept", "fallback" },
    ["<C-space>"] = {
      function(cmp)
        cmp.show({ providers = { "buffer" } })
      end
    },
    ["<C-n>"] = {
      function(cmp)
        cmp.show()
        vim.schedule(function() cmp.select_next() end)
      end
      -- "select_next"
    },
    ["<C-p>"] = {
      function(cmp)
        cmp.show()
        vim.schedule(function() cmp.select_prev() end)
      end
      -- "select_prev"
    },
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
  completion = {
    keyword    = { range = "prefix" },
    ghost_text = { enabled = true },

    trigger = {
      prefetch_on_insert = true,
      show_in_snippet    = true,

      show_on_keyword                      = true,
      show_on_trigger_character            = true,
      show_on_insert_on_trigger_character  = true,
      show_on_blocked_trigger_characters   = { },
      show_on_x_blocked_trigger_characters = { }
    },

    list = {
      max_items = 20000,
      selection = { preselect = true, auto_insert = true },
      cycle = {
        from_bottom = true,
        from_top    = true
      }
    },
    accept = {
      create_undo_point = true,
      auto_brackets     = { enabled = false }
    },

    menu = {
      enabled            = true,
      min_width          = 1,
      max_height         = 16,
      border             = "none",
      winblend           = 0,
      scrolloff          = 3,
      scrollbar          = false,
      direction_priority = { "s", "n" },

      -- Only show in cmdline.
      auto_show = function(ctx)
        return ctx.mode == "cmdline" or vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
      end,

      draw = {
        padding = 1,
        gap     = 0,

        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1, padding = 1 }
        },

        components = {
          kind_icon = {
            ellipsis = false,

            text = function(context)
              return context.kind_icon .. context.icon_gap
            end,

            highlight = function(context)
              return "BlinkCmpKind" .. context.kind
            end
          },
          label = {
            ellipsis = false,

            width = {
              max  = 24,
              fill = true
            },

            text = function(context)
              return context.label .. context.label_detail
            end,

            highlight = function(context)
              local highlights = {
                {
                  0,
                  #context.label,
                  group = context.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel"
                },
              }

              if context.label_detail then
                table.insert(highlights, {
                  #context.label,
                  #context.label + #context.label_detail,
                  group = "BlinkCmpLabelDetail"
                })
              end

              for _, i in ipairs(context.label_matched_indices) do
                table.insert(highlights, { i, i + 1, group = "BlinkCmpLabelMatch" })
              end

              return highlights
            end
          },
          label_description = {
            ellipsis = true,
            width    = { max = 30 },

            text = function(context)
              return context.label_description
            end,

            highlight = "BlinkCmpLabelDescription",
          }
        }
      }
    },

    documentation = {
      auto_show               = false,
      auto_show_delay_ms      = 500,
      update_delay_ms         = 50,
      treesitter_highlighting = true,

      window = {
        min_width  = 10,
        max_width  = 60,
        max_height = 20,
        border     = "padded",
        winblend   = 0,
        scrollbar  = false,

        direction_priority = {
          menu_north = { "e", "w", "n", "s" },
          menu_south = { "e", "w", "s", "n" }
        }
      }
    }
  },

  fuzzy = {
    max_typos = function(keyword)
      return math.floor(#keyword / 4)
    end,

    use_frecency  = true,
    use_proximity = true,

    sorts = { "score", "sort_text", "label" },

    prebuilt_binaries = {
      download            = false,
      force_version       = nil,
      force_system_triple = nil
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

  sources = {
    -- "markdown", "spell"
    default = { "snippets", "buffer", "lsp", "path" },

    providers = {
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

      lsp = {
        name   = "LSP",
        module = "blink.cmp.sources.lsp",

        enabled            = true,
        async              = true,
        timeout_ms         = 2000,
        transform_items    = nil,
        should_show_items  = true,
        max_items          = nil,
        min_keyword_length = 0,
        -- fallbacks          = { "buffer" },
        score_offset       = 0
      },

      path = {
        name   = "Path",
        module = "blink.cmp.sources.path",

        opts = {
          trailing_slash               = false,
          show_hidden_files_by_default = true,
          label_trailing_slash         = true,

          get_cwd = function(context)
            return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
          end
        },

        enabled      = true,
        -- fallbacks    = { "buffer" },
        score_offset = 50
      },

      snippets = {
        name   = "Snippets",
        module = "blink.cmp.sources.snippets",

        opts = {
          friendly_snippets  = false,
          -- search_paths       = { vim.fn.stdpath("config") .. "/snippets" },
          -- 'root_path' is set by 'package.nix'.
          search_paths       = { vim.g.root_path .. "/snippets" },
          global_snippets    = { "all" },
          extended_filetypes = { },
          ignored_filetypes  = { },

          get_filetype = function(_)
            return vim.bo.filetype
          end
        },

        enabled      = true,
        score_offset = 100
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
})
