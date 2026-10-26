#!/usr/bin/env bash
# 用 dev 分支上已提交的 templates/ 重建 main 分支：单个 commit、无父提交，供 GitHub 模板新建项目使用。
# 用法:
#   scripts/sync-template-branch.sh          # 只更新本地 main
#   scripts/sync-template-branch.sh --push   # 更新后强制推送到 origin
#
# 进入脚手架的文件；增删时改这一行。README 与 AGENTS 是启动阶段就要填的两份。
files=(README.md AGENTS.md)

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel)
cd "$repo_root"

current=$(git rev-parse --abbrev-ref HEAD)
if [[ "$current" == "main" ]]; then
  echo "main 是生成物，请在 dev 分支上运行。" >&2
  exit 1
fi

if ! git diff --quiet HEAD -- templates; then
  echo "templates/ 有未提交改动，先提交再重建 main。" >&2
  exit 1
fi

index=$(mktemp)
trap 'rm -f "$index"' EXIT

GIT_INDEX_FILE="$index" git read-tree --empty
for file in "${files[@]}"; do
  blob=$(git rev-parse "dev:templates/$file")
  GIT_INDEX_FILE="$index" git update-index --add --cacheinfo "100644,$blob,$file"
done
tree=$(GIT_INDEX_FILE="$index" git write-tree)
commit=$(git commit-tree "$tree" -m "chore: 初始化项目")
git branch -f main "$commit"
echo "main -> $commit"

if [[ "${1:-}" == "--push" ]]; then
  git push --force origin "$commit:refs/heads/main"
fi
