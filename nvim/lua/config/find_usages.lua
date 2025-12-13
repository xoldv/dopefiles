local M = {}

function M.delete_if_unused()
	local params = vim.lsp.util.make_position_params()
	params.context = { includeDeclaration = true }

	vim.lsp.buf_request(0, "textDocument/references", params, function(err, result)
		if err then
			vim.notify("LSP error: " .. err.message, vim.log.levels.ERROR)
			return
		end

		if not result or #result == 1 then
			vim.api.nvim_command("normal! d}")
			vim.notify("Removed unused variable", vim.log.levels.INFO)
		else
			vim.notify("Uses: " .. #result, vim.log.levels.INFO)
		end
	end)
end

return M
