# 模板一：陈述形式化（阶段 A）

请把以下统计命题翻译为 Lean 4 + mathlib 定理陈述。

要求：
1. 只写陈述，证明体用 `:= by sorry`，不要尝试证明。
2. 逐条列出数学假设到 mathlib 概念的映射表（例如：可积 → `Integrable f μ`；概率空间 → `[MeasureSpace Ω] [IsProbabilityMeasure volume]`；期望 → `∫ x, f x ∂μ`）。
3. 用 `variable` 声明类型类与固定参数，保持定理签名简洁。
4. 陈述完成后给出 `lake env lean` 自检结果；除 sorry 警告外必须零输出。

命题：{{PROPOSITION}}

项目路径：{{PROJECT}}
文件路径：{{FILE}}

# 模板二：逐引理填坑（阶段 C，循环调用）

当前 Lean 文件内容：
```
{{FILE_CONTENT}}
```

`lake env lean` 输出：
```
{{COMPILER_OUTPUT}}
```

请修正证明，规则：
1. 只改动最小范围，优先关闭编译输出中的第一个 error。
2. tactic 优先级：`simp` / `omega` / `linarith` / `ring` 等自动化 > `rw [引理]` > `induction` / `rcases` > 手工 `exact`。
3. 引用库引理前先 `#check @名字` 确认存在与精确陈述，禁止凭记忆猜引理名。
4. 若剩余目标包含变量乘变量的非线性项，先考虑用分配律/交换律改写成与归纳假设同型的线性项，再交给 `omega`。
5. 同一目标第 8 次失败后，停止重试，改走升级路径：加 `have` 中间引理、拆小目标、或质疑陈述。

# 模板三：终检报告（阶段 D）

对以下定理执行终检并生成报告：
1. 粘贴完整源码；
2. 运行 `lake env lean {{FILE}}`，粘贴完整输出；
3. 对主定理运行 `#print axioms {{THEOREM}}`，列出公理依赖；
4. 统计：引理数量、总迭代轮数、曾被关闭的卡点；
5. 结论：通过 / 未通过（未通过时列出剩余 sorry 与你的原因分析）。
