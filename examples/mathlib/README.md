# examples/mathlib：统计定理示例（需要 mathlib）

本目录包含教程第三部分的全部源文件，每个文件均通过 `lake env lean` 零输出验证，并通过 `#print axioms` 确认只依赖 Lean 三条标准公理（无 `sorryAx`）：

| 文件 | 内容 |
|---|---|
| `Scratch1.lean` | 期望四性质（线性性、齐次性、平移性、有限和交换）与样本均值期望推论（测度论侧） |
| `Scratch2.lean` | 样本均值的平移协变性与齐次性（纯代数侧） |

## 如何编译

这两个文件依赖 mathlib，无法单独编译。请先按教程第 9、16 章装好环境，然后：

```powershell
lake new mydemo math
cd mydemo
lake update
lake exe cache get   # 下载预编译 olean，约 2 GB，避免数小时本地编译
lake build
```

把本目录的 `Scratch1.lean`、`Scratch2.lean` 复制到项目根目录，执行：

```powershell
lake env lean Scratch1.lean   # 零输出即通过
lake env lean Scratch2.lean
```

## 终检（可选）

在任一文件末尾追加一行即可查看公理依赖：

```lean
#print axioms expectation_sampleMean
-- 'expectation_sampleMean' depends on axioms: [propext, Classical.choice, Quot.sound]
```

出现 `sorryAx` 说明有未完成的 `sorry` 残留，参考教程第 19 章阶段 D 的终检流程。
