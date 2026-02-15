local M = {}

local function get_relative_path()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath == "" then
    return nil
  end
  return vim.fn.fnamemodify(filepath, ":~:." )
end

local function get_language()
  if vim.treesitter.language.get_lang then
    local filetype = vim.bo.filetype
    local lang = vim.treesitter.language.get_lang(filetype)
    if lang and lang ~= "" then
      return lang
    end
  end

  local ok, parser = pcall(vim.treesitter.get_parser, 0)
  if ok and parser then
    local lang = parser:lang()
    if lang and lang ~= "" then
      return lang
    end
  end

  return ""
end

local function format_code_block(relative_path, start_line, end_line, code, language)
  local line_range = start_line == end_line and tostring(start_line) or start_line .. "-" .. end_line
  local lang_tag = language ~= "" and language or ""

  return string.format("%s:%s\n```%s\n%s\n```", relative_path, line_range, lang_tag, code)
end

function M.copy_normal_mode()
  local relative_path = get_relative_path()

  if not relative_path then
    vim.notify("Cannot copy: buffer has no file", vim.log.levels.WARN)
    return
  end

  local line = vim.fn.line(".")
  local lines = vim.api.nvim_buf_get_lines(0, line - 1, line, false)
  local code = table.concat(lines, "\n")
  local language = get_language()

  local formatted = format_code_block(relative_path, line, line, code, language)
  vim.fn.setreg("+", formatted)

  vim.notify("Copied 1 line with context", vim.log.levels.INFO)
end

function M.copy_visual_mode()
  local relative_path = get_relative_path()

  if not relative_path then
    vim.notify("Cannot copy: buffer has no file", vim.log.levels.WARN)
    return
  end

  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  if start_line == end_line then
    lines[1] = string.sub(lines[1], start_col, end_col)
  else
    lines[1] = string.sub(lines[1], start_col)
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
  end

  local code = table.concat(lines, "\n")
  local language = get_language()

  local formatted = format_code_block(relative_path, start_line, end_line, code, language)
  vim.fn.setreg("+", formatted)

  local line_count = end_line - start_line + 1
  local plural = line_count == 1 and "line" or "lines"
  vim.notify(string.format("Copied %d %s with context", line_count, plural), vim.log.levels.INFO)
end

function M.copy_visual_line_mode()
  local relative_path = get_relative_path()

  if not relative_path then
    vim.notify("Cannot copy: buffer has no file", vim.log.levels.WARN)
    return
  end

  local start_line = vim.fn.getpos("'<")[2]
  local end_line = vim.fn.getpos("'>")[2]

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local code = table.concat(lines, "\n")
  local language = get_language()

  local formatted = format_code_block(relative_path, start_line, end_line, code, language)
  vim.fn.setreg("+", formatted)

  local line_count = end_line - start_line + 1
  local plural = line_count == 1 and "line" or "lines"
  vim.notify(string.format("Copied %d %s with context", line_count, plural), vim.log.levels.INFO)
end

function M.setup()
  require("emiliosheinz.custom.copy-with-context.keymap")
end

return M
