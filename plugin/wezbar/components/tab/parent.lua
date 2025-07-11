local parent = ""

return {
  default_opts = { max_length = 10 },
  update = function(tab, opts)
    local cwd_uri = tab.active_pane.current_working_dir
    if cwd_uri then
      local file_path = cwd_uri.file_path
      -- Replace backslashes with forward slashes for consistency
      file_path = file_path:gsub("\\", "/")
      -- Remove any leading and trailing slashes
      file_path = file_path:match("^/*(.-)/*$")
      parent = file_path:match("([^/]*)/[^/]*$")
      if parent and #parent > opts.max_length then
        parent = parent:sub(1, opts.max_length - 1) .. "…"
      end
    end
    return parent or ""
  end,
}
