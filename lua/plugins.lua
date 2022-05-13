local packer = require('packer')

packer.startup(
{
  function(use)
    --Packer 自身
    use ("wbthomason/packer.nvim")
    --------- colorschemes -------------------------
    -- tokyonight
    use("folke/tokyonight.nvim")
    -- OceanicNext
    use("mhartington/oceanic-next")
    -- gruvbox
    use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
    -- zephyr 暂时不推荐，详见上边解释
    -- use("glepnir/zephyr-nvim")
    -- nord
    use("shaunsingh/nord.nvim")
    -- onedark
    use("ful1e5/onedark.nvim")
    -- nightfox
    use("EdenEast/nightfox.nvim")
    ------------------------------------------------
    -- nvim-tree
    use({"kyazdani42/nvim-tree.lua",requires = "kyazdani42/nvim-web-devicons"})
    -- bufferline
    use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
    -- lualine
    use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
    use("arkav/lualine-lsp-progress")
    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    -----------------------------LSP---------------------------------------------
    use({ "williamboman/nvim-lsp-installer", commit = "36b44679f7cc73968dbb3b09246798a19f7c14e0" })
    use("mfussenegger/nvim-jdtls")
    -- Lspconfig
    use({ "neovim/nvim-lspconfig" })
    -- telescope （新增）
    use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
     -- dashboard-nvim (新增)
    use("glepnir/dashboard-nvim")
    -- project
    use("ahmedkhalf/project.nvim")
  end,
  config = {
    max_jobs = 16,
    -- 自定义插件源，github网站无法访问可以使用
    git = {
          --  default_url_format = "https://hub.fastgit.xyz/%s",
          --  default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
          --  default_url_format = "https://gitcode.net/mirrors/%s",
          --  default_url_format = "https://gitclone.com/github.com/%s"
    },
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    }
  }
}
)


-- 每次保存plugin.lua 文件自动安装插件
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
