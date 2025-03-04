{pkgs, ...}: {
  programs.helix = with pkgs; {
    enable = true;
    defaultEditor = true;
    package = pkgs.unstable.helix;
    extraPackages = [
      bash-language-server
      biome
      clang-tools
      docker-compose-language-service
      dockerfile-language-server-nodejs
      golangci-lint
      golangci-lint-langserver
      gopls
      gotools
      lsp-ai
      marksman
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
    ];

    settings = {
      theme = "booberry_mod";

      editor = {
        auto-completion = true;
        end-of-line-diagnostics = "hint";
        color-modes = true;
        completion-trigger-len = 2;
        cursorline = false;
        bufferline = "multiple";
        completion-timeout = 5;
        preview-completion-insert = true;
        completion-replace = true;

        mouse = true;
        line-number = "relative";
        text-width = 120;
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
        ];

        indent-guides = {
          character = "┊";
          render = false;
          skip-levels = 3;
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

        # whitespace = {
        #   render.space = "all";
        #   render.tab = "all";
        #   render.newline = "all";
        #   characters.space = " ";
        #   characters.nbsp = "⍽";
        #   characters.tab = "→";
        #   characters.newline = "⏎";
        #   characters.tabpad = "-";
        # };

        statusline = {
          left = ["mode" "file-name" "spinner" "read-only-indicator" "file-modification-indicator" "version-control"];
          right = ["diagnostics" "selections" "register" "file-type" "file-line-ending" "position"];
          mode.normal = "";
          mode.insert = "I";
          mode.select = "S";
        };
      };

      keys = rec {
        normal.esc = ["collapse_selection" "keep_primary_selection"];
        insert.esc = ["collapse_selection" "normal_mode"];
        select.esc = ["collapse_selection" "keep_primary_selection" "normal_mode"];
        # normal.j.k = normal.esc;
        insert.j.k = insert.esc;
        # select.j.k = select.esc;

        normal.C-c = normal.esc;
        insert.C-c = insert.esc;
        select.C-c = select.esc;

        normal = {
          space.space = "file_picker";
          # C-h = "select_prev_sibling";
          # C-j = "shrink_selection";
          # C-k = "expand_selection";
          # C-l = "select_next_sibling";

          g.a = "code_action";

          "{" = ["goto_prev_paragraph" "collapse_selection"];
          "}" = ["goto_next_paragraph" "collapse_selection"];

          # C = ["extend_to_line_end" "yank_main_selection_to_clipboard" "delete_selection" "insert_mode"];
          # D = ["extend_to_line_end" "yank_main_selection_to_clipboard" "delete_selection"];
          # X = "extend_line_above";
          V = ["select_mode" "extend_to_line_bounds"];
          G = "goto_file_end";
          H = "extend_to_line_start";
          L = "extend_to_line_end";
          g.q = ":reflow";
          S = "surround_add";

          # Make j and k behave as they do Vim when soft-wrap is enabled
          # j = "move_line_down";
          # k = "move_line_up";

          # "*" = ["move_char_right" "move_prev_word_start" "move_next_word_end" "search_selection" "search_next"];
          # "#" = ["move_char_right" "move_prev_word_start" "move_next_word_end" "search_selection" "search_prev"];

          # x = "delete_selection";

          # p = ["paste_clipboard_after" "collapse_selection"];
          # P = ["paste_clipboard_before" "collapse_selection"];
          # Y = ["extend_to_line_end" "yank_main_selection_to_clipboard" "collapse_selection"];
          i = ["insert_mode" "collapse_selection"];
          a = ["append_mode" "collapse_selection"];

          u = ["undo" "collapse_selection"];
          "0" = "goto_line_start";
          # "$" = "goto_line_end";
          space = {
            # w = ":write";
            q = ":quit";
            l.f = ":format";
            l.r = ":lsp-restart";
            l.g = ":sh gh browse";
          };

          "+" = {
            i = ":pipe aichat -r coder-openai";
            r = ":pipe aichat -r refactor-openai";
            e = [":pipe-to tee /tmp/helix-tmp-explain" ":sh aichat -f /tmp/helix-tmp-explain -r explain-openai"];

            c = ":pipe aichat -r coder-assist";
            t = ":pipe aichat -r refactor-assist";
            y = [":pipe-to tee /tmp/helix-tmp-explain" ":sh aichat -f /tmp/helix-tmp-explain -r explain-assist"];
          };

          #   d = {
          #     d = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "delete_selection"];
          #     t = ["extend_till_char"];
          #     s = ["surround_delete"];
          #     i = ["select_textobject_inner"];
          #     a = ["select_textobject_around"];
          #     j = ["select_mode" "extend_to_line_bounds" "extend_line_below" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
          #     down = ["select_mode" "extend_to_line_bounds" "extend_line_below" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
          #     k = ["select_mode" "extend_to_line_bounds" "extend_line_above" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
          #     up = ["select_mode" "extend_to_line_bounds" "extend_line_above" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
          #     G = ["select_mode" "extend_to_line_bounds" "goto_last_line" "extend_to_line_bounds" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
          #     w = ["move_next_word_start" "yank_main_selection_to_clipboard" "delete_selection"];
          #     W = ["move_next_long_word_start" "yank_main_selection_to_clipboard" "delete_selection"];
          #     g = {
          #       g = ["select_mode" "extend_to_line_bounds" "goto_file_start" "extend_to_line_bounds" "yank_main_selection_to_clipboard" "delete_selection" "normal_mode"];
          #     };
          #   };
          #   y = {
          #     y = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "normal_mode" "collapse_selection"];
          #     j = ["select_mode" "extend_to_line_bounds" "extend_line_below" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     down = ["select_mode" "extend_to_line_bounds" "extend_line_below" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     k = ["select_mode" "extend_to_line_bounds" "extend_line_above" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     up = ["select_mode" "extend_to_line_bounds" "extend_line_above" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     G = ["select_mode" "extend_to_line_bounds" "goto_last_line" "extend_to_line_bounds" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     w = ["move_next_word_start" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     W = ["move_next_long_word_start" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     g = {
          #       g = ["select_mode" "extend_to_line_bounds" "goto_file_start" "extend_to_line_bounds" "yank_main_selection_to_clipboard" "collapse_selection" "normal_mode"];
          #     };
          #   };
        };

        select = {
          "{" = ["extend_to_line_bounds" "goto_prev_paragraph"];
          "}" = ["extend_to_line_bounds" "goto_next_paragraph"];
          "0" = "goto_line_start";
          G = "goto_file_end";
          H = "extend_to_line_start";
          L = "extend_to_line_end";
          # D = ["extend_to_line_bounds" "delete_selection" "normal_mode"];
          # C = ["goto_line_start" "extend_to_line_bounds" "change_selection"];
          S = "surround_add"; # Basically 99% of what I use vim-surround for

          i = "select_textobject_inner";
          a = "select_textobject_around";

          # Clipboards over registers ye ye
          # d = ["yank_main_selection_to_clipboard" "delete_selection"];
          # x = ["yank_main_selection_to_clipboard" "delete_selection"];
          # y = ["yank_main_selection_to_clipboard" "normal_mode" "flip_selections" "collapse_selection"];
          # Y = ["extend_to_line_bounds" "yank_main_selection_to_clipboard" "goto_line_start" "collapse_selection" "normal_mode"];
          # p = "replace_selections_with_clipboard"; # No life without this
          # P = "paste_clipboard_before";

          # tab = ["insert_mode" "collapse_selection"];
          # C-a = ["append_mode" "collapse_selection"];

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

      booberry_mod = {
        inherits = "boo_berry";
        "ui.selection" = {bg = "#7a718a";};
        "ui.background" = {};
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
          models.model1 = {
            type = "open_ai";
            chat_endpoint = "https://openrouter.ai/api/v1/chat/completions";
            model = "aiservice/assist-3.7-sonnet";
            auth_token_env_var_name = "OPENROUTER_API_KEY";
          };
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

      language-server.yaml-language-server.config.yaml.schemas = {
        kubernetes = "k8s/*.yaml";
      };

      language-server.typescript-language-server.config.tsserver = {
        path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
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
          name = "jsx";
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
            args = ["format" "--indent-style" "space" "--stdin-file-path" "file.jsx"];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = ["marksman" "lsp-ai"];
          formatter = {
            command = "prettier";
            args = ["--stdin-filepath" "file.md"];
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
          # formatter = {
          #   command = "sh";
          #   args = ["-c" "ruff check --select I --fix - | ruff format --line-length 88 -"];
          # };
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
