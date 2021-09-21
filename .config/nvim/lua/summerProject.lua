local M = {}

M.myTable = function()
    return { file_ignore_patterns = {"tests/framework"} , search_dirs ={"src", "include", "tests"}}
end

M.f = function()
    return "hi"
end

return M
