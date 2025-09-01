sync:
  nvim --headless -c "Lazy! sync" -c "qa" 2>/dev/null
  git add .
  git commit -m "package updates"
  git push
