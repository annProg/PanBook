
## theorem

::: {.info caption="扩展信息"}
使用场景
  ~ 提供定理环境

启用状态
  ~ 默认在 book, thesis 中启用

格式支持  
  ~ \LaTeX 

语法系列
  ~ fenced_divs 参见 [@sec:fenced_divs]  
:::

#### 示例

definition，theorem，lemma，corollary，proposition 支持引用，ID 前缀必须分别是 def:，thm:，lem:，cor:，pro:。
```markdown
效果见 [@def:test],[@thm:test], [@lem:test], [@cor:test], [@pro:test]。

::: {#def:test .definition caption="标题"}
Definition
:::

::: {#thm:test .theorem caption="标题"}
Theorem
:::

::: {#lem:test .lemma caption="标题"}
Lemma
:::

::: {#cor:test .corollary caption="标题"}
Corollary
:::

::: {#pro:test .proposition caption="标题"}
Proposition
:::

::: {.example}
Example
:::

::: {.exercise}
Exercise
:::

::: {.problem}
Problem
:::

::: {.proof}
Proof
:::

::: {.note}
Note
:::

::: {.conclusion}
Conclusion
:::

::: {.assumption}
Assumption
:::

::: {.property}
Property
:::

::: {.remark}
Remark
:::

::: {.solution}
Solution
:::
```

效果见 [@def:test],[@thm:test], [@lem:test], [@cor:test], [@pro:test]。

::: {#def:test .definition caption="标题"}
Definition
:::

::: {#thm:test .theorem caption="标题"}
Theorem
:::

::: {#lem:test .lemma caption="标题"}
Lemma
:::

::: {#cor:test .corollary caption="标题"}
Corollary
:::

::: {#pro:test .proposition caption="标题"}
Proposition
:::

::: {.example}
Example
:::

::: {.exercise}
Exercise
:::

::: {.problem}
Problem
:::

::: {.proof}
Proof
:::

::: {.note}
Note
:::

::: {.conclusion}
Conclusion
:::

::: {.assumption}
Assumption
:::

::: {.property}
Property
:::

::: {.remark}
Remark
:::

::: {.solution}
Solution
:::