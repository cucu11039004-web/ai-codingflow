# ai-codingflow — 维护约定

本仓库是个人 AI 编程工作流手册与项目文档模板库，没有应用运行服务。根目录文档描述本仓库，供其他项目复制的内容位于 templates。

## 入口

| 位置 | 内容 |
|---|---|
| [README.md](README.md) | 工作流、目录分工、取用方式和文档创建时机 |
| [TOOLS.md](TOOLS.md) | skills、插件与配置的人工维护参考 |
| [scripts/](scripts/) | 维护脚本：从 `dev` 的 `templates/` 重建 `main` 脚手架快照 |
| [templates/](templates/) | README、AGENTS、PLAN、CODEBASE_MAP 四份默认模板 |
| [templates/optional/](templates/optional/) | TODO、GLOSSARY、ADR 可选模板 |

## 维护边界

- 项目背景、目标、计划的实质信息由用户提供和决定。AI 可以整理和补漏，不凭空填写虚拟环境、硬件参数、设备可用性或安装来源。
- 工具配置面向低频人工安装，不扩展成主机初始化、自动部署或强制安装清单。
- 默认模板只有 README、AGENTS、PLAN、CODEBASE_MAP；CODEBASE_MAP 在项目产生代码结构后创建，纯文档项目不建；TODO、术语表、docs 和 ADR 按需采用，不把可选文档重新变成前置条件。
- 模板中的占位符是填写提示，不代表当前项目的实际情况。不要把本仓库的维护记录写入模板。
- `main` 是 GitHub 模板用的脚手架快照，只含 `README.md` 与 `AGENTS.md` 的单个 commit，由 `scripts/sync-template-branch.sh` 从 `dev` 的 `templates/` 重建并 force-push；不手改 `main`，也不给它加分支保护，日常改动都提交到 `dev`。
- 仓库已设为 Template repository，默认分支为 `main`；新建项目走网页的 Use this template 或 `gh repo create --template`，不再从模板分支克隆。
- 改动文件职责或路径时，同时检查 README、TOOLS 和模板中的引用。根 CLAUDE.md 保持指向本文件。
- skills/plan-flow 保留旧实现，暂不纳入默认流程；不主动调用它，也不把它的 TODO 要求应用到新模板。

## 检查

本仓库以文档为主，没有应用构建或测试命令。修改后检查 Markdown 相对链接、模板复制后的可读性，以及 git diff --check；重建 `main` 后确认它仍是单个 commit、不含 `dev` 历史，且脚本在 `main` 上会拒绝运行；按需验证命令示例，避免用占位路径直接执行。
