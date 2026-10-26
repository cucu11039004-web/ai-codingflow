#!/usr/bin/env bash
# 用 dev 分支上已提交的 templates/ 重建 main 分支：单个 commit、无父提交，供 GitHub 模板新建项目使用。
# 用法:
#   scripts/sync-template-branch.sh          # 只更新本地 main
#   scripts/sync-template-branch.sh --push   # 更新后强制推送到 origin
#
# templates/ 顶层的文件会自动进入脚手架；PLAN 是当前任务文档，按需创建，不放进模板。
exclude=(PLAN.md)

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

files=()
while IFS=$'\t' read -r meta name; do
  type=${meta#* }
  type=${type%% *}
  [[ "$type" == "blob" ]] || continue
  for skip in "${exclude[@]}"; do
    [[ "$name" == "$skip" ]] && continue 2
  done
  files+=("$name")
done < <(git ls-tree "dev:templates/")

if [[ ${#files[@]} -eq 0 ]]; then
  echo "templates/ 里没有可收录的文件。" >&2
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
echo "main -> $commit（${files[*]}）"

if [[ "${1:-}" == "--push" ]]; then
  git push --force origin "$commit:refs/heads/main"
fi
