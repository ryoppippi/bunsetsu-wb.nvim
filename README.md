# Bunsetsu-wb.nvim

*これは[vim駅伝](https://vim-jp.org/ekiden/)3/6の* ***記事*** *です*

![screen](https://user-images.githubusercontent.com/1560508/222988065-3ac14333-2b7d-4380-b258-d78303516d71.gif)


Bunsetsu-wb.nvimは[Bunsetsu.vim](https://github.com/ryoppippi/bunsetsu.vim)を`w`,`e`,`b`と自然に使うためのインテグレーションプラグインです。


## 必須条件
- [Bunsetsu.vim](https://github.com/ryoppippi/bunsetsu.vim)
- [Denops.vim](https://github.com/vim-denops/denops.vim)
- [mini.ai](https://github.com/echasnovski/mini.ai)
- [uga-rosa/utf8.nvim](https://github.com/uga-rosa/utf8.nvim)

## Configuration Exapmle

``` lua

return {
  "ryoppippi/bunsetsu-wb.nvim",
  dependencies = {
    { "ryoppippi/bunsetsu.vim" },
    { "vim-denops/denops.vim" },
    { "yuki-yano/denops-lazy.nvim" },
    { "echasnovski/mini.ai", version = "*" },
    { "uga-rosa/utf8.nvim" }
  },
  keys = {
    { "w", function() require("bunsetsu_wb").w() end, { "n", "v" }},
    { "b", function() require("bunsetsu_wb").b() end, { "n", "v" }},
    -- { "e", function() require("bunsetsu_wb").e() end, { "n", "v" }},
  },
  init = function()
    require("mini.ai").setup({
      custom_textobjects = {
        ["w"] = function()
          local CWORD = require("bunsetsu_wb").getCWORD()
          local line = vim.fn.line(".")
          return { from = { line = line, col = CWORD.col }, to = { line = line, col = CWORD.colend } }
        end,
      },
    })
  end,
}
```

## TODO
- eが動かないので修正
- Vimscript版の実装
- テストの実装
- ドキュメントの充実

## License

MIT

## Author

Ryotaro "Justin" Kimura (a.k.a. ryoppippi)

