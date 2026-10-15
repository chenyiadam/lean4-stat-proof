import Mathlib

/- 例：样本均值的平移协变性（纯代数，无需测度论）
   每个观测值加上常数 c，样本均值恰好增加 c。
   注意样本均值只对非空集合有定义（card = 0 时分母为零），
   所以必须带 s.Nonempty 假设，这是形式化比纸面数学更严格的地方。 -/

/-- 样本均值：有限观测集合上函数值的算术平均 -/
noncomputable def sampleMean {ι : Type*} (s : Finset ι) (f : ι → ℝ) : ℝ :=
  (∑ i ∈ s, f i) / s.card

/-- 平移协变性：整体加 c，均值加 c（需要非空：空集时 0 = c 不成立） -/
theorem sampleMean_add_const {ι : Type*} (s : Finset ι) (hs : s.Nonempty) (f : ι → ℝ) (c : ℝ) :
    sampleMean s (fun i => f i + c) = sampleMean s f + c := by
  have hcard : (s.card : ℝ) ≠ 0 := by exact_mod_cast ne_of_gt (Finset.card_pos.mpr hs)
  rw [sampleMean, sampleMean, Finset.sum_add_distrib, Finset.sum_const, nsmul_eq_mul, add_div]
  field_simp

/-- 齐次性：整体乘 k，均值乘 k。注意无需非空假设：Lean 的实数约定 a/0 = 0，
    空集退化情形 0 = k·0 也成立，这是形式化才会暴露的细节。 -/
theorem sampleMean_const_mul {ι : Type*} (s : Finset ι) (f : ι → ℝ) (k : ℝ) :
    sampleMean s (fun i => k * f i) = k * sampleMean s f := by
  rw [sampleMean, sampleMean, ← mul_div_assoc k, Finset.mul_sum]
