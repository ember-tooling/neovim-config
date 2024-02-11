" Generic / Global editor settings
syntax on
set encoding=utf-8
set cmdheight=1      " under statusline messages

set mouse=a          " use mouse for everything
set showmode         " show the current mode (Insert, Visual...)
set laststatus=2     " Always display status line

set cursorline       " highlight current line
set cursorcolumn     " highlight the current columnm

set ruler            " show current position

set number           " line numbers
set backspace=indent,eol,start  " backspace everywhere

" Default indentation - editorconfig should override these
set tabstop=2
set shiftwidth=2
set expandtab
set linebreak " breaks lines on words instead of in the middle of a word
set breakindent " wrapping of lines is indented
let &showbreak='⇢ ' " the wrapped part of a line is indented a bit

set hlsearch  " highlight search terms
set list      " show whitespace

" set whitespace chars - everything
" set listchars=eol:¬,tab:>·,extends:>,precedes:<,space:·
" set whitespace chars - minimal
set listchars=eol:¬,extends:>,precedes:<,tab:\ \

set autoread   " Autoload reload files when they have changed on the disk

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Scrolling
set scrolloff=3  " minimum lines to keep above and below cursor

" Backup and Temp
silent !mkdir ~/.local/share/nvim/_backup/ > /dev/null 2>&1
silent !mkdir ~/.local/share/nvim/_temp/ > /dev/null 2>&1
silent !mkdir ~/.local/share/nvim/_undo/ > /dev/null 2>&1
silent !mkdir ~/.local/share/nvim/spell/ > /dev/null 2>&1

set backupdir=~/.local/share/nvim/_backup/    " where to put backup files.
set directory=~/.local/share/nvim/_temp/      " where to put swap files.
" Disable swap as it has never been useful to me
set noswapfile

" allow undo history to persist after closing buffer
if has('persistent_undo')
  set undodir=~/.local/share/nvim/_undo
  set undofile
end

"" set the title of the window to the filename
set title
set titlestring=%f%(\ [%M]%)
