{
  programs.nixvim.plugins = {
    bufferline.enable = true;
    web-devicons.enable = true;

    telescope.enable = true;
    oil.enable = true;
    treesitter.enable = true;
    luasnip.enable = true;
    lualine.enable = true;
    typescript-tools.enable = true;

    cmp = {
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
      ];

      luaConfig.post = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<Tab>" = {
          action = ''
            function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
                elseif luasnip.expandable() then
                luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                elseif check_backspace() then
                fallback()
            else
              fallback()
                end
                end
                '';
          modes = [ "i" "s" ];
        };
      };
    };

    lsp = {
      enable = true;
      servers = {
        ts_ls.enable = true;
        lua_ls.enable = true;
      };
    };
  };
}
