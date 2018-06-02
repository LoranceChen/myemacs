# init by hand
## install font
- install fonts: M-x all-the-icons-install-fonts

## Install Distel(Erlang Extensions)
- [readme-me](https://www.lambdacat.com/post-modern-emacs-setup-for-erlang/)
	- distel安装后配置之后，正常使用代码跳前需要解决连接erlang node的问题，建议器repl的时候加上--sname的参数为emacs或<其他>，然后在repl对应的.erl的文件中使用C-c C-d n输入node的名字为emacs或<其他>。
	  - 具体使用：
		- `iex --sname emacs -S mix`
		- C-c C-d n ENT emacs ENT
	  - 原理：distel与erlang node交互完成跳转补全功能，如果erlang node关闭，这些功能无法完成
	  - 使用多个项目时，注意iex的node用不同node name
	- erlang跳转会elixir：`C-M-,`这里是可配置的。
  - 其他资料：
	- [配置distel](https://parijatmishra.wordpress.com/2008/08/15/up-and-running-with-emacs-erlang-and-distel/)
