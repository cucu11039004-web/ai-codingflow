# 代码地图

本仓库是个人 AI 编程工作流手册与项目文档模板库：根目录文档描述本仓库自身，`templates/` 里的文件供新项目取用。

本文件说明各目录和文件装什么、改某类内容时动哪里。工作流与取用方式见 [README.md](README.md)，维护约定见 [AGENTS.md](AGENTS.md)。目录或职责变化时更新本文件。

## 目录结构

- [README.md](README.md)——工作流总入口：分支与更新流程、各模板的作用和创建时机、新建项目与补文档的方法
- [AGENTS.md](AGENTS.md)——维护本仓库时的约定与检查项
  - CLAUDE.md——指向 AGENTS.md 的软链，供 Claude Code 读取同一份约定
- CODEBASE_MAP.md——本文件
- [scripts/](scripts/)
  - [sync-template-branch.sh](scripts/sync-template-branch.sh)——从 `dev` 已提交的 `templates/` 重建 `main` 脚手架
- [templates/](templates/)——给新项目用的模板；根目录的同名文件描述的是本仓库，不要混用
  - README.md、AGENTS.md、CLAUDE.md、CODEBASE_MAP.md、GLOSSARY.md——默认模板
  - [docs/README.md](templates/docs/README.md)——docs 目录的索引与写法，同样进入 `main`
  - [optional/](templates/optional/)——按需取用的 PLAN、TODO 和 `docs/adr/` 模板，不进 `main`；除它以外的全部内容就是 `main`
- .gitignore——忽略本地 agent 目录与运行时产物

## 各部分职责

| 分组 | 涉及位置 | 职责 | 改动后是否要同步 `main` |
|---|---|---|---|
| 手册 | README.md、AGENTS.md、CODEBASE_MAP.md | 描述本仓库的工作流、约定和布局 | 不需要 |
| 脚手架模板 | `templates/` 下除 `optional/` 外的全部内容 | 新建项目时得到的初始文件 | 需要：在 `dev` 提交后运行 `scripts/sync-template-branch.sh --push` |
| 按需模板 | `templates/optional/` | 已有项目按需取用的单个文件 | 不需要 |
| 维护脚本 | `scripts/` | 决定哪些文件进入 `main` 并重建它 | 改了收录规则后运行一次，确认 `main` 内容符合预期 |
