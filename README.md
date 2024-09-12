# The Effect of Prison Population Size on Crime Rates: Evidence from Prison Overcrowding Legislation

## 1. Introduction

Prison overcrowding has long been a critical issue within the criminal justice system. As prison populations continue to grow, policymakers and researchers aim to understand the relationship between prison population size and crime rates. This study investigates the effects of prison population size on crime rates, focusing specifically on the impact of prison overcrowding legislation.

Previous research offers mixed findings. Some studies suggest that larger prison populations deter crime by incapacitating offenders, while others argue that overcrowded prisons may exacerbate criminal behavior due to negative effects of incarceration, such as increased recidivism and the spread of criminal behavior within correctional facilities.

This study employs a rigorous empirical approach to examine the causal relationship between prison population size and crime rates, with a particular emphasis on legislation aimed at alleviating prison overcrowding. By analyzing data on prison populations and crime rates before and after the implementation of such legislation, we aim to shed light on the potential impact of policy interventions on crime trends.

### Central Hypothesis

**How do legislative decisions regarding prison overcrowding and economic indicators influence crime rate growth?**

---

## 2. Data

We utilize **PRISON.RAW**, a dataset sourced from S.D. Levitt's 1996 paper, *The Effect of Prison Population Size on Crime Rates: Evidence from Prison Overcrowding Legislation*. This dataset provides a comprehensive compilation of prison population statistics and corresponding crime rates across various jurisdictions from 1980 to 1993.

### 2.1 Description of Variables

- **State**: Alphabetical representation of the jurisdiction or state under consideration. 'DC' represents the District of Columbia.
- **Year**: Year of observation, ranging from 1980 to 1993.
- **Govelec**: Binary variable indicating whether a gubernatorial election occurred (1) or not (0) in the specified year.
- **Black**: Proportion of the population that is Black.
- **Metro**: Proportion of the population residing in metropolitan areas.
- **Unem**: Proportion of the population that is unemployed.
- **Criv**: Violent crimes per 100,000 residents.
- **Crip**: Property crimes per 100,000 residents.
- *(Further variables are listed similarly)*

---

## 3. Data Visualization and Exploration

### 3.1 Histogram of Crime Rate (Criv)

The histogram illustrates the distribution of crime rates across different regions or states, providing an overview of the frequency distribution. The data shows a right-skewed distribution, indicating that while most regions maintain lower crime rates, a few regions have significantly higher rates.



### 3.2 Time Series Plot of Crime Rate (Criv) Over Years

This time series plot showcases how crime rates have evolved over time. The general trend is an increasing trajectory, although certain years exhibit fluctuations.



### 3.3 Scatter Plot: Crime Rate (Criv) vs. Unemployment Rate (Unem)

The scatter plot highlights the relationship between crime rates and unemployment rates. While higher crime rates appear at higher unemployment levels, the data suggests no clear linear relationship between these two variables.


### 3.4 Correlation Heatmap

We constructed a correlation matrix to examine the pairwise relationships between the variables. Here are key insights:

- **Prison population (pris)** and **Black population (black)** show a strong positive correlation (0.71).
- **Crime rate (criv)** and **prison population (pris)** have a strong positive correlation (0.78).


---

## 4. Crime Rate Determination Model

### 4.1 Stepwise Model Selection

We employed stepwise regression based on AIC (Akaike Information Criterion) to select a model. The significant predictors included:

- Prison population (pris)
- State
- Black population (black)
- Unemployment rate (unem)
- Police per capita (polpc)
- Metropolitan area population (metro)

### 4.2 Multicollinearity Check

We checked for multicollinearity using the Variance Inflation Factor (VIF). No variables showed severe multicollinearity (VIF > 5).

### 4.3 Initial Model Performance

The initial linear regression model showed an adjusted R-squared value of **0.8325**, indicating a strong fit with the data.

### 4.4 Fixed and Random Effects Models

Both the fixed and random effects models revealed a significant positive association between prison population size and crime rates.

**Fixed Effects Model**: 
- Coefficient for prison population: positive and statistically significant (p < 0.001)
- R-squared: 0.43078

**Random Effects Model**:
- Coefficient for prison population: positive and statistically significant (p < 0.001)
- R-squared: 0.51231

---

## 5. Further Analysis

### 5.1 Addressing Endogeneity with Instrumental Variables

To account for potential endogeneity, we used instrumental variable regression. The instruments (`final1` and `final2`) showed significant negative coefficients, confirming the robustness of the findings.

---

## 6. Report Summary

### 6.1 Main Findings

- **Prison population**: A one-unit increase in prison population is associated with a decrease in crime growth by **0.1809 units**, on average, with high statistical significance (p-value < 0.001).
- **Per capita income**: Higher income levels are associated with increased reported crime.
- **Multicollinearity**: No severe multicollinearity issues were identified.

---

## 7. Overall Inferences

Our findings suggest that policies aimed at increasing imprisonment may serve as a deterrent to crime. However, socioeconomic factors like per capita income and urbanization also significantly influence crime rates. A comprehensive approach that addresses both punitive measures and socioeconomic disparities is essential for effective crime reduction.

---

