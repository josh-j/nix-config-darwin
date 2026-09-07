{pkgs, ...}: {
  programs.helix = with pkgs; {
    enable = true;
    defaultEditor = true;
    package = pkgs.helix;
    extraPackages = [
      bash-language-server
      bat
      biome
      dprint
      clang-tools
      docker-compose-language-service
      dockerfile-language-server-nodejs
      gh
      glow
      gum
      hurl
      lazysql
      mods
      navi
      presenterm
      ripgrep
      slumber
      tig
      golangci-lint
      golangci-lint-langserver
      gopls
      gotools
      lsp-ai
      marksman
      markdown-oxide
      nil
      nixd
      nixpkgs-fmt
      nodePackages.prettier
      nodePackages.typescript-language-server
      sql-formatter
      ruff
      (python3.withPackages (p: (with p; [
        python-lsp-ruff
        python-lsp-server
      ])))
      rust-analyzer
      taplo
      taplo-lsp
      terraform-ls
      typescript
      vscode-langservers-extracted
      yaml-language-server
      yq
    ];

    settings = {
      theme = "sio_rose_dark";

      editor = {
        auto-completion = true;
        auto-info = true;
        bufferline = "multiple";
        color-modes = true;
        # completion-replace = true;
        completion-timeout = 5;
        completion-trigger-len = 2;
        cursorline = false;
        end-of-line-diagnostics = "hint";
        popup-border = "all";
        preview-completion-insert = true;
        mouse = true;
        line-number = "relative";
        text-width = 120;
        shell = ["nu" "-c"];
        true-color = true;

        auto-save = {
          focus-lost = true;
          after-delay.enable = true;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
          ignore = true;
          git-ignore = true;
        };

        gutters = [
          "diagnostics"
          "line-numbers"
          "spacer"
          "diff"
          "spacer"
        ];

        indent-guides = {
          character = "┊";
          render = true;
          skip-levels = 1;
        };

        inline-diagnostics = {
          cursor-line = "disable";
        };

        lsp = {
          enable = true;
          display-messages = true;
          auto-signature-help = true;
          display-inlay-hints = true;
          display-signature-help-docs = true;
          snippets = true;
          goto-reference-include-declaration = true;
        };

        soft-wrap = {
          enable = true;
        };

        statusline = {
          left = ["mode" "file-name" "read-only-indicator" "file-modification-indicator" "version-control" "spinner"];
          right = ["file-encoding" "diagnostics" "selections" "register" "file-type" "file-line-ending" "position" "position-percentage"];
          mode.normal = "N";
          mode.insert = "I";
          mode.select = "S";
        };
      };

      keys = {
        insert = {
          esc = ["collapse_selection" "normal_mode"];
          j = {k = "normal_mode";};
        };

        normal = {
          esc = ["collapse_selection" "keep_primary_selection"];
          # space = {
          #   space = "file_picker";
          #   n = mkIf cfg.ide ":sh zellij action focus-next-pane"; # set focus to file tree
          #   o = mkIf cfg.ide {
          #     n = "file_browser";
          #     N = "file_browser_in_current_buffer_directory";
          #     # git
          #     g = ":sh zellij run --name Git -fc -- bash -c \"TERM=xterm-direct emacsclient -nw --eval '(magit-status)'\""; # open magit in floating pane
          #     # terminal
          #     t = ":sh zellij action new-pane -c -d down -- bash -c \"for _ in {1..6}; do zellij action resize decrease up; done; nu\"";
          #     # help
          #     h = ":sh zellij action new-pane -fp file:~/.config/zellij/plugins/zellij_forgot.wasm";
          #   };
          # };

          # "-" = ":sh wezterm cli split-pane --left --percent 30 -- ~/.config/helix/wezilix.sh $WEZTERM_PANE open zoom > /dev/null";
          "-" = ":sh zellij run -c -f -x 10% -y 10% --width 80% --height 80% -- nu ~/.config/helix/yazi-picker.nu open";

          space.space = "file_picker";
          # C-h = "select_prev_sibling";
          # C-j = "shrink_selection";
          # C-k = "expand_selection";
          # C-l = "select_next_sibling";

          g.a = "code_action";

          "{" = ["goto_prev_paragraph" "collapse_selection"];
          "}" = ["goto_next_paragraph" "collapse_selection"];

          D = ["extend_to_line_end" "yank_main_selection_to_clipboard" "delete_selection"];
          X = "extend_line_above";
          V = ["select_mode" "extend_to_line_bounds"];
          G = "goto_file_end";
          H = "goto_line_start";
          L = "goto_line_end";
          g.q = ":reflow";
          S = "surround_add";

          # Make j and k behave as they do Vim when soft-wrap is enabled
          # j = "move_line_down";
          # k = "move_line_up";
          # i = ["insert_mode" "collapse_selection"];
          # a = ["append_mode" "collapse_selection"];
          # u = ["undo" "collapse_selection"];

          "0" = "goto_line_start";
          "$" = "goto_line_end";

          space = {
            o = ":write";
            q = ":quit";
            l.f = ":format";
            l.r = ":lsp-restart";
            l.g = ":sh gh browse";
            # w.g = ":sh tmux new-window -n gitui";
          };

          "+" = {
            i = ":pipe aichat -r coder-openai";
            r = ":pipe aichat -r refactor-openai";
            e = [":pipe-to tee /tmp/helix-tmp-explain" ":sh aichat -f /tmp/helix-tmp-explain -r explain-openai"];
          };
          "," = {
            b = ":sh helix-wezterm blame";
            c = ":sh helix-wezterm check";
            e = ":sh helix-wezterm explorer";
            g = ":sh helix-wezterm gitui";
            o = ":sh helix-wezterm open";
            q = ":sh helix-wezterm query";
            r = ":sh helix-wezterm run";
            s = ":sh helix-wezterm slumber";
            m = ":sh helix-wezterm mock";
            n = ":sh helix-wezterm navi";
            p = ":sh helix-wezterm present";
            t = ":sh helix-wezterm test";
          };
        };

        select = {
          esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];
          "{" = ["extend_to_line_bounds" "goto_prev_paragraph"];
          "}" = ["extend_to_line_bounds" "goto_next_paragraph"];
          "0" = "goto_line_start";
          G = "goto_file_end";
          H = "goto_line_start";
          L = "goto_line_end";
          S = "surround_add"; # Basically 99% of what I use vim-surround for

          i = "select_textobject_inner";
          a = "select_textobject_around";

          k = ["extend_line_up" "extend_to_line_bounds"];
          j = ["extend_line_down" "extend_to_line_bounds"];
        };
      };
    };

    ignores = [
      ".build/"
      "!.gitignore"
    ];

    themes = {
      # https://github.com/helix-editor/helix/blob/master/runtime/themes/gruvbox.toml
      gruvbox_community = {
        inherits = "gruvbox";
        "variable" = "blue1";
        "variable.parameter" = "blue1";
        "function.macro" = "red1";
        "operator" = "orange1";
        "comment" = "gray";
        "constant.builtin" = "orange1";
        "ui.background" = {};
      };

      sio_rose_dark = let
        black_bg = "#1e1e1e";
        lilac_dark = "#897e9c";
        lilac_darker = "#5b516b";
      in {
        inherits = "boo_berry";
        "ui.statusline" = {bg = "";};
        "ui.background" = {};
        "ui.bufferline" = {bg = "";};
        "ui.bufferline.active" = {bg = "#3e3e3e";};
        "ui.help" = {bg = "";};
        "ui.menu" = {bg = "";};
        "ui.menu.selected" = {bg = lilac_darker;};
        "ui.popup" = {bg = black_bg;};
        "ui.window" = {bg = "";};
        "ui.selection" = {bg = "";};
        "ui.selection.primary" = {bg = "#443952";};
        "ui.linenr" = {fg = lilac_dark;};
        "comment" = {fg = lilac_dark;};
      };

      # berry = "#835fb0"
      # berry_fade = ##a786cf"
      # berry_dim = "#684694"
      # berry_saturated = "#2B1C3D"
      # berry_desaturated = "#886C9C"
      # bubblegum = "#D678B5"
      # gold = "#E3C0A8"
      # lilac = "#C7B8E0"
      # mint = "#7FC9AB"
      # violet = "#C78DFC"

      sio_rose_light = let
        black_bg = "#ecebe8";
        lilac_dark = "#b1afa8";
        lilac_darker = "#322c3b";
        berry = "#835fb0";
        berry_fade = "#a786cf";
        berry_dim = "#6b40a6";
        blue_dark = "#1fb8cd";
        blue_light = "#e2ecea";
        # berry = "#2F2240";
        # berry_fade = "#482F58";
        # berry_dim = "#392A4B";
        berry_saturated = "#632cab";
        berry_desaturated = "#c2afe0";
        # bubblegum = "#ab717d";
        bubblegum = "#e37b91";
        gold = "#ae9482";
        # gold = "#B69A86";
        lilac = "#7e758e";
        mint = "#66A189";
        violet = "#9F71CA";
        meh = "#e8e8e3";
        # #d15ec4
      in {
        "comment" = {fg = lilac_dark;};
        "constant" = {fg = gold;};
        "function" = {fg = mint;};
        "function.macro" = {fg = bubblegum;};
        "keyword" = {fg = bubblegum;};
        "operator" = {fg = bubblegum;};
        "punctuation" = {fg = lilac;};
        "string" = {fg = gold;};
        "type" = {fg = violet;};
        "variable" = {fg = lilac;};
        "variable.builtin" = {fg = violet;};
        "tag" = {fg = gold;};
        "label" = {fg = gold;};
        "attribute" = {fg = lilac;};
        "namespace" = {fg = lilac;};
        "module" = {fg = lilac;};
        "markup.heading" = {
          fg = gold;
          modifiers = ["bold"];
        };
        "markup.heading.marker" = {fg = berry_desaturated;};
        "markup.list" = {fg = bubblegum;};
        "markup.bold" = {modifiers = ["bold"];};
        "markup.italic" = {modifiers = ["italic"];};
        "markup.strikethrough" = {modifiers = ["crossed_out"];};
        "markup.link.url" = {
          fg = violet;
          modifiers = ["underlined"];
        };
        "markup.link.text" = {fg = violet;};
        "markup.quote" = {fg = berry_desaturated;};
        "markup.raw" = {fg = mint;};
        "ui.background" = {};
        "ui.cursor" = {
          fg = blue_light;
          bg = blue_dark;
        };
        "ui.cursor.match" = {
          fg = blue_light;
          bg = blue_dark;
        };
        "ui.cursor.select" = {
          fg = blue_light;
          bg = blue_dark;
        };
        "ui.cursor.insert" = {
          fg = lilac;
          bg = mint;
        };
        "ui.linenr" = {fg = lilac_dark;};
        "ui.linenr.selected" = {fg = lilac;};
        "ui.cursorline" = {
          fg = lilac;
          bg = berry_dim;
        };
        "ui.statusline" = {bg = meh;};
        "ui.statusline.inactive" = {
          # fg = berry_desaturated;
          # bg = berry_saturated;
          bg = "";
        };
        "ui.statusline.normal" = {
          fg = blue_dark;
          bg = blue_light;
        };
        "ui.statusline.insert" = {
          fg = berry_saturated;
          bg = mint;
        };
        "ui.statusline.select" = {
          fg = berry_saturated;
          bg = violet;
        };
        "ui.popup" = {
          fg = lilac;
          bg = black_bg;
        };
        "ui.window" = {
          fg = berry_desaturated;
          bg = "";
        };
        "ui.help" = {
          fg = lilac;
          bg = "";
        };
        "ui.text" = {fg = lilac;};
        "ui.text.focus" = {fg = mint;};
        "ui.menu" = {
          fg = lilac;
          bg = "";
        };
        "ui.menu.selected" = {
          fg = mint;
          bg = lilac_darker;
        };
        "ui.selection" = {bg = "";};
        "ui.selection.primary" = {
          fg = blue_dark;
          bg = blue_light;
        };
        "ui.bufferline" = {bg = "";};
        "ui.bufferline.active" = {bg = meh;};
        "ui.virtual.whitespace" = {fg = berry_desaturated;};
        "ui.virtual.ruler" = {bg = berry_dim;};
        "ui.virtual.indent-guide" = {fg = berry_fade;};
        "ui.virtual.inlay-hint" = {fg = berry_desaturated;};
        "diff.plus" = {fg = mint;};
        "diff.delta" = {fg = gold;};
        "diff.minus" = {fg = bubblegum;};
        "error" = {fg = bubblegum;};
        "warning" = {fg = gold;};
        "info" = {fg = lilac;};
        "hint" = {fg = lilac;};
        "diagnostic.warning" = {
          underline = {
            color = bubblegum;
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = gold;
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = lilac;
            style = "curl";
          };
        };
        "diagnostic.hint" = {
          underline = {
            color = lilac;
            style = "curl";
          };
        };
        "diagnostic.unnecessary" = {modifiers = ["dim"];};
        "diagnostic.deprecated" = {modifiers = ["crossed_out"];};
      };
    };

    languages = {
      language-server.biome = {
        command = "biome";
        args = ["lsp-proxy"];
      };

      language-server.lsp-ai = {
        command = "lsp-ai";
        config = {
          memory.file_store = {};
          models.model2 = {
            type = "open_ai";
            chat_endpoint = "https://openrouter.ai/api/v1/chat/completions";
            model = "google/gemini-2.0-flash-001";
            auth_token_env_var_name = "OPENROUTER_API_KEY";
          };
          completion = {
            model = "model2";
            parameters = {
              max_tokens = 64;
              max_context = 1024;
            };
          };
          chat = [
            {
              trigger = "!C";
              action_display_name = "Chat";
              model = "model1";
              parameters = {
                max_context = 4096;
                max_tokens = 1024;
                system = "You are a helpful assistant.";
              };
            }
          ];
        };
      };

      language-server.powershell-editor-services = {
        command = "pwsh";

        config = {
          powershell = {
            codeFormatting = {
              Preset = "OTBS";
              autoCorrectAliases = true;
              avoidSemicolonsAsLineTerminators = true;
              trimWhitespaceAroundPipe = true;
              useConstantStrings = true;
              useCorrectCasing = true;
              whitespaceBetweenParameters = true;
              pipelineIdentationStyle = "IncreaseIdentationForFirstPipeline";
            };
          };
        };
        args = [
          "-NoLogo"
          "-NoProfile"
          "-Command"
          "~/Bin/PowerShellEditorServices/PowerShellEditorServices/Start-EditorServices.ps1 -BundledModulesPath ~/Bin/PowerShellEditorServices -SessionDetailsPath ~/Bin/PowerShellEditorServices/PowerShellEditorServices.sessions.json -LogPath ~/Bin/PowerShellEditorServices/PowerShellEditorServices.log -FeatureFlags @() -AdditionalModules @() -HostName helix -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal"
        ];
      };

      language-server.rust-analyzer.config.check = {
        command = "clippy";
      };

      grammar = [
        {
          name = "powershell";
          source = {
            git = "https://github.com/airbus-cert/tree-sitter-powershell";
            rev = "c9316be0faca5d5b9fd3b57350de650755f42dc0";
          };
        }
      ];

      language = [
        {
          name = "css";
          language-servers = ["vscode-css-language-server" "lsp-ai"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.css"];
          };
          auto-format = true;
        }
        {
          name = "go";
          language-servers = ["gopls" "golangci-lint-lsp" "lsp-ai"];
          formatter = {
            command = "goimports";
          };
          auto-format = true;
        }
        {
          name = "html";
          language-servers = ["vscode-html-language-server" "lsp-ai"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.html"];
          };
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
            "lsp-ai"
          ];
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.json"];
          };
          auto-format = true;
        }
        {
          name = "jsonc";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = ["format"];
            }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.jsonc"];
          };
          file-types = ["jsonc" "hujson"];
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["marksman" "lsp-ai"];
          formatter = {
            command = "dprint";
            args = ["fmt" "--stdin" "md"];
          };
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter.command = "alejandra";
          auto-format = true;
        }
        {
          name = "powershell";
          scope = "source.powershell";
          injection-regex = "(pwsh|powershell)";
          file-types = ["ps1" "psm1" "psd1" "pscc" "psrc"];
          language-servers = ["powershell-editor-services" "lsp-ai"];
          shebangs = ["pwsh" "powershell"];
          comment-token = "#";
          block-comment-tokens = {
            start = "<#";
            end = "#>";
          };
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          auto-format = true;
        }
        {
          name = "python";
          language-servers = ["pylsp" "lsp-ai"];
          formatter = {
            command = "sh";
            args = ["-c" "ruff check --select I --fix - | ruff format --line-length 88 -"];
          };
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer" "lsp-ai"];
          auto-format = true;
        }
        {
          name = "scss";
          language-servers = ["vscode-css-language-server" "lsp-ai"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.scss"];
          };
          auto-format = true;
        }
        {
          name = "sql";
          language-servers = ["lsp-ai"];
          formatter = {
            command = "sql-formatter";
            args = ["-l" "postgresql" "-c" "{\"keywordCase\": \"lower\", \"dataTypeCase\": \"lower\", \"functionCase\": \"lower\", \"expressionWidth\": 120, \"tabWidth\": 4}"];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = ["taplo"];
          formatter = {
            command = "taplo";
            args = ["fmt" "-o" "column_width=120" "-"];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
            "lsp-ai"
          ];

          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.tsx"];
          };
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = ["format"];
            }
            "biome"
            "lsp-ai"
          ];
          formatter = {
            command = "biome";
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.ts"];
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = ["yaml-language-server"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.yaml"];
          };
          auto-format = true;
        }
      ];
    };
  };
}
