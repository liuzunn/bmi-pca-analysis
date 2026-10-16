# 体测指标主成分分析与 BMI 回归

对体测数据做降维，看看哪些指标真正影响 BMI。

## 流程

```
读取体测指标表
      ↓
主成分分析（PCA）
      ↓
保留累计贡献率 ≥ 95% 的主成分
      ↓
对 BMI 做线性回归
      ↓
画累计贡献率曲线 + 预测-实际散点图
```

## 为什么用 PCA

体测指标之间相关性很强（身高、体重、腰围、肺活量……彼此不独立），直接丢进回归会多重共线性，系数不稳。PCA 先转成一组互不相关的主成分，再取累计贡献率达 95% 的前几个，既降维又避免共线性。

## 文件

| 文件 | 说明 |
| :--- | :--- |
| [`bmianalysis.m`](./bmianalysis.m) | 主分析脚本 |
| [`fitness_bmi_data.csv.xlsx`](./fitness_bmi_data.csv.xlsx) | 体测数据集 |

## 运行

需要 **Statistics and Machine Learning Toolbox**（`pca`、`fitlm`）。

```matlab
bmianalysis
```

> ⚠️ **运行前注意**：脚本里的读取路径写成了 `/fitness_bmi_data.csv.xlsx`（开头是斜杠，MATLAB 会解析到盘符根目录）。需要改成数据文件的实际路径，比如 `readtable('fitness_bmi_data.csv.xlsx')`。

---

## 许可

[MIT](./LICENSE) © 2025 liuzunn
