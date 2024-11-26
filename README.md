# Quality of Wine Analysis Report 🍷

**Course**: Math 4322: Introduction to Data Science and Machine Learning  
**Instructor**: Dr. Cathy Poliak  
**Group**: Arjun Karnani, Dhanush Kumar Selvaraj Kumar, Naumi Aparanji, Saptarshi De, Shruthi Yenamagandla  
**Date**: November 26, 2024  

---

## Table of Contents
1. [Introduction](#introduction)  
2. [Dataset Description](#dataset-description)  
3. [Research Question](#research-question)  
4. [Methods](#methods)  
5. [Results](#results)  
6. [Conclusion](#conclusion)

---

## Introduction  
This project analyzes the **Red Wine Quality dataset** from Portugal’s Vinho Verde region, focusing on predicting wine quality based on physicochemical properties like acidity, sugar content, and alcohol.  

**Key Question**: *Can we predict the quality of red wine using its chemical properties?*

---

## Dataset Description  
- **Inputs**: Fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, sulfur dioxide, density, pH, sulfates, alcohol.  
- **Output**: Quality rating (0–10).  

---

## Methods  
### Models Used:  
1. **Linear Regression**:  
   - Quantifies linear relationships between predictors and wine quality.  
   - Significant variables include alcohol, volatile acidity, and sulphates.  

2. **Tree-Based Models**:  
   - Decision Trees (Basic & Pruned).  
   - Bagging and Random Forests for enhanced accuracy.  

### Tools:  
- **Languages**: R  
- **Metrics**: Mean Squared Error (MSE), feature importance.

---

## Results  
- **Linear Regression**: Adjusted R² = 0.36. Alcohol emerged as the most significant predictor.  
- **Random Forests**: Provided the lowest MSE and highest accuracy, making it the most effective model for this dataset.  

---

## Conclusion  
Understanding the key factors influencing wine quality helps winemakers optimize production and ensure consistency. Our analysis shows Random Forests outperform Linear Regression, with alcohol, volatile acidity, and sulphates as critical features.  

---

## Authors  
**Group 10**: Arjun Karnani, Dhanush Kumar Selvaraj Kumar, Naumi Aparanji, Saptarshi De, Shruthi Yenamagandla  

