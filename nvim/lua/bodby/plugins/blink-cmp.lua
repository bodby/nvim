require("blink.cmp").setup({
  blocked_filetypes = { "alpha" },
  signature = { enabled = false },
  keymap = {
    preset = "default",
    ["<Tab>"] = { "select_and_accept", "fallback" }
  },

  snippets = {
    expand = function(snippet)
      vim.snippet.expand(snippet)
    end,
    active = function(filter)
      vim.snippet.active(filter)
    end,
    jump = function(direction)
      vim.snippet.jump(direction)
    end
  },

  completion = {
    keyword = { range = "prefix" },
    trigger = {
      show_in_snippet = true,
      show_on_blocked_trigger_characters = { " ", "\n", "\t" },
      show_on_accept_on_trigger_character = true,
      show_on_insert_on_trigger_character = true,
      show_on_x_blocked_trigger_characters = { "'", '"', '(' }
    },

    list = {
      max_items = 400,
      selection = "preselect",
      cycle = {
        from_bottom = true,
        from_top = true
      }
    },

    accept = {
      create_undo_point = true,
      auto_brackets = { enabled = true }
    },

    menu = {
      enabled = true,
      min_width = 15,
      max_height = 16,
      border = "none",
      winblend = 0,
      winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      scrolloff = 3,
      scrollbar = false,
      direction_priority = { "s", "n" },
      draw = {
        -- "label" or "none"
        align_to_component = "label",
        padding = 0,
        gap = 0,

        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
        -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },

        --- ellipsis: Whether to add an ellipsis when truncating the text.
        --- width: Controls the min (int), max (int), and fill (bool) behavior of the component.
        --- text (function): Called for each item.
        --- highlight (function): Called only when the line appears on screen.
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(context)
              return " " .. context.kind_icon .. context.icon_gap
            end,
            highlight = function(context)
              -- return require("blink.cmp.completion.windows.render.tailwind").get_hl(context)
              -- or "BlinkCmpKind" .. context.kind
              return "BlinkCmpKind" -- .. context.kind
            end
          },

          kind = {
            ellipsis = false,
            width = { fill = true },
            text = function(context)
              return context.kind
            end,
            highlight = function(context)
              return "BlinkCmpKind" .. context.kind
            end
          },

          label = {
            ellipsis = true,
            width = {
              max = 60,
              fill = true
            },
            text = function(context)
              return context.label .. context.label_detail
            end,
            highlight = function(context)
              local highlights = {
                { 0, #context.label, group = context.deprecated
                and "BlinkCmpLabelDeprecated"
                or "BlinkCmpLabel" },
              }
              if context.label_detail then
                table.insert(highlights, {
                  #context.label,
                  #context.label + #context.label_detail,
                  group = "BlinkCmpLabelDetail"
                })
              end

              -- for _, i in ipairs(context.label_matched_indices) do
              --   table.insert(highlights, { i, i + 1, group = "BlinkCmpLabelMatch" })
              -- end

              return highlights
            end
          },

          label_description = {
            ellipsis = true,
            width = { max = 30 },
            text = function(context)
              return context.label_description
            end,
            highlight = "BlinkCmpLabelDescription",
          }
        }
      }
    },
    documentation = {
      auto_show = false,
      auto_show_delay_ms = 500,
      update_delay_ms = 50,
      treesitter_highlighting = true,
      window = {
        min_width = 10,
        max_width = 60,
        max_height = 20,
        border = "padded",
        winblend = 0,
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        scrollbar = false,
        direction_priority = {
          menu_north = { "e", "w", "n", "s" },
          menu_south = { "e", "w", "s", "n" },
        }
      }
    },
    ghost_text = { enabled = false }
  },

  fuzzy = {
    use_typo_resistance = false,
    use_frecency = true,
    use_proximity = true,
    max_items = 200,
    sorts = { "label", "kind", "score" },

    prebuilt_binaries = {
      -- If false, manually build the fuzzy binary dependencies by running `cargo build --release`.
      download = false,
      force_version = nil,
      force_system_triple = nil
    }
  },

  sources = {
    completion = {
      enabled_providers = { "lsp", "path", "snippets", "buffer" },
    },
    providers = {
      lsp = {
        name = "LSP",
        module = "blink.cmp.sources.lsp",

        enabled = true,
        transform_items = nil,
        should_show_items = true,
        max_items = nil,
        min_keyword_length = 0,
        fallback_for = {},
        score_offset = 0,
        override = nil
      },
      path = {
        name = "Path",
        module = "blink.cmp.sources.path",
        score_offset = 3,
        opts = {
          trailing_slash = false,
          label_trailing_slash = true,
          get_cwd = function(context)
            return vim.fn.expand(('#%d:p:h'):format(context.bufnr))
          end,
          show_hidden_files_by_default = true
        }
      },
      snippets = {
        name = "Snippets",
        module = "blink.cmp.sources.snippets",
        score_offset = -3,
        opts = {
          friendly_snippets = true,
          search_paths = { vim.fn.stdpath('config') .. '/snippets' },
          global_snippets = { 'all' },
          extended_filetypes = {},
          ignored_filetypes = {},
          get_filetype = function(context)
            return vim.bo.filetype
          end
        }
      },
      buffer = {
        name = "Buffer",
        module = "blink.cmp.sources.buffer",
        fallback_for = { "lsp" },
      },
      -- See blink-compat.lua (unless it doesn't exist, in which case -- oops).
      obsidian = {
        name = "cmp_obsidian",
        module = "blink.compat.source",

        enabled = true,
        -- TODO: Remove the first 3 letters (icon) using this?
        --       It's a function that takes a string and returns a string.
        transform_items = nil,
        should_show_items = true,
        max_items = nil,
        min_keyword_length = 0,
        fallback_for = {},
        score_offset = 0,
        override = nil
      }
    }
  },

  appearance = {
    highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
    use_nvim_cmp_as_default = false,

    -- Adjusts spacing to ensure icons are aligned.
    -- "mono" or "normal".
    nerd_font_variant = "normal",
    kind_icons = {
      Text = "󰉿",
      Method = "󰊕",
      Function = "󰊕",
      Constructor = "󰒓",

      Field = "󰜢",
      Variable = "󰆦",
      Property = "󰖷",

      Class = "󱡠",
      Interface = "󱡠",
      Struct = "󱡠",
      Module = "󰅩",

      Unit = "󰪚",
      Value = "󰦨",
      Enum = "󰦨",
      EnumMember = "󰦨",

      Keyword = "󰻾",
      Constant = "󰏿",

      Snippet = "󱄽",
      Color = "󰏘",
      File = "󰈔",
      Reference = "󰬲",
      Folder = "󰉋",
      Event = "󱐋",
      Operator = "󰪚",
      TypeParameter = "󰬛",
    }
  }
})
