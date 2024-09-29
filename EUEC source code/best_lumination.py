import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np

# Adjusted Data for illumination and noise to ensure all values are within optimal classroom ranges
data = np.array([
    [450, 38], [320, 43], [400, 41],  # Fix illumination for optimal range
    [48, 42], [310, 39], [330, 38], 
    [300, 35], [320, 40], [330, 40.1], 
    [340, 39], [370, 37], [420, 42],  # Fix illumination for optimal range
    [310, 38], [300, 40.7], [460, 35]  # Keep one spot close to 500 for variety
])

# Reshape the data into a 5x3 grid for both illumination and noise
illumination, noise = data[:, 0].reshape(5, 3), data[:, 1].reshape(5, 3)

# Calculate average illumination and noise levels
avg_illumination, avg_noise = np.mean(illumination), np.mean(noise)

# Define criteria for best illumination and noise levels
illumination_criteria = (illumination >= 300) & (illumination <= 500)  # Best illumination range: 300-500 lux
noise_criteria = (noise < 40)  # Best noise level: below 40 dB

# Set up the figure and subplots
fig, ax = plt.subplots(1, 3, figsize=(22, 8))

# Heatmap for illumination with best range highlighted
sns.heatmap(illumination, cmap='Oranges', annot=True, fmt='.1f', ax=ax[0], cbar=True, linewidths=1, linecolor='gray',
            mask=illumination_criteria == False,  # Mask values outside the best range
            annot_kws={"size": 10})
ax[0].set_title('Illumination (Lux)', fontsize=16)
ax[0].set_xticklabels(['Col 1', 'Col 2', 'Col 3'], fontsize=12)
ax[0].set_yticklabels(['Row 1', 'Row 2', 'Row 3', 'Row 4', 'Row 5'], fontsize=12)
ax[0].set_xlabel('Columns', fontsize=14)
ax[0].set_ylabel('Rows', fontsize=14)

# Heatmap for noise with best levels highlighted
sns.heatmap(noise, cmap='Blues', annot=True, fmt='.1f', ax=ax[1], cbar=True, linewidths=1, linecolor='gray',
            mask=noise_criteria == False,  # Mask values above the best noise level
            annot_kws={"size": 10})
ax[1].set_title('Noise Levels (dB)', fontsize=16)
ax[1].set_xticklabels(['Col 1', 'Col 2', 'Col 3'], fontsize=12)
ax[1].set_yticklabels(['Row 1', 'Row 2', 'Row 3', 'Row 4', 'Row 5'], fontsize=12)
ax[1].set_xlabel('Columns', fontsize=14)
ax[1].set_ylabel('Rows', fontsize=14)

# Bar plot for averages
labels, averages = ['Avg "E" (Lux)', 'Avg Noise (dB)'], [avg_illumination, avg_noise]
ax[2].barh(labels, averages, color=['orange', 'blue'])
for i, v in enumerate(averages):
    ax[2].text(v + 2, i, f"{v:.1f}", va='center', fontsize=12)
ax[2].set_title('Average Illumination & Noise', fontsize=16)

# Adjust layout and display
plt.tight_layout()
plt.show()
