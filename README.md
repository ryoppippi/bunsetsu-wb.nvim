# Bunsetsu-wb.nvim

Bunsetsu-wb.nvimは[Bunsetsu.vim](https://github.com/ryoppippi/bunsetsu.vim)を`w`,`e`,`b`と自然に使うためのインテグレーションプラグインです。


## 必須条件
- [Bunsetsu.vim](https://github.com/ryoppippi/bunsetsu.vim)
- [Denops.vim](https://github.com/vim-denops/denops.vim)
- [mini.ai](https://github.com/echasnovski/mini.ai)

## Configuration Exapmle

``` lua

return {
  "ryoppippi/bunsetsu-wb.nvim",
  dependencies = {
    { "ryoppippi/bunsetsu.vim" },
    { "vim-denops/denops.vim" },
    { "yuki-yano/denops-lazy.nvim" },
    { "echasnovski/mini.ai", version = "*" },
  },
  keys = {
    { "w", function() require("bunsetsu_wb").w() end, { "n", "v" }},
    { "e", function() require("bunsetsu_wb").e() end, { "n", "v" }},
    { "b", function() require("bunsetsu_wb").b() end, { "n", "v" }},
  },
  init = function()
    require("mini.ai").setup({
      custom_textobjects = {
        ["w"] = function()
          local CWORD = require("bunsetsu_wb").getCWORD()
          return { from = CWORD.col, to = CWORD.colend }
        end,
      },
    })
  end,
}
```

## TODO
- Vimscript版の実装
- テストの実装
- ドキュメントの充実

## License

MIT

## Author

Ryotaro "Justin" Kimura (a.k.a. ryoppippi)

