## LSTM PINN for elastodynamics ##

### 0. Introduction

This repository contains google colab based FEniCS implementation of the elastodynamics problem. This model will be further extended to include Physics Informed Neural Network (PINN) using Long Short-Term Memory (LSTM).

### 1. Prerequisites

We use **python** 3.6.9 as the programming language. In this project we use the libraries :
* **FEniCS** 2019.1.0 (www.fenicsproject.org)
* **Matplolib** 3.1.2 (www.matplotlib.org)
* **numpy** 1.17.4 (www.numpy.org)
<!--  (* **PyTorch** 1.5.1 (www.pytorch.org)) -->

The solutions are stored in **.pvd** format, which can later be viewed with **Paraview** (www.paraview.org).

### 2. Installation

Simply clone the public repository:

```
git clone https://github.com/niravshah241/elastodynamics_LSTM_PINN.git
```

### 3. Problem statement

![alt text](https://github.com/niravshah241/elastodynamics_LSTM_PINN/blob/main/domain.png)

### 4. Authors and contributors

This code has been developed by [Nirav Vasant Shah] [email](mailto:niravshahcolab@gmail.com).

### 5. How to cite

	@misc{elastodynamics_LSTM_PINN,
	key          = {ElastodynamicsLSTMPINN},
	author       = {Shah, N.V.},
	title        = {{Long Short Term Memory based Physics Informed Neural Network for elastodynamics problem, Version 0.1}},
	month        = July,
	url          = {https://github.com/niravshah241/elastodynamics_LSTM_PINN.git},
	year         = 2022
	}

### 6. License

* **FEniCS** is freely available under the GNU LGPL, version 3.
<!--  (* **PyTorch** has a BSD-style license (https://github.com/pytorch/pytorch/blob/master/LICENSE)) -->
* **Matplotlib** only uses BSD compatible code, and its license is based on the PSF license. Non-BSD compatible licenses (e.g., LGPL) are acceptable in matplotlib toolkits.

Accordingly, this code is freely available under the GNU LGPL, version 3 and BSD-license.

### 7. Disclaimer
In downloading this SOFTWARE you are deemed to have read and agreed to the following terms: This SOFT- WARE has been designed with an exclusive focus on civil applications. It is not to be used for any illegal, deceptive, misleading or unethical purpose or in any military applications. This includes ANY APPLICATION WHERE THE USE OF THE SOFTWARE MAY RESULT IN DEATH, PERSONAL INJURY OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE. Any redistribution of the software must retain this disclaimer. BY INSTALLING, COPYING, OR OTHERWISE USING THE SOFTWARE, YOU AGREE TO THE TERMS ABOVE. IF YOU DO NOT AGREE TO THESE TERMS, DO NOT INSTALL OR USE THE SOFTWARE.
