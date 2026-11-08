# ai-codingflow

个人 AI 编程工作流手册，附可复用的项目文档模板。记录项目文档怎么写、不同阶段该维护什么，供自己和后续项目使用。

背景、目标、计划的实质内容由你提供和决定；AI 可以润色、追问、检查遗漏，并按已确认的任务执行。模板帮助表达清楚，不要求每个项目填满所有文件。

使用前先按 [Tommy-skills](https://github.com/cucu11039004-web/Tommy-skills) 的 README 安装 skills 和 agent。本仓库只放工作流手册和模板，不放 skill，也不记录工具安装。

各目录和文件的职责见 [CODEBASE_MAP.md](CODEBASE_MAP.md)。根目录的 README、AGENTS 描述本仓库自身，给新项目用的是 `templates/` 中的同名文件。

## 从哪里开始

| 场景 | 做什么 | 入口 |
|---|---|---|
| 创建新项目 | 用 GitHub 的 Use this template 新建仓库，单 commit 即用 | [新建项目](#新建项目) |
| 项目有代码结构后 | 标出主要目录与职责分组，供 review 和修改时定位 | [CODEBASE_MAP 模板](templates/CODEBASE_MAP.md) |
| 开始具体任务 | 写清本次任务、步骤与验收标准，需要时使用 PLAN | [PLAN 模板](templates/optional/PLAN.md) |
| 一个开发阶段验证通过 | 按独立改动分组；有提交授权时逐组执行 commit | [AGENTS.md](AGENTS.md#git-分组提交) |
| 文档需求增加 | 按实际缺口增加计划、待办或决策记录 | [可选模板](#可选模板与扩展文档) |

## 分支与更新

```
dev ──scripts/sync-template-branch.sh──▶ main
```

| 分支 | 角色 | 规则 |
|---|---|---|
| `dev` | 唯一写入分支：手册、templates、scripts | 所有改动都在这里提交 |
| `main` | 生成物：`templates/` 下除 `optional/` 外的全部内容，单个 commit | 由脚本重建，不手改、不 merge、不加分支保护 |

一次完整的更新：

```bash
git checkout dev
# 改 templates/ 里的默认模板；只改手册或 optional/ 则不涉及 main
git add -A && git commit
git push origin dev
scripts/sync-template-branch.sh --push   # 只有改了模板才需要
```

- 规则只有一条：`templates/` 下除 `optional/` 以外的全部内容（包括 `docs/` 这样的子目录）就是 `main` 的全部内容。要给 `main` 加文件就放进 `templates/`，要去掉就删除或挪进 `templates/optional/`，然后运行脚本。
- 只改根目录的手册或 `templates/optional/`：不进脚手架，不需要同步。
- `dev` 里没有 `main` 的提交，两者历史无关，所以不存在「把 dev 合并进 main」这一步；同步永远是重建加 force push。
- 同步只影响之后新建的仓库；已经在用的项目按「在已有项目里补文档」取用。
- 脚本会先比较内容：`templates/` 没有实际变化时直接退出，不会产生多余的 force push。
- 撤销一次模板改动：在 `dev` 上 revert 对应提交，再同步一次，不在 `main` 上回滚。

## 默认项目模板

| 模板 | 回答的问题 | 创建与更新时机 |
|---|---|---|
| [README.md](templates/README.md) | 项目做什么、为什么做、怎么用？ | 启动时先写目标与范围；成果和用法明确后补齐；目标变化时更新 |
| [AGENTS.md](templates/AGENTS.md) | 智能体在什么环境下工作，需要遵守什么？ | 首次协作前填写环境、资源、协作与提交约定；实际情况变化时更新 |
| [CLAUDE.md](templates/CLAUDE.md) | Claude Code 从哪里读取约定？ | 只有一行 `@AGENTS.md`，让 Claude Code 读取同一份 AGENTS；不在其中另写内容 |
| [CODEBASE_MAP.md](templates/CODEBASE_MAP.md) | 代码在哪、改某类功能该看哪些位置？ | 脚手架自带；有代码结构后按实际目录填写，结构变化时更新 |
| [GLOSSARY.md](templates/GLOSSARY.md) | 某个术语或符号在本项目中指什么？ | 脚手架自带；出现需要统一含义的术语时填写，新术语经用户确认后补充 |
| [docs/README.md](templates/docs/README.md) | 独立成篇的文档放哪、怎么组织？ | 脚手架自带；新增文档时在索引补一行，按其中的写法组织 |

README 的项目目标与 AGENTS 的工作环境都反映当前有效情况。项目实际用哪个虚拟环境、在哪台机器训练、有哪些可用设备，写在 AGENTS；README 维护面向使用者的运行方法，AGENTS 引用相应章节，避免两份命令长期分叉。

CODEBASE_MAP 随脚手架提供占位，有目录结构后按实际填写；纯文档项目可以删掉它。它不重复 README 的用法说明，也不替代 AGENTS 的环境事实。

docs 放学习笔记、设计说明、实验记录、操作指南等独立成篇的内容，不预建分类子目录；同一主题积累到三篇左右再收进子目录，系列用两位编号。

GLOSSARY 只解释词和符号的含义，做项目和学习都会逐渐积累；做事的规矩（命名风格、提交格式等）写在 AGENTS 的协作约定。它替代旧版的 CONTEXT.md，避免与工作环境背景混淆。

## 新建项目

本仓库是 GitHub Template repository，默认分支 `main` 就是脚手架：收录 `templates/` 下除 `optional/` 外的全部内容，单个 commit、无父提交，不含手册历史。

1. 在 GitHub 点 **Use this template** → Create a new repository，选择模板后直接创建；不要勾 Include all branches，否则 `dev` 也会被带进新仓库。
2. 或者命令行：`gh repo create my-project --template cucu11039004-web/ai-codingflow --private`。

新仓库只有一条 Initial commit，根目录就是这几份默认模板和 `docs/README.md`。填掉括号里的提示、删掉不需要的段落即可开始；脚手架不收录 `PLAN.md`，需要拆解任务时再从 `templates/optional/` 取，避免空占位被当成真实计划。

`main` 由 [scripts/sync-template-branch.sh](scripts/sync-template-branch.sh) 从 `dev` 重建，是生成物：不要手改，也不要加分支保护。改完 `templates/` 在 `dev` 上提交后运行：

```bash
scripts/sync-template-branch.sh --push
```

以后新增或删除默认模板，只需在 `templates/` 里增删文件，重跑脚本就会同步到 `main`。

### 在已有项目里补文档

模板只决定新仓库的起点，之后改 `templates/` 不会自动更新已经建好的项目。需要 `PLAN.md`、`TODO.md`、`GLOSSARY.md`、`docs/README.md` 或 ADR 时，从 `dev` 取单个文件，再在项目 README 的「文档入口」补一行。

```bash
# 本机有手册克隆时
cp /path/to/ai-codingflow/templates/optional/PLAN.md PLAN.md

# 任何机器都能取（仓库公开）
curl -fsSL https://raw.githubusercontent.com/cucu11039004-web/ai-codingflow/dev/templates/optional/PLAN.md -o PLAN.md

# 想统一走 gh（私有仓库也可）
gh api -H "Accept: application/vnd.github.raw" \
  "/repos/cucu11039004-web/ai-codingflow/contents/templates/optional/PLAN.md?ref=dev" > PLAN.md
```

其他模板把路径换成 `templates/optional/TODO.md`、`templates/GLOSSARY.md`、`templates/docs/README.md`（先 `mkdir -p docs`）；取 ADR 时先 `mkdir -p docs/adr`，再取 `templates/optional/docs/adr/README.md` 和 `TEMPLATE.md`。

按需添加，不用一次补齐；补完后按文件里的提示填写，删掉不适用的占位。

## 可选模板与扩展文档

| 项目 | 什么时候需要 | 取用方式 |
|---|---|---|
| PLAN.md | 开始具体任务，需要拆解步骤、写验收标准或跨会话接续 | 将 [PLAN 模板](templates/optional/PLAN.md) 放到项目根目录 |
| TODO.md | 要保存当前计划之外的待办，且没有其他任务工具承担此职责 | 将 [TODO 模板](templates/optional/TODO.md) 放到项目根目录 |
| docs/adr/ | 重要决策的理由、备选方案和后果值得长期保留 | 按 [ADR 使用说明](templates/optional/docs/adr/README.md) 取用 [ADR 模板](templates/optional/docs/adr/TEMPLATE.md) |

PLAN 只记录当前任务，不扩展成所有任务的路线图。用户确认目标、范围和验收标准后开始执行，执行中在同一文件标记进度；完成后保留结果，开始下一项任务前确认有价值的记录已提交到 Git，再更新为新任务。Git 历史只能找回已提交的内容。

没有 TODO 时，当前任务进度由 PLAN 承担；有 TODO 时，TODO 只保存任务级状态，实施步骤仍放 PLAN。

## 从旧结构取用时

旧版根目录的占位模板已移入 templates，TOOLS.md（原 SKILLS.md）已删除、工具安装统一见 Tommy-skills，CONTEXT.md 改名为 GLOSSARY.md 并进入脚手架，PLAN.md 移入 `templates/optional/`，docs/ 带索引进入脚手架。已有项目可按需合并这些变化，不需要整体迁移。

本版以 `dev` 上的通用模板为入口，`main` 只是由它生成的脚手架快照。旧版 plan-flow skill 已删除，需要时从 Git 历史找回；原 robot-il 分支已归档为 `archive/robot-il` 标签，不再维护。
