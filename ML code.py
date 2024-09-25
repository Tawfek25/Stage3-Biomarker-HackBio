import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, accuracy_score, confusion_matrix
from sklearn.ensemble import RandomForestClassifier
import matplotlib.pyplot as plt
import seaborn as sns

################################################### Cleaning the data for model use ########################################################
data = pd.read_csv('breast_cancer_mp.csv')

variance_threshold = 0.01  # Modify as needed
numeric_data = data.iloc[:, 1:]  # Exclude the first column (gene IDs)
variance = numeric_data.var(axis=1)
high_variance_genes = data[variance > variance_threshold]
missing_threshold = 0.5 * numeric_data.shape[1]  # 50% of the 40 samples
non_zero_filtered_genes = high_variance_genes[(numeric_data == 0).sum(axis=1) <= missing_threshold]

cleaned_data = non_zero_filtered_genes
print(cleaned_data)
scaler = StandardScaler()
standardized_data = scaler.fit_transform(cleaned_data.iloc[:, 1:])
standardized_df = pd.DataFrame(standardized_data, columns=numeric_data.columns)
Labels = cleaned_data.iloc[:, 0]
normalized_df = pd.concat([Labels.reset_index(drop=True), standardized_df], axis=1)
print(Labels)
print(normalized_df.head())

# Create labels: 1 for metastatic (first 20 samples), 0 for primary (next 20 samples)
labels = [1] * 20 + [0] * 20  # First 20 are metastatic, next 20 are primary

# Convert labels to a DataFrame
labels_df = pd.DataFrame([labels], columns=normalized_df.columns[1:])  # Exclude gene IDs

# Concatenate the labels as a new row
normalized_df = pd.concat([normalized_df, labels_df], ignore_index=False)

# Rename the new row for clarity
normalized_df.index = list(normalized_df.index[:-1]) + ['Label']

# Inspect the final DataFrame with labels
print(normalized_df.tail())  # Display the last few rows for verification
normalized_df.to_csv("clean_data_bc_labled.csv", index=False)
Features = normalized_df.iloc[:-1, 1:]
labels = normalized_df.iloc[-1, 1:]
X_train, X_test, Y_train, Y_test = train_test_split(Features.T, labels, test_size=0.2, random_state=42)
# Inspect the shapes of the resulting sets
print(f'X_train shape: {X_train.shape}')
print(f'X_test shape: {X_test.shape}')
print(f'y_train shape: {Y_train.shape}')
print(f'y_test shape: {Y_test.shape}')

correlation = pd.Series(X_train.corrwith(pd.Series(Y_train)))
correlation_threshold = 0.3
selected_features = correlation[correlation.abs() > correlation_threshold].index
X_train_selected = X_train[selected_features]
X_test_selected = X_test[selected_features]

print(f'Selected X_Train shape: {X_train_selected}')
print(f'Selected X_Test shape: {X_test_selected}')
Y_train = Y_train.astype(int)
Y_test = Y_test.astype(int)

##################################################### random forest ######################################################

rf = RandomForestClassifier(random_state=42, n_estimators=100)
rf.fit(X_train_selected, Y_train)
rf_prediction = rf.predict(X_test_selected)
rf_accuracy = accuracy_score(Y_test, rf_prediction)
conf_matrix = confusion_matrix(Y_test, rf_prediction)
print(f'Random Forest Accuracy: {rf_accuracy * 100:.2f}%')


################################################### Feature Importance Plot #######################################################
# Plot the feature importance after fitting the Random Forest model
importances = rf.feature_importances_
indices = np.argsort(importances)[-20:]  # Top 20 features

plt.figure(figsize=(10,6))
plt.barh(range(len(indices)), importances[indices], align='center')
plt.yticks(range(len(indices)), [X_train.columns[i] for i in indices])
plt.xlabel('Feature Importance Score')
plt.ylabel('genes ID')
plt.title('Top 20 Feature Importances in Random Forest')
plt.show()


##########################################Confusion Matrix Heatmap#########################
plt.figure(figsize=(6, 4))
sns.heatmap(conf_matrix, annot=True, fmt="d", cmap="Blues", cbar=False)
plt.title('Confusion Matrix')
plt.xlabel('Predicted Labels')
plt.ylabel('True Labels')
plt.show()

print(conf_matrix)


class_report = classification_report(Y_test, rf_prediction, zero_division=1)
print('Classification Report:')
print(class_report)
