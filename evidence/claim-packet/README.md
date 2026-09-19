# JSP-000301 申领包（claim packet）— 对齐官方 schema

生成时间：2026-09-19 08:20（第 13 轮巡检）
用途：PR #844 只是**目录层**改动（catalog .md，+1/−1）。真正的**奖励申领**需要另一套
证据文件（`statement.yaml` + `verification/record.yaml`），官方把 schema 公开在
`data/schema/*.json`。本包按该 schema 逐字段填写，**全部字段为真实值，无占位符**。

## 文件

| 文件 | 校验结果 |
| --- | --- |
| `statement.yaml`（STMT-jsp-000301-v1） | ⚠️ 1 处失败（见下「唯一阻塞项」） |
| `verification/record.yaml` | ✅ **0 error**，通过 `verification-record.schema.json`（Draft 2020-12） |

校验命令：
```bash
python3 -c "import yaml,jsonschema,json; ..."   # jsonschema 4.26.0
```

## 关键真实取值

- `repository` = https://github.com/1athena/jsp-formalizations
- `commit` = `2aaf4b4e617c3f43eec6303c8592e1398a03c3d3`（40 位，公开可下载）
- `toolchain.language_version` = `4.33.0`；`library_commit` = `d8b18978…`（lean4 tag v4.33.0）
- `theorems[].axioms` = `["propext"]`（`#print axioms` 实际输出；无 `sorryAx`、无自定义公理）
- `checkers` = 两个独立工具链：Lean **4.33.0**（conda-forge）与 **4.35.0-rc2**（上游 RC），
  均 `result: pass`（exit 0）。⚠️ 两者 `current_release: false` —— 上游最新 release 为 **4.34.0**，
  本轮本机尚未安装（conda 通道无 4.34.0；已启动官方 darwin_aarch64 包后台下载）。
- `artifacts.build_log` = 已永久化的构建日志：
  https://github.com/1athena/jsp-formalizations/blob/43584c10c665dd62f3b6183cd2d73aa9983d13dd/evidence/build-lean4.33.0.log
  （sha256 `d833b0d8…`，456 字节）

## 唯一阻塞项（不可自行伪造）

`statement.schema.json` 要求 `authorship.signatories` **至少 2 人**（`minItems: 2`，
格式 `^[a-z0-9]+(-[a-z0-9]+)*$`）。本包只有真实署名 `1athena`。
第二署名人应为独立复核者/维护者 —— **必须由对方本人签署**，不得代写。
→ 该项在维护者参与前**保持失败状态**，这是诚实结果，不要用假署名凑数。

## 待办（按优先级）

1. 装好 Lean **4.34.0**（当前 release）→ 复跑 kernel → 把某个 checker 的
   `current_release` 改为 `true`。
2. 维护者介入后补第二署名 → `statement.yaml` 通过校验。
3. 由**本人**在官方仓库提 award claim（需 KYC + USDT/USDC 钱包，自动化不代办）。
