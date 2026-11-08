# ai-codingflow — 维护约定

本仓库是个人 AI 编程工作流手册与项目文档模板库，没有应用运行服务。根目录文档描述本仓库，供其他项目复制的内容位于 templates。

## 入口

| 位置 | 内容 |
|---|---|
| [README.md](README.md) | main、dev 两个分支的用法，各模板写什么、何时写 |
| [CODEBASE_MAP.md](CODEBASE_MAP.md) | 各目录和文件的职责，改某类内容时动哪里、是否要同步 `main` |

## 维护边界

- 项目背景、目标、计划的实质信息由用户提供和决定。AI 可以整理和补漏，不凭空填写虚拟环境、硬件参数、设备可用性或安装来源。
- 默认模板只有 README、AGENTS、CLAUDE、CODEBASE_MAP、GLOSSARY 和 docs/README；CODEBASE_MAP 随脚手架提供占位，纯文档项目可删；GLOSSARY 出现需要统一的术语时再填；PLAN、TODO 和 ADR 放在 `templates/optional/`，按需采用，不把可选文档重新变成前置条件。
- 模板中的占位符是填写提示，不代表当前项目的实际情况。不要把本仓库的维护记录写入模板。
- `main` 是 GitHub 模板用的脚手架快照，收录 `templates/` 下除 `optional/` 外的全部内容，单个 commit，由 `scripts/sync-template-branch.sh` 从 `dev` 重建并 force-push；不手改 `main`，也不给它加分支保护，日常改动都提交到 `dev`。增删默认模板只在 `templates/` 里增删文件，再重跑脚本。
- 仓库已设为 Template repository，默认分支为 `main`；新建项目走网页的 Use this template 或 `gh repo create --template`，不再从模板分支克隆。
- 只改根目录手册或 `templates/optional/` 不影响脚手架，不需要同步；`main` 与 `dev` 历史无关，不要尝试 merge，撤销模板改动就在 `dev` 上 revert 后再同步。
- 改动文件职责或路径时，同时更新 CODEBASE_MAP，并检查 README、AGENTS 和模板中的引用。根 CLAUDE.md 保持指向本文件。
- 本仓库不放 skill，也不记录工具安装。skills 与 agent 统一由 [Tommy-skills](https://github.com/cucu11039004-web/Tommy-skills) 维护，这里只在 README 引用它。

## Git 分组提交

提交格式、说明语言和授权规则与 [AGENTS 模板](templates/AGENTS.md#git-提交约定) 保持一致：`feat: 摘要`、`fix: 摘要`、`docs: 摘要`，冒号用英文；个人项目默认中文说明；按独立目的分组，每组一个 commit；只说明做了什么，标题不够时再补少量具体改动，不加背景、验证结果或阶段收尾等固定分节。

分块体现在提交次数上：若十几个文件涉及三个独立目的，就按目的分成三组，各提交一次。同一目的下的代码、测试和文档一起提交；同一文件涉及多个目的时按改动区段拆分。

一轮修改涉及三个独立目的时，可以这样分组：

| 改动块 | 涉及内容 | 单独的 commit |
|---|---|---|
| 设置功能 | 配置读写、设置页面及相关测试 | `feat(settings): 支持保存用户偏好` |
| 请求修复 | 请求去重逻辑及相关测试 | `fix(api): 修复重复发送请求的问题` |
| 安装文档 | 安装步骤与配置示例 | `docs: 补充安装步骤与配置示例` |

| 触发方式 | 行为 |
|---|---|
| 阶段实现且验证通过 | 主动整理提交分组及每组说明；未授权时不执行 commit |
| “按独立改动整理提交分组和说明，先不提交。” | 检查实际 diff 和验证记录，输出各组的范围与说明草稿 |
| “检查本阶段改动，按独立内容分批提交，用中文说明做了什么。” | 核对范围与验证结果，逐组完成本地 commit；必要验证未通过时说明阻塞 |
| “本任务各阶段验证通过后，按项目约定自动提交。” | 在本任务授权范围内逐阶段按组提交，无需每阶段再次确认 |

这些是自然语言指令，不需要注册命令或安装插件。验证在提交前完成，结果记录在已采用的 PLAN 或任务反馈中。当前不增加专用 skill；以后若需要跨仓库复用暂存、检查、拆分提交等流程，再封装 skill，并继续引用项目的 AGENTS 约定。

## 检查

本仓库以文档为主，没有应用构建或测试命令。修改后检查 Markdown 相对链接、模板复制后的可读性，以及 git diff --check；重建 `main` 后确认它仍是单个 commit、不含 `dev` 历史，且脚本在 `main` 上会拒绝运行；按需验证命令示例，避免用占位路径直接执行。
