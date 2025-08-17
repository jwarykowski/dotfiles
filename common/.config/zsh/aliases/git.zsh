# status
alias gst='git status'
alias gss='git status -s'

# add
alias ga='git add'
alias gaa='git add --all'
alias gau='git add --update'
alias gap='git add --patch'

# branch
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbnm='git branch --no-merged'
alias gbm='git branch -m'

# checkout
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcm='git checkout main'
alias gcs='git checkout staging'
alias gct='git checkout trunk'

# commit
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcf='git commit --amend'

# diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

# log
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(red)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"

# stash
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstu='git stash --include-untracked'

# pull
alias gl='git pull'
alias glr='git pull --rebase'
alias glum='git pull upstream master'

# push
alias gp='git push'
alias gpo='git push origin'
alias gpu='git push upstream'
alias gpv='git push -v'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'

# fetch
alias gf='git fetch'
alias gfa='git fetch --all --prune'

# merge / rebase
alias gm='git merge'
alias gma='git merge --abort'
alias gmnff='git merge --no-ff'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'

# remote
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias grrm='git remote remove'
alias grmv='git remote rename'
alias grset='git remote set-url'
alias grup='git remote update'

# reset
alias grh='git reset'
alias grhh='git reset --hard'
alias grhs='git reset --soft'
alias grhu='git reset --mixed'
alias grhk='git reset --keep'

# clean
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'

# cherry-pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# tag
alias gt='git tag'
alias gts='git tag -s'
alias gtv='git tag | sort -V'

# bisect
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

# notes
alias gnote='git notes'
alias gnotesh='git notes show'

# helpers

# rename a branch
gbrename() {
  git branch -m "$1" "$2"
}

# show commit count per author
gcount() {
  git shortlog -sn
}

# Undo last wip commit
gunwip() {
  git log -n 1 | grep -q -c "--wip--" && git reset HEAD~1
}

# create a wip commit
gwip() {
  git add -A
  git commit -m "--wip--" --no-gpg-sign
}
