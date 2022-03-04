local packer = require("packer")
-- 配置github 国内镜像
packer.init(
{
    git = {
    cmd = 'git', -- The base command for git operations
    subcommands = { -- Format strings for git subcommands
      update         = 'pull --ff-only --progress --rebase=false',
      install        = 'clone --depth %i --no-single-branch --progress',
      fetch          = 'fetch --depth 999999 --progress',
      checkout       = 'checkout %s --',
      update_branch  = 'merge --ff-only @{u}',
      current_branch = 'branch --show-current',
      diff           = 'log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
      diff_fmt       = '%%h %%s (%%cr)',
      get_rev        = 'rev-parse --short HEAD',
      get_msg        = 'log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
      submodules     = 'submodule update --init --recursive --progress'
    },
    depth = 1, -- Git clone depth
    clone_timeout = 60, -- Timeout, in seconds, for git clones
    default_url_format = 'https://hub.xn--gzu630h.xn--kpry57d/%s' -- Lua format string used for "aaa/bbb" style plugins
  }
}
)
packer.startup(
    {
        -- 所有插件的安装都书写在 function 中
        function()
            -- 包管理器
            use {
                "wbthomason/packer.nvim"
            }
            -- 中文文档
	    use {
		'yianwillis/vimcdoc'
	    }
	    -- nvim-tree
	    use {
		"kyazdani42/nvim-tree.lua",
                 requires = {
                   -- 依赖一个图标插件
                   "kyazdani42/nvim-web-devicons"
                 },
                 config = function()
                   -- 插件加载完成后自动运行 lua/conf/nvim-tree.lua 文件中的代码
                   require("conf.nvim-tree")
                 end
	    }
         -- 支持 LSP 状态的 buffer 栏
            use {
                "akinsho/bufferline.nvim",
                 requires = {
                     "famiu/bufdelete.nvim" -- 删除 buffer 时不影响现有布局
                   },
                config = function()
                  require("conf.bufferline")
                end
            }
	 -- 暗色主题
	 use{
            "catppuccin/nvim",
             -- 改个别名，因为它的名字是 nvim，可能会冲突
             as = "catppuccin",
             config = function()
               -- 插件加载完成后自动运行 lua/conf/catppuccin.lua 文件中的代码
               require("conf.catppuccin")
             end
	 }
	-- 炫酷的状态栏插件
         use {
             "windwp/windline.nvim",
              config = function()
                -- 插件加载完成后自动运行 lua/conf/windline.lua 文件中的代码
                require("conf.windline")
              end
         }
	-- 搜索时显示条目
        use {
              "kevinhwang91/nvim-hlslens",
               config = function()
                 require("conf.nvim-hlslens")
              end
            }
	-- 显示缩进线
        use {
              "lukas-reineke/indent-blankline.nvim",
               config = function()
                 require("conf.indent-blankline")
               end
            }
	-- 自动匹配括号
        use {
             "windwp/nvim-autopairs",
              config = function()
                require("conf.nvim-autopairs")
              end
            }
	-- 内置终端
	use {
              "akinsho/toggleterm.nvim",
              config = function()
                require("conf.toggleterm")
              end
            }
        -- 模糊查找
	use {
             "nvim-telescope/telescope.nvim",
              requires = {
                 "nvim-lua/plenary.nvim", -- Lua 开发模块
                 "BurntSushi/ripgrep", -- 文字查找
                  "sharkdp/fd" -- 文件查找
                },
              config = function()
                 require("conf.telescope")
              end
             }
           -- 精美弹窗
           use {
                "rcarriga/nvim-notify",
                 config = function()
                   require("conf.nvim-notify")
                 end
            }
	-- todo tree
        use {
              "folke/todo-comments.nvim",
              config = function()
                require("conf.todo-comments")
              end
            }
	-- LSP 基础服务
        use {
             "neovim/nvim-lspconfig",
              config = function()
               require("conf.nvim-lspconfig")
             end
            }
       -- 自动安装 LSP
       use {
            "williamboman/nvim-lsp-installer",
             config = function()
               require("conf.nvim-lsp-installer")
             end
           }
       -- LSP UI 美化
       use {
            "tami5/lspsaga.nvim",
             config = function()
               require("conf.lspsaga")
             end
           }
       -- LSP 进度提示
          
	use {
             "j-hui/fidget.nvim",
             config = function()
               require("conf.fidget")
             end
            }
	-- 插入模式获得函数签名
        use {
             "ray-x/lsp_signature.nvim",
             config = function()
                require("conf.lsp_signature")
             end
            }
        -- 灯泡提示代码行为
        use {
             "kosayoda/nvim-lightbulb",
              config = function()
               require("conf.nvim-lightbulb")
              end
            }
	-- 自动代码补全系列插件
        use {
             "hrsh7th/nvim-cmp",  -- 代码补全核心插件，下面都是增强补全的体验插件
              requires = {
                    {"onsails/lspkind-nvim"}, -- 为补全添加类似 vscode 的图标
                    {"hrsh7th/vim-vsnip"}, -- vsnip 引擎，用于获得代码片段支持
                    {"hrsh7th/cmp-vsnip"}, -- 适用于 vsnip 的代码片段源
                    {"hrsh7th/cmp-nvim-lsp"}, -- 替换内置 omnifunc，获得更多补全
                    {"hrsh7th/cmp-path"}, -- 路径补全
                    {"hrsh7th/cmp-buffer"}, -- 缓冲区补全
                    {"hrsh7th/cmp-cmdline"}, -- 命令补全
                    {"f3fora/cmp-spell"}, -- 拼写建议
                    {"rafamadriz/friendly-snippets"}, -- 提供多种语言的代码片段
                    {"lukas-reineke/cmp-under-comparator"}, -- 让补全结果的排序更加智能
                    {"tzachar/cmp-tabnine", run = "./install.sh"} -- tabnine 源,提供基于 AI 的智能补全
                 },
              config = function()
                 require("conf.nvim-cmp")
              end
            }
	    -- git copilot 自动补全
             use {
                  "github/copilot.vim",
                  config = function()
                   require("conf.copilot")
                  end
             }
        -- nvim-jdtls
        use{
            "mfussenegger/nvim-jdtls"
        }
        -- 语法高亮
        use{
            "nvim-treesitter/nvim-treesitter",
            run = {":TSupdate"},
            requires = {
                -- 彩虹括号
                "p00f/nvim-ts-rainbow"
            },
            config = function()
                require("conf.nvim-treesitter")
            end
        }
        -- 代码注释
        use {
            "numToStr/Comment.nvim",
            requires = {
                "JoosepAlviste/nvim-ts-context-commentstring"
            },
            config = function()
                require("conf.Comment")
            end
        }
        -- 代码格式化
        use {
             "sbdchd/neoformat",
              config = function()
                 require("conf.neoformat")
              end
        }
        -- lsp color
        use {
            "folke/lsp-colors.nvim",
             config = function()
               require("conf.lsp-colors")
             end
        }
        -- 大纲
        use {
            "liuchengxu/vista.vim",
             config = function()
               require("conf.vista")
             end
        }
        -- 代码调试基础插件
        use {
            "mfussenegger/nvim-dap",
             config = function()
               require("conf.nvim-dap")
             end
            }
                                              
        -- 为代码调试提供内联文本
        use {
            "theHamsta/nvim-dap-virtual-text",
             requires = {
                "mfussenegger/nvim-dap"
            },
             config = function()
               require("conf.nvim-dap-virtual-text")
             end
            }
                                              
         -- 为代码调试提供 UI 界面
        use {
             "rcarriga/nvim-dap-ui",
              requires = {
               "mfussenegger/nvim-dap"
              },
              config = function()
                require("conf.nvim-dap-ui")
              end
            }
end,
        -- 使用浮动窗口
        config = {
            display = {
                open_fn = require("packer.util").float
            }
        }
    }
)
-- 实时生效配置
vim.cmd(
    [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]
)
