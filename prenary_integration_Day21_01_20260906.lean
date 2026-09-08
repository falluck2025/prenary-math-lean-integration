import Mathlib

-- Day21-01 总集成地基：统一命名 + 方向偏好公理补丁
-- 这是 Day21 总集成的"地基"，统一 Day1-Day20 的核心定义

-- 1. 方向二态：inductive 标签 + 偏序（延展 > 收敛）
inductive Direction where
  | contraction : Direction  -- 收敛
  | expansion : Direction    -- 延展

def Direction.rank : Direction → ℕ
  | Direction.contraction => 0
  | Direction.expansion => 1

-- 2. 动作留差公理：任何动作 op 带留差 ε
def prenary_action (op0 ε : ℝ) : ℝ := op0 + ε

-- 3. 定理1：方向偏好（延展 > 收敛）——补丁公理的核心
theorem direction_preference :
    Direction.rank Direction.expansion > Direction.rank Direction.contraction := by
  unfold Direction.rank
  norm_num

-- 4. 定理2：ε 的正性从方向偏好推导（延展 − 收敛 > 0）
theorem epsilon_positive_from_preference (e c : ℝ) (h : c < e) : 0 < e - c := by
  linarith

-- 5. 定理3：动作留差的退化锚（ε=0 退回经典动作）
theorem action_degenerate (op0 : ℝ) : prenary_action op0 0 = op0 := by
  unfold prenary_action
  ring

-- 6. 定理4：动作留差的非平凡（ε≠0 时留差非零）
theorem action_non_trivial {op0 ε : ℝ} (hε : ε ≠ 0) : prenary_action op0 ε ≠ op0 := by
  unfold prenary_action
  intro h
  have : ε = 0 := by linarith
  exact hε this
