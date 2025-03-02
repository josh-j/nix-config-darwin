{ pkgs, ... }: {
  programs.helix = with pkgs; {
    enable = true;
    defaultEditor = true;
    # package = pkgs.unstable.evil-helix;
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
      theme = "flatwhite";

      editor = {
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";
        # mouse = false; # macos fix / terminal conflicts


        soft-wrap.enable = true;

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
          ignore = false;
        };

        indent-guides = {
          character = "┊";
          render = true;
          skip-levels = 1;
        };

        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };

        statusline = {
          left = [ "mode" "file-name" "spinner" "read-only-indicator" "file-modification-indicator" ];
          right = [ "diagnostics" "selections" "register" "file-type" "file-line-ending" "position" ];
          mode.normal = "";
          mode.insert = "I";
          mode.select = "S";
        };
      };
    };

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
        "ui.background" = { };
      };
    };

    languages = {
      language-server.biome = {
        command = "biome";
        args = [ "lsp-proxy" ];
      };

      language-server.lsp-ai = {
        command = "lsp-ai";
        config = {
          memory.file_store = { };
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
              model = "model2";
              parameters = {
                max_context = 4096;
                max_tokens = 1024;
                system = "You are a helpful assistant.";
              };
            }
          ];
        };
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

      language = [
        {
          name = "css";
          language-servers = [ "vscode-css-language-server" "lsp-ai" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.css" ];
          };
          auto-format = true;
        }
        {
          name = "go";
          language-servers = [ "gopls" "golangci-lint-lsp" "lsp-ai" ];
          formatter = {
            command = "goimports";
          };
          auto-format = true;
        }
        {
          name = "html";
          language-servers = [ "vscode-html-language-server" "lsp-ai" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.html" ];
          };
          auto-format = true;
        }
        {
          name = "javascript";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "lsp-ai"
          ];
          auto-format = true;
        }
        {
          name = "json";
          language-servers = [
            { name = "vscode-json-language-server"; except-features = [ "format" ]; }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.json" ];
          };
          auto-format = true;
        }
        {
          name = "jsonc";
          language-servers = [
            { name = "vscode-json-language-server"; except-features = [ "format" ]; }
            "biome"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.jsonc" ];
          };
          file-types = [ "jsonc" "hujson" ];
          auto-format = true;
        }
        {
          name = "jsx";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "lsp-ai"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.jsx" ];
          };
          auto-format = true;
        }
        {
          name = "markdown";
          language-servers = [ "marksman" "lsp-ai" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.md" ];
          };
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = [ "nixd" ];
          formatter.command = "${pkgs.alejandra}/bin/alejandra";
          auto-format = true;
        }
        {
          name = "python";
          language-servers = [ "pylsp" "lsp-ai" ];
          formatter = {
            command = "sh";
            args = [ "-c" "ruff check --select I --fix - | ruff format --line-length 88 -" ];
          };
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" "lsp-ai" ];
          auto-format = true;
        }
        {
          name = "scss";
          language-servers = [ "vscode-css-language-server" "lsp-ai" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.scss" ];
          };
          auto-format = true;
        }
        {
          name = "sql";
          language-servers = [ "lsp-ai" ];
          formatter = {
            command = "sql-formatter";
            args = [ "-l" "postgresql" "-c" "{\"keywordCase\": \"lower\", \"dataTypeCase\": \"lower\", \"functionCase\": \"lower\", \"expressionWidth\": 120, \"tabWidth\": 4}" ];
          };
          auto-format = true;
        }
        {
          name = "toml";
          language-servers = [ "taplo" ];
          formatter = {
            command = "taplo";
            args = [ "fmt" "-o" "column_width=120" "-" ];
          };
          auto-format = true;
        }
        {
          name = "tsx";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "lsp-ai"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.tsx" ];
          };
          auto-format = true;
        }
        {
          name = "typescript";
          language-servers = [
            { name = "typescript-language-server"; except-features = [ "format" ]; }
            "biome"
            "lsp-ai"
          ];
          formatter = {
            command = "biome";
            args = [ "format" "--indent-style" "space" "--stdin-file-path" "file.ts" ];
          };
          auto-format = true;
        }
        {
          name = "yaml";
          language-servers = [ "yaml-language-server" ];
          formatter = {
            command = "prettier";
            args = [ "--stdin-filepath" "file.yaml" ];
          };
          auto-format = true;
        }
      ];
    };
  };
}
