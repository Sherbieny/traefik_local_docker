# GIT
# Update staging branch with the current branch
function update_staging() {
  git checkout staging &&
  git pull origin staging &&
  git merge --no-ff $1 &&
  git push origin staging &&
  git checkout $1
}

# Add ssh key to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
