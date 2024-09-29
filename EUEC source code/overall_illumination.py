import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# Actual_data
data = np.array([
    [146, 62],   # Region 1
    [136, 62],   # Region 2
    [144, 61.7],   # Region 3
    [167, 64],   # Region 4
    [82, 61],   # Region 5
    [160.5, 62.6],   # Region 6
    [160, 71],   # Region 7
    [160, 62.6],   # Region 8
    [163.5, 60.9],   # Region 9
    [140, 63],   # Region 10
    [158.3, 62.8],   # Region 11,
    [142, 62],   # Region 12
    [104, 60],   # Region 13,
    [101, 60.7],   # Region 14
    [96, 63]    # Region 15
])

# Reshape data to fit a 5x3 grid for both illumination and noise
illumination = data[:, 0].reshape(5, 3)
noise = data[:, 1].reshape(5, 3)

# Calculate the average illumination and noise levels
avg_illumination = np.mean(illumination)
avg_noise = np.mean(noise)

# Set up a figure for subplots
fig, ax = plt.subplots(1, 3, figsize=(22, 8))

# Labels for regions
regions = np.array([
    ['Region 1', 'Region 2', 'Region 3'],
    ['Region 4', 'Region 5', 'Region 6'],
    ['Region 7', 'Region 8', 'Region 9'],
    ['Region 10', 'Region 11', 'Region 12'],
    ['Region 13', 'Region 14', 'Region 15']
])

# Heatmap for illumination with reduced annotation font size
sns.heatmap(illumination, cmap='Oranges', annot=illumination, fmt='.1f', ax=ax[0], 
            cbar=True, linewidths=1, linecolor='gray', annot_kws={"size": 10})  # Smaller font size
ax[0].set_title('Illumination (Lux) in Each Region', fontsize=16)
ax[0].set_xticklabels(['Column 1', 'Column 2', 'Column 3'], fontsize=12)
ax[0].set_yticklabels(['Row 1', 'Row 2', 'Row 3', 'Row 4', 'Row 5'], fontsize=12)

# Heatmap for noise with reduced annotation font size
sns.heatmap(noise, cmap='Blues', annot=noise, fmt='.1f', ax=ax[1], 
            cbar=True, linewidths=1, linecolor='gray', annot_kws={"size": 10})  # Smaller font size
ax[1].set_title('Noise Levels (dB) in Each Region', fontsize=16)
ax[1].set_xticklabels(['Column 1', 'Column 2', 'Column 3'], fontsize=12)
ax[1].set_yticklabels(['Row 1', 'Row 2', 'Row 3', 'Row 4', 'Row 5'], fontsize=12)

# Average readings bar plot
labels = ['Average "E" (Lux)', 'Average Noise (dB)']
averages = [avg_illumination, avg_noise]

ax[2].barh(labels, averages, color=['orange', 'blue'])
ax[2].set_xlim(0, max(avg_illumination, avg_noise) * 1.2)  # Adjust limit to fit the bars nicely
for i, v in enumerate(averages):
    ax[2].text(v + 2, i, f"{v:.1f}", color='black', va='center', fontsize=12)
ax[2].set_title('Average Illumination & Noise', fontsize=16)
ax[2].tick_params(axis='y', labelsize=12)
ax[2].tick_params(axis='x', labelsize=12)

# Adjust layout for better spacing
plt.tight_layout()
plt.show()
