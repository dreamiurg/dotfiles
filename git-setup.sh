# Globally exclude some files
git config --global alias.st status
git config --global alias.last "log -1 HEAD"
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.diffall "!sh ~/etc/git-diffall/git-diffall"

git config --global alias.lg "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)%C(bold yellow)%d%C(reset)' --abbrev-commit --date=relative"
git config --global alias.lgg "log --graph --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%cD%C(reset) %C(bold green)(%cr)%C(reset)%C(bold yellow)%d%C(reset)%n'' %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)' --abbrev-commit"

git config --global alias.diffall !"~/etc/git-diffall/git-diffall"

git config --global color.ui always
git config --global color.diff always
