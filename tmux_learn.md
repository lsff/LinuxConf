# Tmux 学习札记
详细内容: man tmux
tmux的功能就是可以在1个终端窗口(比如ubuntu下的xterminal)开多个pseudo termial(正常情况下1个终端会话);
tmux有几个概念：*server*; *session*; *window*; *pane*; *client*。理解区分这些概念有利于对tmux命令的掌握。

* server : 无论运行多少次tmux，server对象只有1个，直系下属对象是session，管理所有sessions, 第1个session创建的时候就会创建server对象。
* session : 直接运行tmux就会创建1个session， 也可以通过tmux attach来“登录”到已有的session, session管理window，我觉得一般1个session就够了，暂时没遇到要用多个session的情景。
* window : pseudo terminal的代理对象，可以简单理解tmux运行时终端的当前窗口(占满整个当前终端)就是1个window，1个window可以分割为多个pane。
* pane : 当前终端窗口的1个分割区域(这里用窗口回和window混淆)，pane这个分割区域基本和1个单独终端(非tmux模式)一样。
* client : 这个不是tmux的内部对象，是对系统终端窗口(x-terminal...)的成语，1个client可以与1个session相关联，多个client还能和同个session关联，效果就是有个'闹鬼'的终端在输出。

## 命令
tmux的命令有两种执行方式：1,快捷键，也是最常用的; 2,命令模式，也要先通过快捷键进入命令模式;
快捷键方式:<prefix><command>(先按下<prefix>的快捷键，再按下<command>的), 下面介绍命令的时候会忽略<prefix>, 直接介绍command的快捷键，这些快捷键都是可配置，我觉得除非有天大理由，否则按默认就好(约定优于配置哈)
<prefix> : C-b [ Ctrl-b ]
按命令的对象分类：session, window, pane分类, 下面的记录就按照命令的对象分类。
记录的格式: 命令名(默认快捷键映射) : 命令解析。(命令名可用于自定义映射)

## session
suspend-client		[ C-z ]		"挂起当前会话，会退出tmux模式，回到系统terminal，可通过tmux attach返回;"
detach-client		[ d ]		"detach 当前session，看起来效果和suspent-client，目前没发现差异之处;"
rename-session		[ $ ]		"重命名当前session, 状态栏第1个[]显示的,可用于tmux attach -t [session name]来链接到特定的session;"
switch-client -p	[ ( ]		"选中前1个session;"
switch-client -n	[ ) ]		"选中后1个session;"
choose-client		[ D ]		"通过列表选中session进行链接;"
switch-client -l	[ L ]		"选中上1个激活的session;"
refresh-client		[ r ]		"刷新终端;"
choose-tree			[ s ]		"选择session进行attach;"


