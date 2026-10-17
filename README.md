# lean4-stat-proof：用 AI + Lean 4 证明统计学定理

> 面向零基础读者（尤其是只会 Python 的统计学/数据科学背景）的 Lean 4 形式化证明教程与自动化流水线。所有代码在 Windows + Lean 4.35.0 + mathlib 环境下逐段编译验证通过（`lake env lean` 零输出，且 `#print axioms` 确认无 `sorryAx`）。本项目是开源项目《AI赋能统计研究》( https://github.com/chenyiadam/ai-for-statistics ) 的应用案例。

## 这是什么

本仓库包含三样东西：

1. **一篇完整教程**（`docs/lean4-ai-tutorial.md`，配图在 `docs/assets/`）：从"Lean 4 是什么"到"用 mathlib 证明统计结论"再到"搭建 AI 自动证明流水线"，四部分递进：
   - 第一部分：定位与机制（为什么编译器能当数学裁判，AI 如何与它协同）
   - 第二部分：零基础实操（安装、语法、你的前几个定理，Python 对照版）
   - 第三部分：安装 mathlib，亲手证明期望线性性、齐次性、样本均值性质
   - 第四部分：`lean-proof` skill 的设计与实现，把工作流自动化
2. **一个可复用的 skill**（`skill/lean-proof/`）：一条"自然语言命题进、编译通过证明出"的流水线说明书，含阶段划分、反馈接口规范、提示词模板与诚实条款。
3. **可编译的示例代码**（`examples/`）：教程中全部定理的 Lean 源文件，附验证方式。

## 为什么值得学

- **正确性由机器裁决**：证明由 Lean 内核逐条规则检查，幻觉被结构性阻断；
- **AI 时代的数学工作流**：AlphaProof、Aristotle、陶哲轩的 PFR 蓝图项目都用这套模式；
- **统计学的数学骨架可验证**：无偏性、期望的代数性质、不等式控制，都可以在 mathlib 里落地。

## 快速开始

```powershell
# 1. 安装 Lean（见教程第 9 章，约 15 分钟）
# 2. 创建 mathlib 项目（见教程第 16 章）
lake new statdemo math
cd statdemo
lake update
lake exe cache get   # 约 2 GB，走预编译缓存，避免数小时本地编译
lake build

# 3. 编译 examples 里的任意示例
```

详细步骤、报错速查、代理排查见 `docs/` 教程。

## 仓库结构

```
lean4-stat-proof/
├── docs/                    # 完整教程（Markdown + 配图）
├── examples/
│   ├── hello/               # 核心教程示例（无需 mathlib）
│   └── mathlib/             # 统计定理示例（需 mathlib）
├── skill/lean-proof/        # 自动化证明流水线（SKILL.md + 提示词模板）
└── README.md
```

## 学习路线建议

1. 先读教程第一部分（30 分钟），建立"生成-验证闭环"的心智模型；
2. 跟做第二部分（半天），装环境、证明第一个定理；
3. 用第三部分把 mathlib 跑起来，逐个编译 `examples/mathlib/` 的文件；
4. 最后按第四部分把 `skill/lean-proof/` 接入你的 AI 工作流，尝试自动证明自己论文中的命题。

## 已知边界（诚实条款）

- Lean 验证的是统计学的**数学骨架**，不是数据分析流程本身；
- 自动流水线对"陈述是否为真"无能为力：假命题（如 `3 ^ n % 3 = 0` 对 n=0）会被编译器拒绝一切证明，此时应修正陈述而非死磕；
- 大型依赖的下载依赖网络质量，教程第 9.6 与 16 章有完整的代理排查记录。

## License

MIT
