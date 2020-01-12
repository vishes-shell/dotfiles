lua require'nvim_lsp'.pyls.setup{
\    settings = {
\        pyls = {
\            configurationSources = {};
\            plugins = {
\                mccabe = {enabled = false};
\                preload = {enabled = false};
\                pycodestyle = {enabled = false};
\                pydocstyle = {enabled = false};
\                pyflakes = {enabled = false};
\                pylint = {enabled = false};
\                yapf = {enabled = false};
\            }
\        }
\    }
\}
set omnifunc=lms#omnifunc
