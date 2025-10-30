"""
Generate all figures for the paper
"""
import matplotlib.pyplot as plt
import numpy as np

# Configure for publication quality
plt.rcParams['font.family'] = 'serif'
plt.rcParams['font.size'] = 10
plt.rcParams['figure.dpi'] = 300

def create_example_figure():
    """Create an example figure"""
    fig, ax = plt.subplots(figsize=(6, 4))
    x = np.linspace(0, 10, 100)
    y = np.sin(x)
    ax.plot(x, y, linewidth=2)
    ax.set_xlabel('X axis')
    ax.set_ylabel('Y axis')
    ax.grid(alpha=0.3)
    plt.tight_layout()
    plt.savefig('../figures/findings/example.pdf', bbox_inches='tight')
    plt.close()
    print("Created example figure")

if __name__ == "__main__":
    print("Generating figures...")
    create_example_figure()
    print("All figures generated!")