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
The domain is divided into $7$ non-overlapping subdomains: $\bar{\omega} = \bigcup\limits_{i=1}^{7} \bar{\omega}_{i}$.

![alt text](https://github.com/niravshah241/elastodynamics_LSTM_PINN/blob/main/domain.png)

The **balance of linear momentum** in strong form for a given source term $\overrightarrow{b}$ is given by:
$$\rho \overrightarrow{\ddot{u}} = \nabla \cdot \overline{\overline{\sigma}} + \rho \overrightarrow{b} \ , \ \overrightarrow{\dot{u}} = \frac{\partial \overrightarrow{u}}{\partial t} \ , \ \overrightarrow{\ddot{u}} = \frac{\partial^2 \overrightarrow{u}}{\partial t^2} \ \text{in} \ \omega \times (0,T].$$
Above equation is solved using **Finite Element Method** in space and **generalised-**$\alpha$ **method** in time to compute the displacement field $\overrightarrow{u}(x,t)$ at given point $x$ and time $t$. The material properties (Lam\'e parameters $\lambda,\mu$ or Young modulus $E$ and Poisson ratio $\nu$) vary across each subdomain characterising different material constituting the subdomain, i.e.:
$$E=E_{i} \ , \ \nu = \nu_{i} \ , \ \lambda = \lambda_{i} = \frac{E_{i} \nu_{i}}{(1 + \nu_{i})(1 - 2 \nu_{i})} \ , \ \mu_{i} = \frac{E_{i}}{2(1+\nu_{i})} \ \text{for} \ x \in \omega_{i}.$$

The **stress tensor** $\overline{\overline{\sigma}}$ and **strain tensor** $\overline{\overline{\varepsilon}}$ are given as:
$$\overline{\overline{\sigma}} (\overrightarrow{u}) = \lambda tr(\overline{\overline{\varepsilon}}) \overline{\overline{I}} + 2 \mu \overline{\overline{\varepsilon}} \ , \ \overline{\overline{\varepsilon}} (\overrightarrow{u}) = \frac{\left(\nabla \overrightarrow{u} + \nabla \overrightarrow{u}^T \right)}{2} \ .$$

The **normal force** $\sigma_n$ and **tangential force** $\overrightarrow{\sigma_t}$ defined by:
$$\sigma_n = (\overline{\overline{\sigma}} \overrightarrow{n})\cdot \overrightarrow{n} \ , \ \overrightarrow{\sigma}_t = \overline{\overline{\sigma}} \overrightarrow{n} - \sigma_n \overrightarrow{n} \ .$$

The **Boundary conditions** are given by:
$$\text{(Hydrostatic pressure) On} \ \gamma_{sf}: \overline{\overline{\sigma}} \cdot \overrightarrow{n} = -p(t) \overrightarrow{n} \ \text{in} \ \omega \times (0,T] \ ,$$

$$\text{(No force) On} \ \gamma_{out}: \overline{\overline{\sigma}} \cdot \overrightarrow{n} = \overrightarrow{0} \ \text{in} \ \omega \times (0,T] \ ,$$

$$\text{(Symmetry boundary) On} \ \gamma_{s}: \overrightarrow{u} \cdot \overrightarrow{n} = 0 \ , \ \overrightarrow{\sigma}_t = \overrightarrow{0} \ , \ \text{in} \ \omega \times (0,T] \ ,$$

$$\text{(Zero displacement) On} \ \gamma_{-}: \overrightarrow{u} = \overrightarrow{0} \ \text{in} \ \omega \times (0,T] \ ,$$

$$\text{(Restricted displacement) On} \ \gamma_{+}: \overrightarrow{u} \cdot \overrightarrow{n} = 0 \ , \ \overrightarrow{\sigma}_t = \overrightarrow{0} \ , \ \text{in} \ \omega \times (0,T] \ .$$

The **initial conditions** correspond to the body at continuous rest:
$$\overrightarrow{u} = \overrightarrow{0} \ , \overrightarrow{\dot{u}} = \overrightarrow{0} \ , \ \overrightarrow{\ddot{u}} = \overrightarrow{0} \ \text{in} \ \omega \times {0} \ .$$

The corresponding **weak form** can be expressed as, find $\overrightarrow{u} \in \mathbb{V}$ such that: 
$$m(\overrightarrow{\ddot{u}},\overrightarrow{v}) + c(\overrightarrow{\dot{u}},\overrightarrow{v}) + k(\overrightarrow{u},\overrightarrow{v}) = l(\overrightarrow{v}) \ , \ \forall \overrightarrow{v} \in \mathbb{V} \ ,$$
$$m(\overrightarrow{\ddot{u}},\overrightarrow{v}) = \int_{\omega} \rho \overrightarrow{\ddot{u}} \cdot \overrightarrow{v} dx \ , $$
$$k(\overrightarrow{u},\overrightarrow{v}) = \int_{\omega} \overline{\overline{\sigma}} : \overline{\overline{\varepsilon}} dx \ , $$
$$l(\overrightarrow{v}) = \int_{\omega} \rho \overrightarrow{b} \cdot \overrightarrow{v} dx + \int_{\gamma_{sf} \cup \gamma_{out} \cup \gamma_{-}} \left(\overline{\overline{\sigma}} \cdot \overrightarrow{n}\right) \cdot \overrightarrow{v} ds$$

The damping term $c(\overrightarrow{\dot{u}},\overrightarrow{v})$ is chosen as linear combination of the mass matrix and the stiffness matrix (Rayleigh damping).

The **discrete form** of the equation can be written as:

$$[M] \lbrace \overrightarrow{\ddot{u}} \rbrace_{n+1-\alpha_m} + [C] \lbrace \overrightarrow{\dot{u}} \rbrace_{n+1-\alpha_f} + [K] \lbrace \overrightarrow{u} \rbrace_{n+1-\alpha_m} = F({t}_{n+1-\alpha_f}) \ ,$$

$$\text{Rayleigh damping with specified coefficients $\eta_m$ and $\eta_k$}[C] = \eta_m [M] + \eta_k [K]$$

$$t_0=0,t_1,\ldots,t_N=T \ , \ \Delta t = \frac{T}{(N)} \ ,$$

$$X_{n+1-\alpha} = (1 - \alpha) X_{n+1} + \alpha X_n \,$$

The velocity and displacement are approximated as:

$$\lbrace \overrightarrow{u} \rbrace_{n+1} = \lbrace \overrightarrow{u} \rbrace_{n} + \Delta t \lbrace \overrightarrow{\dot{u}} \rbrace_{n} + \frac{\Delta t^2}{2} \left((1-2\beta) \lbrace \overrightarrow{\ddot{u}} \rbrace_{n} + 2 \beta \lbrace \overrightarrow{\ddot{u}}  \rbrace_{n+1} \right)$$

At each time step the elastic enegy and Kinetic energy are givem by:

$$\text{Elastic energy} \ E_{elas}(t) = \int_{\omega} \frac{1}{2} \overline{\overline{\sigma}}(\overrightarrow{u}) : \overline{\overline{\varepsilon}}(\overrightarrow{u}) dx \ ,$$

$$\text{Kinetic energy} \ E_{kin}(t) = \int_{\omega} \frac{1}{2} \rho \overrightarrow{\dot{u}} \overrightarrow{\dot{u}} dx \ ,$$

The energy transfer into or out of the system till time $T$ is given by:

$$\text{Damping energy} \ E_{damp} = \int\limits_{0}^{T} c(\dot{\overrightarrow{u}},\dot{\overrightarrow{u}}) dt \ ,$$

$$\text{External work done on the system} \ E_{ext} = \int\limits_{0}^{T} l(\overrightarrow{u}) dt \ .$$

The total energy of the system is the sum of all energies:

$$\text{Total energy} \ E_{tot} = E_{elas} + E_{kin} + E_{damp} + E_{ext} \ .$$

### 4. Numerical results

$\eta_m = 0 , \eta_k = 0 , \alpha_f = 0 \ , \alpha_m = 0 \ , \ \gamma = \frac{1}{2} + \alpha_f - \alpha_m \ , \ \beta = \frac{(\gamma+0.5)^2}{4}$

* **Displacement evolution**

![Alt Text](https://github.com/niravshah241/elastodynamics_LSTM_PINN/blob/main/solution_field/displacement_evolution.gif)

| Energy evolution | Von Mises stress evolution |
| ------------- | ------------- |
|![alt text](https://github.com/niravshah241/elastodynamics_LSTM_PINN/blob/main/solution_field/energies.png)|![alt text](https://github.com/niravshah241/elastodynamics_LSTM_PINN/blob/main/solution_field/von_mises_stress.png)|

<!-- \alpha_f, \alpha_m, \eta_m, \eta_k,  -->
<!-- Displacement, Stress, Energy, Von mises stress  -->

<!-- https://user-images.githubusercontent.com/18644277/182047892-10b27e0f-ca49-464e-bfc3-479a046d73fc.mp4 -->

### 5. Authors and contributors

This code has been developed by [Nirav Shah] [email](mailto:niravshahcolab@gmail.com).

### 6. How to cite

	@misc{elastodynamics_LSTM_PINN,
	key          = {ElastodynamicsLSTMPINN},
	author       = {Shah, N.V.},
	title        = {{Long Short Term Memory based Physics Informed Neural Network for elastodynamics problem, Version 0.1}},
	month        = July,
	url          = {https://github.com/niravshah241/elastodynamics_LSTM_PINN.git},
	year         = 2022
	}

### 7. License

* **FEniCS** is freely available under the GNU LGPL, version 3.
<!--  (* **PyTorch** has a BSD-style license (https://github.com/pytorch/pytorch/blob/master/LICENSE)) -->
* **Matplotlib** only uses BSD compatible code, and its license is based on the PSF license. Non-BSD compatible licenses (e.g., LGPL) are acceptable in matplotlib toolkits.

Accordingly, this code is freely available under the GNU LGPL, version 3 and BSD-license.

### 8. Disclaimer
In downloading this SOFTWARE you are deemed to have read and agreed to the following terms: This SOFT- WARE has been designed with an exclusive focus on civil applications. It is not to be used for any illegal, deceptive, misleading or unethical purpose or in any military applications. This includes ANY APPLICATION WHERE THE USE OF THE SOFTWARE MAY RESULT IN DEATH, PERSONAL INJURY OR SEVERE PHYSICAL OR ENVIRONMENTAL DAMAGE. Any redistribution of the software must retain this disclaimer. BY INSTALLING, COPYING, OR OTHERWISE USING THE SOFTWARE, YOU AGREE TO THE TERMS ABOVE. IF YOU DO NOT AGREE TO THESE TERMS, DO NOT INSTALL OR USE THE SOFTWARE.
