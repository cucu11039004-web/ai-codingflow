# ai-codingflow

个人 AI 编程工作流手册，附可复用的项目文档模板。记录工具怎么选、项目文档怎么写、不同阶段该维护什么，供自己和后续项目使用。

背景、目标、计划的实质内容由你提供和决定；AI 可以润色、追问、检查遗漏，并按已确认的任务执行。模板帮助表达清楚，不要求每个项目填满所有文件。

## 从哪里开始

| 场景 | 做什么 | 入口 |
|---|---|---|
| 换主机或调整工具 | 按当时版本手动选择和安装 skills、插件、相关配置 | [TOOLS.md](TOOLS.md) |
| 创建新项目 | 取用 README、AGENTS 模板，填写项目目标与工作环境 | [默认模板](#默认项目模板) |
| 开始具体任务 | 写清本次任务、步骤与验收标准，需要时使用 PLAN | [PLAN 模板](templates/PLAN.md) |
| 文档需求增加 | 按实际缺口增加待办、术语表或决策记录 | [可选模板](#可选模板与扩展文档) |

换主机的参考只覆盖 vibe coding 的工具配置，不覆盖操作系统、驱动或完整开发环境搭建。安装属于低频人工操作，不由本仓库自动执行。

## 本仓库的布局

| 位置 | 职责 |
|---|---|
| [README.md](README.md) | 这套工作流的总入口、文档职责和使用时机 |
| [TOOLS.md](TOOLS.md) | 工具用途、来源、安装与配置记录 |
| [AGENTS.md](AGENTS.md) | 维护本仓库时的约定；根 CLAUDE.md 是指向它的兼容入口 |
| [templates/](templates/) | 三份默认项目模板，复制到目标项目根目录 |
| [templates/optional/](templates/optional/) | 按需取用的 TODO、术语表和 ADR 模板 |
| [skills/plan-flow/](skills/plan-flow/) | 保留的旧版技能，未纳入本版默认流程，限制见 TOOLS |

根目录的 README、AGENTS 描述本仓库自身；它们与 templates 中的同名文件用途不同。给新项目使用时，取用 templates 中的文件。

## 默认项目模板

| 模板 | 回答的问题 | 创建与更新时机 |
|---|---|---|
| [README.md](templates/README.md) | 项目做什么、为什么做、怎么用？ | 启动时先写目标与范围；成果和用法明确后补齐；目标变化时更新 |
| [AGENTS.md](templates/AGENTS.md) | 智能体在什么环境下工作，需要遵守什么？ | 首次协作前填写虚拟环境、机器分工、算力、设备和约定；环境变化时更新 |
| [PLAN.md](templates/PLAN.md) | 当前这一件任务怎么完成，如何验收？ | 具体任务需要拆解或跨会话接续时创建；执行中更新步骤和验收结果 |

README 的项目目标与 AGENTS 的工作环境都反映当前有效情况。项目实际用哪个虚拟环境、在哪台机器训练、有哪些可用设备，写在 AGENTS；README 维护面向使用者的运行方法，AGENTS 引用相应章节，避免两份命令长期分叉。

PLAN 只记录当前任务，不扩展成所有任务的路线图。用户确认目标、范围和验收标准后开始执行，执行中在同一文件标记进度；完成后保留结果，开始下一项任务前确认有价值的记录已提交到 Git，再更新为新任务。Git 历史只能找回已提交的内容。

### 手动取用

在新项目中取用需要的模板，替换括号中的填写提示。不适用的章节可以删除，尚不清楚的信息标记为“待确认”，不要猜测。

```bash
codingflow_source="/path/to/ai-codingflow"
project_dir="/path/to/your-project"
mkdir -p "$project_dir"
cp -i "$codingflow_source/templates/README.md" "$project_dir/README.md"
cp -i "$codingflow_source/templates/AGENTS.md" "$project_dir/AGENTS.md"
# 当前任务需要拆解时再取用
cp -i "$codingflow_source/templates/PLAN.md" "$project_dir/PLAN.md"
```

已有项目应合并需要的章节，不整体覆盖现有内容。若项目使用 CLAUDE.md 作为入口，可在没有同名文件时创建指向 AGENTS.md 的软链，让两者共享一份内容。

## 可选模板与扩展文档

| 项目 | 什么时候需要 | 取用方式 |
|---|---|---|
| TODO.md | 要保存当前计划之外的待办，且没有其他任务工具承担此职责 | 将 [TODO 模板](templates/optional/TODO.md) 放到项目根目录 |
| GLOSSARY.md | 出现需要统一含义的项目专有术语 | 将 [术语表模板](templates/optional/GLOSSARY.md) 放到项目根目录 |
| docs/ | 设计说明、实验记录、操作指南等需要独立成篇 | 有实际内容时创建对应文档，再从 README 或 AGENTS 链接过去 |
| docs/adr/ | 重要决策的理由、备选方案和后果值得长期保留 | 按 [ADR 使用说明](templates/optional/docs/adr/README.md) 取用 [ADR 模板](templates/optional/docs/adr/TEMPLATE.md) |

没有 TODO 时，当前任务进度由 PLAN 承担；有 TODO 时，TODO 只保存任务级状态，实施步骤仍放 PLAN。术语表采用 GLOSSARY.md 命名，替代旧版的 CONTEXT.md，避免与工作环境背景混淆。

docs 是扩展文档目录，并不等于 ADR。无需在项目启动时建立空目录；新增可选文档后，在项目入口补上链接即可。

## 从旧结构取用时

旧版根目录的占位模板已移入 templates，SKILLS.md 扩展为 TOOLS.md，CONTEXT.md 改为可选的 GLOSSARY.md。已有项目可按需合并这些变化，不需要整体迁移。

本版以当前主线的通用模板为入口。历史 robot-il 分支尚未按新结构整理，旧版 plan-flow 也尚未适配可选 TODO；两者都不作为第一版的必需依赖。
