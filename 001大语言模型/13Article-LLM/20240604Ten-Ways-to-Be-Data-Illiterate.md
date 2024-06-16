## 20240604Ten-Ways-to-Be-Data-Illiterate

[10 Ways to Be Data Illiterate (and How to Avoid Them) - jxnl.co](https://jxnl.co/writing/2024/06/02/10-ways-to-be-data-illiterate-and-how-to-avoid-them/#disregarding-interpretability-and-explainability)

10 Ways to Be Data Illiterate (and How to Avoid Them)

10 种导致数据素养不足的行为（以及如何避免）

### 01. Ignoring Data Quality

Data quality is the foundation upon which all analyses and models are built. Failing to assess and address issues like missing values, outliers, and inconsistencies can lead to unreliable insights and poor model performance. Data literate AI engineers must prioritize data quality to ensure their work is accurate and trustworthy.

Inversion: Assess and address data quality issues before analyzing data or building models. 

- Conduct exploratory data analysis (EDA) to identify potential quality issues 
- Develop and implement data cleaning and preprocessing pipelines 
- Establish data quality metrics and monitor them regularly

忽视数据质量

数据质量是所有分析和模型的基础。如果不评估和处理缺失值、离群值和数据不一致性等问题，可能会导致分析结果不可靠，模型性能不佳。具备数据素养的 AI 工程师应优先关注数据质量，确保其工作的准确性和可信度。

反向思考：在分析数据或构建模型之前，先评估和解决数据质量问题。

- 进行探索性数据分析（Exploratory Data Analysis，简称 EDA）以识别潜在的质量问题
- 开发并实施数据清洗和预处理流程
- 建立数据质量指标并定期监控

### 02. Not Visualizing the Data

Not visualizing your data can lead to missed insights, poor understanding of patterns and relationships, and poor communication of findings to others. AI engineers must learn the basics of visualizing data to better understand it, grok it, and communicate it.

Inversion: Learn how to visualize data to explore, understand, and communicate the data. 

- Start with basic visualizations, such as histograms and box plots to understand distributions 
- Then, consider advanced techniques such as PCA or t-SNE to discover complex patterns 
- Don't let the visual hang on its own—provide a logical narrative to guide the reader through it

不进行数据可视化

如果不对数据进行可视化，可能会错过重要见解，难以理解数据中的模式和关系，也难以向他人传达研究结果。AI 工程师必须掌握数据可视化的基本知识，以更好地理解数据、分析数据并传达结果。

反向思考：学习如何通过可视化来探索、理解和传达数据。

- 从直方图和箱线图等基本可视化方法开始，了解数据分布
- 然后，考虑使用主成分分析（PCA）或 t-SNE 等高级技术以发现复杂模式
- 可视化应配有逻辑叙述，引导读者理解

### 03. Only Relying on Aggregate Statistics

Aggregate statistics such as mean and median can obscure important patterns, outliers, and subgroup differences within the data. AI engineers should understand the limitations of summary statistics lest they fall to Simpson's paradox.

Inversion: Dive deeper into the data by examining distributions, subgroups, and individual observations, in addition to aggregate statistics. 

- Consider statistics such as standard deviation, median vs. mean, and quantiles to get a sense of the data 
- Use histograms and density plots to identify skewness, multimodality, and potential outliers 
- Combine insights from aggregate statistics, distributions, subgroups to develop an understanding of the data

仅依赖汇总统计

汇总统计如均值和中位数可能掩盖数据中的重要模式、离群值和子组差异。AI 工程师应了解总结性统计数据的局限性，以避免陷入辛普森悖论。

解决方案：除了汇总统计，还应深入分析数据的细节和分布。

反向思考：除了整体统计数据，还可以通过查看数据分布、子群体以及个体观测值来深入研究数据。

- 考虑标准差、中位数与平均数以及分位数等统计数据来了解数据。
- 使用直方图和密度图来识别数据的偏态、多模态和潜在的异常值。
- 结合整体统计数据、数据分布和子群体的见解来全面理解数据。

### 04. Lack of Domain Understanding

Analyzing data without sufficient context can result in misinterpretations and irrelevant or impractical insights. AI engineers must develop a deep understanding of the domain they are working in to ensure their analyses and models are meaningful and applicable to real-world problems.

Inversion: Develop a strong understanding of the domain and stakeholders before working with data. - Engage with domain experts and stakeholders to learn about their challenges and goals - Read relevant literature and attend industry conferences to stay up-to-date on domain trends - Participate in domain-specific projects and initiatives to gain hands-on experience

缺乏领域理解

在没有足够背景知识的情况下分析数据可能会导致误解，并得出无关紧要或不切实际的结论。AI 工程师必须深入了解他们所工作的领域，以确保他们的分析和模型对实际问题具有意义和适用性。

反向思考：在处理数据之前，首先要深入了解领域和利益相关者。

- 与领域专家和利益相关者交流，了解他们的挑战和目标。
- 阅读相关文献并参加行业会议，以了解领域的最新趋势。
- 参与特定领域的项目和计划，以获得实际操作经验。

### 05. Improper Testing Splits

Inappropriately splitting data can lead to biased or overly optimistic evaluations of model performance. Data literate AI engineers must use appropriate techniques like stratification and cross-validation to ensure their models are properly evaluated and generalizable.

Inversion: Use appropriate data splitting techniques to ensure unbiased and reliable model evaluations. 

- Use stratified sampling to ensure balanced representation of key variables in train/test splits 
- Employ cross-validation techniques to assess model performance across multiple subsets of data 
- Consider time-based splitting for time-series data to avoid leakage and ensure temporal validity

不正确的测试数据划分

不适当地划分数据会导致对模型性能的评估偏差或过于乐观。具备数据素养的 AI 工程师必须使用适当的技术（如分层抽样和交叉验证）来确保他们的模型得到正确评估并具有普遍性。

反向思考：使用适当的数据划分技术以确保无偏且可靠的模型评估。

- 使用分层抽样确保训练 / 测试集划分中关键变量的平衡表示。
- 使用交叉验证技术评估模型在多个数据子集上的表现。
- 对于时间序列数据，考虑基于时间的划分以避免数据泄漏并确保时间有效性。

### 06. Disregarding Data Drift

Ignoring changes in data distribution over time can cause models to become less accurate and relevant. AI engineers must be aware of the potential for data drift and take steps to monitor and address it, such as regularly evaluating model performance on new data and updating models as needed.

Inversion: Monitor and address data drift to maintain model accuracy and relevance over time. 

- Implement data drift detection methods, such as statistical tests or model-based approaches 
- Establish a schedule for regularly evaluating model performance on new data 
- Develop strategies for updating models, such as retraining or incremental learning, when drift is detected

反向思考：忽视数据分布

随时间的变化会导致模型准确性和相关性下降。AI 工程师必须意识到数据漂移的可能性，并采取措施监控和处理。例如，定期评估模型在新数据上的表现，并根据需要更新模型。

监控和处理数据漂移以保持模型的准确性和相关性。

- 实施数据漂移检测方法，例如统计测试或基于模型的方法 
- 定期评估模型在新数据上的表现 
- 开发模型更新策略，例如在检测到漂移时进行再训练或增量学习

### 07. Confusing Correlation with Causation

Mistaking correlations for causal relationships can lead to incorrect conclusions and poor decision-making. Data literate AI engineers must understand the limitations of correlational analyses and use appropriate techniques like experimentation and causal inference to establish causal relationships.

Inversion: Understand the difference between correlation and causation, and use appropriate techniques to establish causal relationships. - Use directed acyclic graphs (DAGs) to represent and reason about causal relationships - Employ techniques like randomized controlled trials (RCTs) or natural experiments to establish causality - Apply causal inference methods, such as propensity score matching or instrumental variables, when RCTs are not feasible

混淆相关性和因果关系

将相关性误认为因果关系会导致错误结论和糟糕决策。AI 工程师必须了解相关分析的局限性，并使用合适的技术（如实验和因果推断）来建立因果关系。

反向思考：理解相关性和因果关系的区别，并使用适当的技术来建立因果关系。

- 使用有向无环图（DAGs）来表示和推理因果关系 
- 采用随机对照试验（RCTs）或自然实验等技术来建立因果关系 
- 当 RCTs 不可行时，应用因果推断方法，例如倾向评分匹配或工具变量

### 08. Neglecting Data Privacy and Security

Mishandling sensitive data can breach trust, violate regulations, and harm individuals. AI engineers must prioritize data privacy and security, following best practices and regulations to protect sensitive information and maintain trust with stakeholders.

Inversion: Prioritize data privacy and security, following best practices and regulations. 

- Familiarize yourself with relevant data privacy regulations, such as GDPR or HIPAA 
- Implement secure data storage and access controls, such as encryption and role-based access 
- Conduct regular privacy impact assessments and security audits to identify and address vulnerabilities

忽视数据隐私和安全

处理不当的敏感数据可能会破坏信任、违反法规并伤害个人。AI 工程师必须优先考虑数据隐私和安全，遵循最佳实践和法规来保护敏感信息并维护与利益相关者的信任。

反向思考：注重数据隐私和安全，遵循最佳实践和相关法规。

- 熟悉 GDPR 或 HIPAA 等相关数据隐私法规
- 实施安全的数据存储和访问控制措施，如加密和基于角色的访问控制
- 定期进行隐私影响评估和安全审计，以发现和解决漏洞

### 09. Overfitting Models

Building overly complex models that memorize noise instead of learning generalizable patterns can limit a model's ability to perform well on new data. Data literate AI engineers must use techniques like regularization, cross-validation, and model simplification to prevent overfitting and ensure their models are robust and generalizable.

Inversion: Use techniques to prevent overfitting and ensure models are robust and generalizable. 

- Apply regularization techniques, such as L1/L2 regularization or dropout, to constrain model complexity 
- Use cross-validation to assess model performance on unseen data and detect overfitting 
- Consider model simplification techniques, such as feature selection or model compression, to reduce complexity

防止模型过拟合

构建过于复杂的模型可能会记住数据中的噪音而非可泛化的模式，从而限制模型在新数据上的表现。AI 工程师应使用正则化、交叉验证和模型简化等技术来防止过拟合，确保模型的健壮性和泛化能力。

反向思考：防止过拟合以确保模型的健壮性和泛化能力。

- 采用正则化技术，如 L1/L2 正则化或 dropout，以限制模型的复杂性
- 使用交叉验证评估模型在未见数据上的表现，检测过拟合
- 考虑使用特征选择或模型压缩等模型简化技术，降低复杂性

### 10. Unfamiliarity with Evaluation Metrics

Misunderstanding or misusing evaluation metrics can lead to suboptimal model selection and performance. AI engineers must have a deep understanding of various evaluation metrics and their appropriate use cases to ensure they are selecting the best models for their specific problems.

Inversion: Develop a strong understanding of evaluation metrics and their appropriate use cases. 

- Learn about common evaluation metrics, such as accuracy, precision, recall, and F1-score, and their trade-offs 
- Understand the implications of class imbalance and how it affects metric interpretation 
- Select evaluation metrics that align with the specific goals and constraints of your problem domain

对评估指标的陌生感

误解或误用评估指标可能导致模型选择和性能不理想。AI 工程师需深入理解各种评估指标及其适用场景，以便为具体问题选择最佳模型。

反向思考：深入了解评估指标及其适用场景。

- 学习常见评估指标，如准确率、精确率、召回率和 F1 分数及其权衡
- 理解类不平衡对指标解释的影响
- 选择与问题领域的具体目标和约束相符的评估指标

### 11. Ignoring Sampling Bias

Failing to account for sampling bias can lead to models that perform poorly on underrepresented groups and perpetuate inequalities. Data literate AI engineers must be aware of potential sampling biases and use techniques like stratified sampling and oversampling to ensure their models are fair and inclusive.

Inversion: Be aware of sampling bias and use techniques to ensure models are fair and inclusive. - Analyze the representativeness of your data and identify potential sampling biases - Use stratified sampling to ensure balanced representation of key demographic variables - Apply techniques like oversampling or synthetic data generation to address underrepresentation

忽略采样偏差 

未能考虑抽样偏差可能导致模型在代表性不足的群体上表现不佳，并加剧不平等现象。具有数据素养的 AI 工程师必须意识到这些潜在问题，并使用分层抽样和过采样等技术来确保模型的公平和包容。

反向思考：工程师应注意抽样偏差，使用技术确保模型的公平和包容。

- 分析数据的代表性，识别潜在的抽样偏差 
- 使用分层抽样确保关键人口变量的平衡 
- 通过过采样或合成数据生成技术解决代表性不足的问题。

### 12. Disregarding Interpretability and Explainability

Focusing solely on performance without considering the ability to understand and explain model decisions can limit trust and accountability. AI engineers must prioritize interpretability and explainability, using techniques like feature importance analysis and model-agnostic explanations to ensure their models are transparent and understandable.

Inversion: Prioritize interpretability and explainability to ensure models are transparent and understandable. - Use interpretable models, such as decision trees or linear models, when appropriate - Apply feature importance analysis to understand the key drivers of model predictions - Employ model-agnostic explanation techniques, such as SHAP or LIME, to provide insights into individual predictions

By avoiding these ten common pitfalls and embracing their inversions, AI engineers can develop strong data literacy skills and create reliable, effective, and responsible AI systems. Data literacy is an essential competency for AI engineers, enabling them to navigate the complex landscape of data-driven decision-making and model development with confidence and integrity.

忽视可解释性和解释能力

仅关注性能而忽视模型决策的理解和解释可能会限制信任和问责。AI 工程师应优先考虑可解释性和解释能力，使用特征重要性分析和模型无关的解释技术，确保模型透明且易于理解。

反向思考：优先考虑可解释性和解释能力，确保模型透明且易于理解。

- 在适当情况下使用可解释的模型，如决策树或线性模型 
- 通过特征重要性分析理解模型预测的关键驱动因素 
- 使用模型无关的解释技术，如 SHAP 或 LIME，提供对个体预测的见解。

通过避免这十个常见陷阱并采用相应的反转策略，AI 工程师可以发展强大的数据素养技能，创建可靠、有效且负责任的 AI 系统。数据素养是 AI 工程师的基本能力，使他们能够在数据驱动的决策和模型开发中自信且诚信地前行。