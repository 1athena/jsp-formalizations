# Draft award claim — JSP-000301 (Lean formalization)

> **状态：草稿，未提交。** 按任务硬约束，领奖需本人 KYC + USDT/USDC 钱包，不由本自动化代办。
> 本文件只是把官方 `.github/ISSUE_TEMPLATE/claim-award.yml` 的字段预先填好，
> 唯一留空项是需要本人决定的公开联系邮箱。

提交入口（需本人操作）：
https://github.com/TheJustinSunPrize/awards/issues/new?template=claim-award.yml

Issue 标题：
`[Award claim] JSP-000301`

## 逐字段预填

| 字段 id | 内容 |
| --- | --- |
| `entry`（Problem link） | https://github.com/TheJustinSunPrize/awards/blob/main/problems/catalog-0301-0400.md#JSP-000301 |
| `lean_repository`（Original Lean proof repository） | https://github.com/1athena/jsp-formalizations |
| `contact_email`（Follow-up contact email） | **本人填写**（将公开在 issue 中，建议专用公开邮箱） |
| `contribution_type` | `Lean formalization` |
| `identity_verification` | 留空。仓库属主 `1athena` 与提交 issue 的 GitHub 账号一致，且 catalog 归因已由 PR #844 指向该仓库，来源归因已建立 account-to-author 连接（表单说明：Lean-only 申请人可留空）。 |
| `attribution_clarification` | 该形式化由本账号为本次提交撰写；底层数学事实（反例 12167 / 12168）已在题库中记录为既知解，不主张新的数学贡献。commit `2aaf4b4e617c3f43eec6303c8592e1398a03c3d3`。 |
| `related_claims` | None（无既有申领、无归属争议、无相关职业关系） |
| `declarations` | 三项全部勾选（本人账号、本人贡献、已披露并完成维护者验证） |

## AI 使用披露（真实）

本形式化在 AI 辅助下完成：证明脚本由 AI 生成并由 Lean kernel 独立复核
（两个独立工具链 4.33.0 与 4.35.0-rc2 均 exit 0，axiom 足迹仅 `[propext]`，无 `sorry`/`sorryAx`）。
所有数学内容均可由 kernel 重放验证，未使用任何未被证明的公理，未弱化定义。

## 附：验证凭证

- 目录层 PR：https://github.com/TheJustinSunPrize/awards/pull/844
- 证明仓库 + 40 位 commit：`1athena/jsp-formalizations` @ `2aaf4b4e617c3f43eec6303c8592e1398a03c3d3`
- 证据包：`evidence/claim-packet/`（statement.yaml + record.yaml）
- 构建日志（含 sha256）：见 `record.yaml` 的 `artifacts.build_log`