## window
split-window -v		[ " ]		"把当前window分成上下pane;"
split-window -h		[ % ]		"把当前window分成左右pane;"
kill-window			[ & ]		"关闭当前window;"
select-window -t	[ ' ]		"可通过输入window的索引来选中window, 索引从0开始;"
rename-window		[ , ]		"重命名当前窗口"
move-window -t		[ . ]		"改变当前window的索引，window的位置会根据索引的顺序进行调整;"
select-window -t	[0~9]		"选中相应索引的window(0~9);"
new-window			[ c ]		"新建window;"
find-window			[ f ]		"在所有windows中匹配字符串;"
display-message		[ i ]		"在状态栏显示当前window的信息;"
last-window			[ l ]		"移动到上1个激活window;"
next-window			[ n ]		"移动到下1个window;"
choose-window		[ w ]		"通过窗口列表选择当前窗口;"


## pane
rotate-window		[ C-o ]		"当前window的panes向前移动，所以效果就是pane与后1个pane进行置换;"
rotate-window -D	[ M-o ]		"与rotate-window的方向相反;"
select-pane(-t +)	[ o ]		"选中当前window的前1个pane, 类似C-o;"
break-pane			[ ! ]		"把当前window的当前pane移除，成为独立的window;"
last-pane			[ ; ]		"移动到当前window的上1个激活pane;"
display-panes		[ q ]		"显示当前窗口所有pane的index,方便选择;"
select-pane -m		[ m ]		"mark 当前pane, 窗口标签会多个M标志,pane的边框也会高亮,不知其他用途;"
select-pane -M		[ M ]		"清除mark;"
kill-pane			[ x ]		"关闭当前pane,会有确认提示;"
resize-pane -Z		[ z ]		"切换当前window的当前pane是否占满整个window, 占满屏幕是窗口标志会有Z标志;" 
swap-pane -U		[ { ]		"把当前的pane与前1个pane互换;"
swap-pane -D		[ { ]		"把当前的pane与后1个pane互换;"
select-pane -U		[ UP ]		"选中当前pane的上方pane;"
select-pane -D		[ DOWN ]	"选中当前pane的下方pane;"
select-pane -L		[ LEFT ]	"选中当前pane的左方pane;"
select-pane -R		[ RIGHT ]	"选中当前pane的右方pane;"
select-layout even-horizontal	[ M-1 ]	"按照水平方向排列当前window的panes;"
select-layout even-vertical		[ M-2 ]	"按照垂直方向排列当前window的panes;"
select-layout main-horizontal	[ M-3 ]	"第1个pane与其他panes垂直排列，其他pane按水平排列;"
select-layout main-vertical		[ M-4 ]	"第1个pane与其他panes水平排列，其他pane按垂直排列;"
select-layout tailed			[ M-5 ]	"所有panes平分window;"
next-layout			[ space ]	"设置为下一个layout;"
resize-pane -U/D/L/R 5	[ M-Up/Down/Left/Right ]	"以5cells的步长调整当前pane的大小;"
resize-pane -U/D/L/R 	[ C-Up/Down/Left/Right ]	"微调当前pane的大小;"


## buffers
list-buffers		[ # ]		"列出当前粘帖板的数据;"
delete-buffer		[ - ]		"删除buffer里面的数据;"
choose-buffer		[ = ]		"选择buffer里面的数据进行粘帖;"


## others
command-prompt		[ : ]		"进入command mode;"
list-keys			[ ? ]		"列出所有命令快捷键设置;"
clock-mode			[ t	]		"在当前pane显示时间;"

## copy/paste mode


# 进阶篇
上一篇讲的命令其实都是tmux Command(我觉得译为函数比较程序猿一点)子集里面且命令参数为一些默认的值,类似调整pane的5步和1步就是同个命令不同参数。之前说的命令的对象(session, client, window, pane)也可以认为是命令的参数，以下成为target-param。

target-param分为:
* target-client
* target-session
* target-window
* target-pane

## target-session表示方法
* $[session-id]
* session名字(可以通过list-sessions看到)
* session名字的前缀(比如：mysess For mysession)
* 能匹配到session名字的正则

## target-window表示方法 target-window由两部分组成: session:window (session就是target-session的表达, window的表示方法如下)
* window的索引 PS: window的索引可以通过move-window (.命令)来修改;
* @[window-ID] PS: window的ID是1个递增的数值，每新建1个window就会加1(不回收关闭窗口的ID哦), 且ID是不可改变的,可以通过list-windows看出来
* window名字
* window名字的前缀(比如：mywin For mywindow)
* 能匹配到window名字的正则

window除了以上正规的表示手法，内置还有一些特定的表达式(token)用于特指一些window, 这些表达式(token)也可以用单个的字符(single-character)代替。
```
token(表达式) | single-character(单字符) | mean(含义)
--------------|--------------------------|-------------------
{start}       |^                         |索引最小的window
{end}         |$                         |索引最大的window
{last}        |!                         |上1个激活的window
{next}        |+                         |索引值前1个的window
{previous}    |-                         |索引值后1个的window
```

## target-pane表示方法 pane对象可以用ID来表示或者target-window.ID的形式表示,比如:mySession:myWindow.1, 如果ID值省略，就默认为当前的pane
pane和window一样，也有一些内置的表达式
```
token(表达式) | single-character(单字符) | mean(含义)
--------------|--------------------------|-------------------
{last}        |!                         |上1个激活的pane
{next}        |+                         |索引值前1个的pane
{previous}    |-                         |索引值后1个的pane
{top}         |                          |顶端的pane
{bottom}      |                          |底端的pane
{left}        |                          |最左端的pane
{right}       |                          |最右端的pane
{right}       |                          |最右端的pane
{top-left}    |                          |左上角的pane
{top-right}   |                          |右上角的pane
{bottom-left} |                          |左下角的pane
{bottom-right}|                          |右下角的pane
{up-of}       |                          |当前pane的上面
{down-of}     |                          |当前pane的下面
{left-of}     |                          |当前pane的左面
{right-of}    |                          |当前pane的右面
{marked}      |                          |select-pane -m标记的pane
```

## ID
Session, Window, Pane这些对象都会分配1个和Session生命周期一样的ID(Session结束前无法更改), $ID表示Session, @ID表示Window, %ID表示pane;

## shell-command作为命名参数
shell-command也可以作为tmux Command的参数, 作用就相当于 sh -c shell-command 一样。
示例: 
new-window  'vim /etc/passwd' 
会执行:
/bin/sh -c 'vim /etc/passwd'


## $tmux [commands] 运行tmux进程的时候可以把tmux的command作为参数
[commands]支持多命令，命令之间用;隔开

# Key-Binding  快捷键映射
tmux和Vi一样，也有多种mode: edit，copy, choise (根据vi和emacs又可以分为: vi-edit, emacs-edit, vi-copy, emacs-copy, vi-choice, emacs-choice ), 外加个Normal吧。

## bind-key 
bind-key [-cnr] [-t mode-table] [-T key-table] key command [arguments]
作用: 把 command 映射到 key。其他都是参数
-t mode-table : 限定这个映射是在那个mode(vi-edit, emacs-edit, vi-copy, emacs-copy, vi-choice, emacs-choice)
-T key-table : key-table可以认为tmux区分不同映射的类型，相同类型的映射key就在同一个key-table里面, 之前说的带前缀<prefix>就是1类(key-table值为prefix)，这么说，还可以不带前缀的？对，不带前缀的就是root的key-table，不过tmux不建议设置这种映射。
-n 是 -T root 的简写形式
-c 是 -t mode为normal值
-r 表示映射键可能会多按击，与repeat-time项相关

## unbind-key 
unbind-key [-acn] [-t mode-table] [-T key-table] key
作用: 接触快捷键映射，一般用来解除默认的映射

## list-keys
list-keys [-t mode-table] [-T key-table] (alias: lsk)
查看当前的映射表，根据这些已有的映射表可以比较容易自定义映射(还是那句话：约定>配置)


# Options
用于设置tmux的外观，有三种option: Server opt, Session opt, Window opt

## Server option 
通过 set-option -s设置，可通过show-options -s查看当前的server-option

## Session option
通过 set-option设置，可通过show-options查看当前的session-option

## Window option
通过 set-window-option设置

告一段落～ 感觉够用了
