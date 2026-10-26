#!/usr/bin/env bash
# 用 templates/ 的已提交内容重建 template 分支：单个 commit、无父提交、不含手册历史。
# 用法:
#   scripts/sync-template-branch.sh          # 只更新本地 template 分支
#   scripts/sync-template-branch.sh --push   # 更新后强制推送到 origin
#
# 进入模板分支的文件；增删时改这一行。README 与 AGENTS 是启动阶段就要填的两份。
files=(README.md AGENTS.md)

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

if ! git diff --quiet -- templates; then
  echo "templates/ 有未提交改动，先提交再重建模板分支。" >&2
  exit 1
fi

index=$(mktemp)
trap 'rm -f "$index"' EXIT

GIT_INDEX_FILE="$index" git read-tree --empty
for file in "${files[@]}"; do
  blob=$(git rev-parse "HEAD:templates/$file")
  GIT_INDEX_FILE="$index" git update-index --add --cacheinfo "100644,$blob,$file"
done
tree=$(GIT_INDEX_FILE="$index" git write-tree)
commit=$(git commit-tree "$tree" -m "chore: 初始化项目")
git branch -f template "$commit"
echo "template -> $commit"

if [[ "${1:-}" == "--push" ]]; then
  git push --force origin "$commit:refs/heads/template"
fi
