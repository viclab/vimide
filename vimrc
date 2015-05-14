set nocompatible                    "关闭vi兼容模式
filetype off                        "关闭文件类型检测

"Vundle插件管理
"安装命令：git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/Vundle.vim   "设置Vundle路径
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'OmniCppComplete'            "自动补全
Plugin 'AutoComplPop'               "自动提示
Plugin 'ccvext.vim'                "自动生成ctags及cscope数据库
Plugin 'molokai'                    "molokai主题
Plugin 'The-NERD-tree'              "NERD目录树
Plugin 'taglist.vim'                "函数变量列表
Plugin 'majutsushi/tagbar'          "显示对象
Plugin 'Raimondi/delimitMate'       "括号补全
call vundle#end()

"主题外观设置
filetype on                         "启用文件类型侦测
colorscheme molokai
syntax on                           "设置语法高亮
set nu                              "设置行号
set cursorline                      "设置行高亮
set cursorcolumn                    "设置列高亮
set laststatus=2                    "启用状态栏信息
set cmdheight=2                     "设置命令行为2行


"缩进与格式设置
filetype plugin on                  "针对不同的文件类型加载对应的插件
filetype plugin indent on           "启用缩进
set smartindent                     "启用智能对齐方式
set expandtab                       "将Tab键转换为空格
set tabstop=4                       "设置Tab键的宽度，可以更改，如：宽度为2
set shiftwidth=4                    "换行时自动缩进宽度，可更改（宽度同tabstop）
set smarttab                        "指定按一次backspace就删除shiftwidth宽度
set scrolloff=4     " 光标移动到buffer的顶部和底部时保持3行距离

set foldenable                                        "启用折叠
set foldmethod=manual                                 "indent 折叠方式
"set foldmethod=indent                                 "indent 折叠方式
"set foldmethod=marker                                "marker 折叠方式
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> "常规模式下用空格键来开关光标行所在折叠（注：zR 展开所有折叠，zM关闭所有折叠）

" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

"撤销与重做
set undolevels=1000         " 设置撤销限度
nnoremap U <C-r>            " 映射 U 替代 <C-r> 

"
"搜索设置
set hlsearch                        "设置高亮搜索
set incsearch                       "设置实时搜索
set ignorecase                      "搜索模式忽略大小写
set smartcase                       "搜索中如果有大写，则恢复大小写敏感

"快捷键设置
map <F9> :NERDTreeToggle<CR>
nmap <F8> :TlistClose<CR>:TagbarToggle<CR>
nmap <F7> :TagbarClose<CR>:Tlist<CR>
map <C-j> <C-W>j  
map <C-k> <C-W>k 
map <C-h> <C-W>h 
map <C-l> <C-W>l 
set pastetoggle=<F2>                "设置F2切换粘贴模式

"特殊属性设置
set clipboard+=unnamed              "共享剪贴板
set showcmd
set autoread
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif    "光标停留上次位置
    "au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)                       "超过80标线
    au BufRead,BufNewFile,BufEnter * cd %:p:h             " 自动切换目录为当前编辑文件所在目录
endif

"设置自动补全
":inoremap ( ()<ESC>i  
":inoremap ) <c-r>=ClosePair(')')<CR>  
:inoremap { {<CR>}<ESC>O
":inoremap } <c-r>=ClosePair('}')<CR>  
":inoremap [ []<ESC>i  
":inoremap ] <c-r>=ClosePair(']')<CR>  
":inoremap " ""<ESC>i  
":inoremap ' ''<ESC>i  
"function! ClosePair(char)  
"    if getline('.')[col('.') - 1]== a:char  
"        return "\<Right>"    
"    else  
"        return a:char  
"    endif  
"endfunction


"OmniCppComplete补全设置
"ctags -R –c++-kinds=+p –fields=+iaS –extra=+q
set tags+=./tags
set completeopt=menu,menuone  
let OmniCpp_MayCompleteDot=1            "  打开  . 操作符
let OmniCpp_MayCompleteArrow=1          "打开 -> 操作符
let OmniCpp_MayCompleteScope=1          "打开 :: 操作符
let OmniCpp_NamespaceSearch=1           "打开命名空间
let OmniCpp_GlobalScopeSearch=1  
let OmniCpp_DefaultNamespace=["std"]  
let OmniCpp_ShowPrototypeInAbbr=1       "打开显示函数原型
let OmniCpp_SelectFirstItem = 2         "自动弹出时自动跳至第一个


"Tagbar插件配置
let g:tagbar_width=30                       "设置窗口宽度
let g:tagbar_right=1                         "在右侧窗口中显示

"Tlist
let Tlist_Show_One_File=1                   "只显示当前文件的tags
let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
let Tlist_Exit_OnlyWindow=1
"如果Taglist窗口是最后一个窗口则退出Vim
let Tlist_File_Fold_Auto_Close=1            "自动折叠
let Tlist_WinWidth=30                       "设置窗口宽度
let Tlist_Use_Right_Window=1                "在右侧窗口中显示

" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
"-----------------------------------------------------------------------------
" 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
if has("cscope")
    "设定可以使用 quickfix 窗口来查看 cscope 结果
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set cscopetag
    "如果你想反向搜索顺序设置为1
    set csto=0
    "在当前目录中添加任何数据库
    if filereadable("cscope.out")
        cs add cscope.out
        "否则添加数据库环境中所指出的
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "cscope快捷键设置
    nmap ,s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap ,g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap ,c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap ,t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap ,e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap ,f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap ,i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap ,d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap . <C-T>
endif
