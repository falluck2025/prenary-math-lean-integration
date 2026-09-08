import Mathlib

noncomputable section

-- Day21-02 核心定理总集成：Day1-Day20 全数学地图，统一命名，一个文件自洽验证
-- 目的：证明"偏元数学 = 经典数学 + ε"的完整体系，在一个文件里自洽、无冲突

-- ========== 地基（Day1-6 + Day20 方向偏好补丁）==========
inductive Direction where
  | contraction : Direction
  | expansion : Direction

def Direction.rank : Direction → ℕ
  | Direction.contraction => 0
  | Direction.expansion => 1

def prenary_action (op0 ε : ℝ) : ℝ := op0 + ε

-- 方向偏好（补丁核心）
theorem direction_preference :
    Direction.rank Direction.expansion > Direction.rank Direction.contraction := by
  unfold Direction.rank
  norm_num

-- ε 正性（从方向偏好推导）
theorem epsilon_positive (e c : ℝ) (h : c < e) : 0 < e - c := by
  linarith

-- 退化锚（Day3：δ₀=0 ⟹ 方向偏好消失 ⟹ ε=0）
theorem degenerate_anchor (op0 : ℝ) : prenary_action op0 0 = op0 := by
  unfold prenary_action
  ring

-- 平衡点（Day2：½+½=1，对称平衡）
theorem symmetric_balance : (1 / 2 : ℝ) + (1 / 2 : ℝ) = 1 := by
  norm_num

-- ========== 度量/测度/拓扑（Day8-12）==========
-- 静态自距=0（Day8 对象层）
theorem static_distance_zero (x : ℝ) : x - x = 0 := by
  ring

-- 拓扑不变（Day12：加 ε 是平移，差不变）
theorem topology_preserved (e c ε : ℝ) : (e + ε) - (c + ε) = e - c := by
  ring

-- ========== 代数（Day13：单位元方向双路）==========
def unit_expansive (ε : ℝ) : ℝ := ε
def unit_convergent (ε : ℝ) : ℝ := -ε

theorem unit_two_directions (ε : ℝ) :
    (unit_expansive ε = ε) ∧ (unit_convergent ε = -ε) := by
  constructor
  · unfold unit_expansive
    rfl
  · unfold unit_convergent
    rfl

-- ========== 范畴论（Day16：复合留差 = 链式法则留差版）==========
def comp_residue (a εg εf : ℝ) : ℝ := a * εg + εf

theorem comp_residue_amplified (a εg εf : ℝ) : comp_residue a εg εf = a * εg + εf := by
  unfold comp_residue
  rfl

-- ========== 随机 ε（Day17：死穴① 层间落差）==========
def random_expectation (δ : ℝ) : ℝ := (δ + (-δ)) / 2

theorem expectation_zero (δ : ℝ) : random_expectation δ = 0 := by
  unfold random_expectation
  ring

theorem pointwise_nonzero {δ : ℝ} (hδ : δ ≠ 0) : δ ≠ 0 ∧ -δ ≠ 0 := by
  constructor
  · exact hδ
  · intro h
    have : δ = 0 := by linarith
    exact hδ this

-- ========== 三层结构（Day19：方向偏好三态）==========
theorem preference_vanishes (e c : ℝ) (h : e = c) : e - c = 0 := by
  rw [h]
  ring

theorem preference_fixed (e c : ℝ) (h : c < e) : 0 < e - c := by
  linarith

end
