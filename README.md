# ai-codingflow

> AI 编程项目的文档模板，用作 GitHub 模板仓库新建项目。各目录职责见 [CODEBASE_MAP.md](CODEBASE_MAP.md)。
>
> 背景、目标、计划由你提供和决定，AI 可以润色、追问、检查遗漏；模板帮助表达清楚，不要求每个项目填满所有文件。

## main 分支：新建项目

> `main` 是脚手架快照，用它新建仓库。

在 GitHub 点 **Use this template** → Create a new repository，或用命令行：

```bash
gh repo create my-project --template cucu11039004-web/ai-codingflow --private
```

注意：网页上不要勾 Include all branches，否则 `dev` 也会带进新仓库。

新仓库里各文件写什么：

| 模板 | 用途 |
|---|---|
| [README.md](templates/README.md) | 启动时先写目标与范围，确定项目做什么、为什么做、怎么用 |
| [AGENTS.md](templates/AGENTS.md) | 智能体在什么环境下工作、要遵守什么：用哪个虚拟环境、在哪台机器训练、有哪些可用设备；协作与提交约定。实际情况变化时更新 |
| [CLAUDE.md](templates/CLAUDE.md) | 只有一行 `@AGENTS.md`，让 Claude Code 读同一份约定 |
| [CODEBASE_MAP.md](templates/CODEBASE_MAP.md) | 目录职责，改某类功能该看哪里；有目录结构时填写 |
| [GLOSSARY.md](templates/GLOSSARY.md) | 出现需要统一的术语时，记下它在本项目中的含义 |
| [docs/README.md](templates/docs/README.md) | 独立成篇文档（笔记、设计、实验记录）的索引 |
| 可选：[PLAN.md](templates/optional/PLAN.md) | 需要拆解的任务：步骤、验收标准与进度 |
| 可选：[TODO.md](templates/optional/TODO.md) | 当前计划之外的待办（没有其他任务工具时） |
| 可选：[docs/adr/](templates/optional/docs/adr/README.md) | 值得长期保留的重要决策：理由、备选方案和后果 |

可选模板不进脚手架，需要时从 `templates/optional/` 复制到项目里对应位置。

## dev 分支：修改与同步

> 所有改动提交在 `dev`；改了模板就同步到 `main`。

```
dev ──scripts/sync-template-branch.sh──▶ main
```

规则：`templates/` 下除 `optional/` 外的内容就是 `main` 的全部，改了这部分就运行脚本重建 `main`（不手改 `main`）。

```bash
scripts/sync-template-branch.sh --push
```
