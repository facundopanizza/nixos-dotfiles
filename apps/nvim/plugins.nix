{
  programs.nixvim.plugins = {
    bufferline.enable = true;
    web-devicons.enable = true;
   
    telescope.enable = true;
    oil.enable = true;
    treesitter.enable = true;
    luasnip.enable = true;
    lualine.enable = true;
   
    lsp = {
      enable = true;
      servers = {
        ts_ls.enable = true;
        lua_ls.enable = true;
      };
    };
   
    cmp = {
      enable = true;
      autoEnableSources = true;
    };
  };
}
