require("mini.deps").add({
	source = "numToStr/Comment.nvim",
	depends = {
		{
			source = "JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
})

require("ts_context_commentstring").setup({
	enable_autocmd = false,
})

require("Comment").setup({
	toggler = {
		block = "gbb",
	},
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
