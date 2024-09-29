import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# Data for illumination and noise
data = np.array([
    [122.8,60.5],
    [130, 62.4],
    [125, 61.5],
    [117, 63.7],
    [150, 61.3],
    [140.3, 61.8], 
    [135, 61.5], 
    [128, 61.5], 
    [100, 60.5],
    [120, 62]
])

illumination, noise = data[:, 0].reshape(5, 2), data[:, 1].reshape(5, 2)

# Averages
avg_illumination, avg_noise = np.mean(illumination), np.mean(noise)

# Create subplots
fig, ax = plt.subplots(1, 3, figsize=(18, 6))

# Heatmap for illumination
sns.heatmap(illumination, cmap='Oranges', annot=True, fmt='.1f', ax=ax[0], cbar=True, linewidths=1, linecolor='gray')
ax[0].set_title('Illumination (Lux)', fontsize=16)
ax[0].set_xticklabels(['Col 1', 'Col 2'], fontsize=12)
ax[0].set_yticklabels(['Row 1', 'Row 2', 'Row 3', 'Row 4', 'Row 5'], fontsize=12)

# Heatmap for noise
sns.heatmap(noise, cmap='Blues', annot=True, fmt='.1f', ax=ax[1], cbar=True, linewidths=1, linecolor='gray')
ax[1].set_title('Noise Levels (dB)', fontsize=16)
ax[1].set_xticklabels(['Col 1', 'Col 2'], fontsize=12)
ax[1].set_yticklabels(['Row 1', 'Row 2', 'Row 3', 'Row 4', 'Row 5'], fontsize=12)

# Bar plot for averages
labels, averages = ['Avg "E" (Lux)', 'Avg Noise (dB)'], [avg_illumination, avg_noise]
ax[2].barh(labels, averages, color=['orange', 'blue'])
for i, v in enumerate(averages):
    ax[2].text(v + 2, i, f"{v:.1f}", va='center', fontsize=12)
ax[2].set_title('Average Values', fontsize=16)

plt.tight_layout()
plt.show()
