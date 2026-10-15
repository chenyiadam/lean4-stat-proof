import Mathlib

open MeasureTheory

variable {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω}

/-- 例 1：期望的线性性 -/
theorem expectation_add (f g : Ω → ℝ) (hf : Integrable f μ) (hg : Integrable g μ) :
    ∫ x, f x + g x ∂μ = ∫ x, f x ∂μ + ∫ x, g x ∂μ :=
  integral_add hf hg

/-- 例 2：期望的齐次性 E[cX] = c·E[X]（无需可积性：等式两边同时存在或同时为∞） -/
theorem expectation_const_mul (c : ℝ) (f : Ω → ℝ) :
    ∫ x, c * f x ∂μ = c * ∫ x, f x ∂μ :=
  integral_const_mul c f

-- 例 2b：期望的平移性 E[X + c] = E[X] + c（需要概率测度：P(Ω) = 1）
-- 注意：文档注释不能挂在 section 上，故此处用普通注释，docstring 给定理本身
section
variable [IsProbabilityMeasure μ]

/-- 期望的平移性 E[X + c] = E[X] + c -/
theorem expectation_add_const (f : Ω → ℝ) (hf : Integrable f μ) (c : ℝ) :
    ∫ x, (f x + c) ∂μ = ∫ x, f x ∂μ + c := by
  rw [integral_add hf (integrable_const c), integral_const]
  simp

end

/-- 例 3：有限个随机变量之和的期望等于期望之和 -/
theorem expectation_finsetSum {ι : Type*} (s : Finset ι) (f : ι → Ω → ℝ)
    (hf : ∀ i ∈ s, Integrable (f i) μ) :
    ∫ x, ∑ i ∈ s, f i x ∂μ = ∑ i ∈ s, ∫ x, f i x ∂μ :=
  integral_finsetSum s hf

/-- 例 3 推论：样本均值的期望等于各分量期望的平均（无偏性的核心代数） -/
theorem expectation_sampleMean {ι : Type*} (s : Finset ι)
    (f : ι → Ω → ℝ) (hf : ∀ i ∈ s, Integrable (f i) μ) :
    ∫ x, (∑ i ∈ s, f i x) / s.card ∂μ = (∑ i ∈ s, ∫ x, f i x ∂μ) / s.card := by
  have h : (∫ x, (∑ i ∈ s, f i x) / s.card ∂μ)
      = ∫ x, (1 / s.card) * (∑ i ∈ s, f i x) ∂μ := by
    congr 1
    funext x
    ring
  rw [h, integral_const_mul, integral_finsetSum s hf]
  ring
