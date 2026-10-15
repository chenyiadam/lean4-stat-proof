def hello := "world"

/-- 前 n 个正整数之和 -/
def sumTo : Nat → Nat
  | 0 => 0
  | n + 1 => sumTo n + (n + 1)

/-- 高斯求和公式：2·(1+2+…+n) = n(n+1)。
    归纳后剩下一个非线性乘积，omega 处理不了，需先手工改写乘积再交给 omega -/
theorem sum_formula (n : Nat) : 2 * sumTo n = n * (n + 1) := by
  induction n with
  | zero => rfl
  | succ k ih =>
    simp only [sumTo]
    have h : (k + 1) * (k + 1 + 1) = k * (k + 1) + 2 * (k + 1) := by
      rw [Nat.mul_add (k + 1) k 2, Nat.mul_comm (k + 1) k, Nat.mul_comm (k + 1) 2]
    rw [h]
    omega

/-- 3 的正整数次幂能被 3 整除 -/
theorem pow_three_mod (n : Nat) : 3 ^ (n + 1) % 3 = 0 := by
  induction n with
  | zero => decide
  | succ k ih => simp [Nat.pow_succ]
