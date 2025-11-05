% 读取文件
excel_file = readtable('/fitness_bmi_data.csv.xlsx');

% 提取数据，假设健身指标在多列，BMI 在一列，根据实际情况修改列索引
fitness_data = table2array(excel_file(:, 1:end - 1)); % 假设最后一列是 BMI，前面是健身指标
bmi_data = table2array(excel_file(:, end));
% 进行主成分分析
[coeff, score, latent] = pca(fitness_data);

% 计算累计贡献率
explained_variance = cumsum(latent)./sum(latent);

% 绘制累计贡献率图
figure;
plot(1:length(explained_variance), explained_variance, 'ro-');
xlabel('主成分数量');
ylabel('累计贡献率');
title('主成分累计贡献率');
grid on;
% 选择主成分数量，假设选择能解释 95% 方差的主成分
num_components = find(explained_variance >= 0.95, 1);
selected_score = score(:, 1:num_components);

% 进行线性回归
mdl = fitlm(selected_score, bmi_data);

% 查看回归模型的摘要
disp('回归模型摘要：');
disp(summary(mdl));

% 绘制预测值和实际值的对比图
bmi_predicted = predict(mdl, selected_score);
figure;
scatter(bmi_data, bmi_predicted);
hold on;
plot([min(bmi_data) max(bmi_data)], [min(bmi_data) max(bmi_data)], 'r--');
xlabel('实际 BMI 值');
ylabel('预测 BMI 值');
title('回归模型预测效果');
grid on;