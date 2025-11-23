# ♟️ FBCA

This is the official code of the paper [FBCA: Flexible Besiege and Conquer Algorithm for Multi-Layer Perceptron Optimization Problems](https://doi.org/10.3390/biomimetics10110787).
\
The paper is published in Biomimetics, the link as: [https://doi.org/10.3390/biomimetics9060316](https://doi.org/10.3390/biomimetics10110787).
\
More information about our research can be found at www.jianhuajiang.com.


## 📃 Abstract
A Multi-Layer Perceptron (MLP), as the basic structure of neural networks, is an important
component of various deep learning models such as CNNs, RNNs, and Transformers. Nevertheless, MLP training faces significant challenges, with a large number of saddle points
and local minima in its non-convex optimization space, which can easily lead to gradient
vanishing and premature convergence. Compared with traditional heuristic algorithms
relying on a population-based parallel search, such as GA, GWO, DE, etc., the Besiege
and Conquer Algorithm (BCA) employs a one-spot update strategy that provides a certain
level of global optimization capability but exhibits clear limitations in search flexibility.
Specifically, it lacks fast detection, fast adaptation, and fast convergence. First, the fixed
sinusoidal amplitude limits the accuracy of fast detection in complex regions. Second, the
combination of a random location and fixed perturbation range limits the fast adaptation of
global convergence. Finally, the lack of a hierarchical adjustment under a single parameter
(BCB) hinders the dynamic transition from exploration to exploitation, resulting in slow
convergence. To address these limitations, this paper proposes a Flexible Besiege and
Conquer Algorithm (FBCA), which improves search flexibility and convergence capability
through three new mechanisms: (1) the sine-guided soft asymmetric Gaussian perturbation
mechanism enhances local micro-exploration, thereby achieving a fast detection response
near the global optimum; (2) the exponentially modulated spiral perturbation mechanism
adopts an exponential spiral factor for fast adaptation of global convergence; and (3) the
nonlinear cognitive coefficient-driven velocity update mechanism improves the convergence performance, realizing a more balanced exploration-exploitation process. In the IEEE
CEC 2017 benchmark function test, FBCA ranked first in the comprehensive comparison
with 12 state-of-the-art algorithms, with a win rate of 62% over BCA in 100-dimensional
problems. It also achieved the best performance in six MLP optimization problems, showing
excellent convergence accuracy and robustness, proving its excellent global optimization
ability in complex nonlinear MLP optimization training. It demonstrates its application
value and potential in optimizing neural networks and deep learning models.


## 🌳 Code Strucutre

```matlab
.
├── FBCA.m  % matlab code of FBCA
└── Readme.md
```

## 🧩 Citation

If you find this repository helpful, please consider citing our paper:
\
Bibtex:
```
@Article{biomimetics10110787,
AUTHOR = {Guo, Shuxin and Guo, Chenxu and Jiang, Jianhua},
TITLE = {FBCA: Flexible Besiege and Conquer Algorithm for Multi-Layer Perceptron Optimization Problems},
JOURNAL = {Biomimetics},
VOLUME = {10},
YEAR = {2025},
NUMBER = {11},
ARTICLE-NUMBER = {787},
URL = {https://www.mdpi.com/2313-7673/10/11/787},
ISSN = {2313-7673},
DOI = {10.3390/biomimetics10110787}
}
```
APA Style:
```
Guo, S., Guo, C., & Jiang, J. (2025). FBCA: Flexible Besiege and Conquer Algorithm for Multi-Layer Perceptron Optimization Problems. Biomimetics, 10(11), 787. https://doi.org/10.3390/biomimetics10110787
```
