# 工具安装与配置参考

本文件记录 vibe coding 使用的 skills、插件和相关配置，供换主机或调整工具时手动查阅。安装方式会变化，应根据所用客户端、版本和原始来源核对；这份清单不是必须全部安装的套餐。

## 先记录现用组合

| 类别 | 需要填写的内容 | 什么时候更新 |
|---|---|---|
| 编程客户端 | 实际使用的工具、版本、官方安装入口 | 换机或升级时 |
| Skills | 名称、解决的问题、原始来源、安装方式、适用客户端 | 增删或更新 skill 时 |
| 插件 / 外部连接 | 名称、用途、安装入口、是否需要重新登录 | 换机或项目需要新能力时 |
| 个人配置 | 配置项、用途、作用范围、非敏感配置的位置 | 偏好或客户端配置变化时 |

个人通用配置记录在这里；项目实际使用的虚拟环境、服务器算力和硬件设备写入目标项目的 AGENTS.md。登录凭证不作为文档内容保存。

## 现用 skills 与 agent

| 来源 | 内容 | 安装与更新 |
|---|---|---|
| [mattpocock/skills](https://github.com/mattpocock/skills) | Matt Pocock 的 skill 集（grill-me、grilling、domain-modeling、handoff 等），按需挑选 | `npx skills@latest add mattpocock/skills -g -a claude-code -a codex -a github-copilot`，交互选择要装的 skill |
| [cucu11039004-web/Tommy-skills](https://github.com/cucu11039004-web/Tommy-skills) | 自己写的 skill（如 paper-digest）和 VS Code Copilot 模式的 agent（如 Chat） | 见该仓库 README，安装与更新是同一条命令 |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | skills CLI 本身，以及 find-skills | CLI 用 `npx skills@latest` 直接运行，不用单独安装 |

- skills CLI 把 skill 实际装在 `~/.agents/skills/`，Codex 直接读这里；Claude Code 读 `~/.claude/skills/`，Copilot 读 `~/.copilot/skills/`。用 `-a` 指定了哪些客户端，CLI 就在对应目录自动建好链接；如果 `~/.claude/skills` 已经整个链到 `~/.agents/skills`，CLI 会识别出是同一位置并跳过，不会重复建链。
- 不带 skill 名的 `npx skills update -g` 会更新所有来源的 skill。只想更新某个来源时，重新执行该来源的 `add` 命令，或者用 `npx skills update <skill 名> -g` 指定名字。
- 自己的新 skill 只加到 Tommy-skills，本仓库不放 skill。

最近核实：2026-11-07，skills CLI 1.7.6。

## 每项工具的记录格式

选定工具后，复制下表并填入实际信息。没有选定的插件无需预先列出，也不要仅凭名称补写安装来源。

| 字段 | 填写内容 |
|---|---|
| 名称与类别 | （工具名称；skill / 插件 / 配置） |
| 解决的问题 | （为什么使用、何时使用） |
| 原始来源 | （官网、仓库或个人维护位置） |
| 适用客户端与版本 | （实际使用的客户端；记录适用版本或日期） |
| 安装方式与范围 | （核实后的人工安装步骤；全局或项目级） |
| 必要配置 | （配置项及非敏感配置位置） |
| 最小验证 | （安装后如何确认可用） |
| 最近核实 | （日期与验证结果） |

## 换主机时的顺序

1. 确认此次使用的编程客户端和需要保留的工具，不照搬所有历史候选项。
2. 打开各工具的原始来源，按当前版本手动安装和登录，恢复需要的个人配置。
3. 做一次最小使用验证，再把实际版本、步骤和核实日期更新到本文件。
4. 进入具体项目后，核对该项目 AGENTS.md 中的虚拟环境、机器分工与设备是否仍然有效。
