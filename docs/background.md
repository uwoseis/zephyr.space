# Background

Exploration seismology involves applying seismic imaging and inversion techniques to build physical property models for the Earth and to delineate subsurface features. Seismic Full-Waveform Inversion (FWI) is concerned with iteratively improving on a prexisting model of the Earth, in order to better fit seismic measurements recorded in the field. Field measurements (data) are digital recordings of pressure (with hydrophones) or particle velocity (with geophones) at a number of different locations (receivers). In exploration seismology, source enegry typically comes from vibroseis and/or dynamite (onland), or airguns (offshore). One trace exists for each pair of source and receiver.

## Forward modelling

Seismic data are expressions of signals being propagated as waves, and wave equations describe (simplified) physics that model the behaviour of these waves. The constant-density 3D acoustic wave equation takes the form:

$$\left[\nabla^2 - \frac{1}{\mathbf{c}\left(x,y,z\right)}\frac{\partial^2}{\partial t^2}\right]\mathbf{p}\left(x,y,z;t\right) = \mathbf{s}\left(x,y,z;t\right)$$

where $\mathbf{p}$ is the pressure wavefield arising from a source distribution $\mathbf{s}$ in a model described by the propagation velocity $\mathbf{c}$. All three quantities are scalar fields that may vary in all three spatial dimensions $(x,y,z)$; both $\mathbf{s}$ and $\mathbf{p}$ also vary with time $t$. In many cases, it may be convenient to work in the temporal *frequency domain*, which requires taking the Fourier transform of the wave equation above. The resulting 3D acoustic Helmholtz equation,

$$\left[\nabla^2 + \frac{\omega^2}{\mathbf{c}^2\left(x,y,z\right)}\right]\mathbf{P}\left(x,y,z; \omega\right) = \mathbf{S}\left(x,y,z; \omega\right),$$

describes the behaviour of a *time-harmonic* wavefield $\mathbf{P}$ as a function of the angular frequency $\omega = 2\pi f$, with temporal frequency $f$.

### Analytical case

In the case of a constant velocity $c$ for all locations $(x,y,z)$, the analytical response of this system is straightforwardly written. We may simplify by choosing to make $\mathbf{s}$ a point source, in which case

$$\mathbf{s} = s\left(t\right) \delta\left(x,x_\text{s}\right) \delta\left(y,y_\text{s}\right) \delta\left(z,z_\text{s}\right), \text{and}$$
$$\mathbf{S} = \mathscr{F}\mathbf{s} = -S\left(\omega\right) \delta\left(x,x_\text{s}\right) \delta\left(y,y_\text{s}\right) \delta\left(z,z_\text{s}\right).$$

In response to such a point source at location $\mathbf{x}_\text{s} = \left(x_\text{s}, y_\text{s}, z_\text{s}\right)$, the wavefield $\mathbf{P}$ evaluated at a receiver location $\mathbf{x}_\text{r}$ is described by the Green's function $P\left(\mathbf{x}_\text{s},\mathbf{x}_\text{r}\right) = G\left(\mathbf{x}_\text{s},\mathbf{x}_\text{r}\right)S\left(t\right)$, with

$$G\left(\mathbf{x}_\text{s},\mathbf{x}_\text{r}\right) = \frac{e^{\pm i \omega t \frac{\omega}{c}\|\mathbf{x}_\text{r}-\mathbf{x}_\text{s}\|}}{4\pi \|\mathbf{x}_\text{r}-\mathbf{x}_\text{s}\|}$$

in the case of the 3D acoustic Helmholtz equation.

### Discrete case

The system of equations above can be straightforwardly discretized in the form

$$A_\mathbf{m}\mathbf{u} = \mathbf{q},$$

where $A_\mathbf{m}$ is the system matrix representing the physics of the problem, $\mathbf{u}$ is the field vector (discretized $\mathbf{P}$) and $\mathbf{q}$ is the RHS source vector (discretized $\mathbf{S}$). The vector $\mathbf{m}$ represents discretized heterogenous model of velocity $\mathbf{c}$, upon which $A_\mathbf{m}$ is nonlinearly dependent. The task of solving system of equations for the field vector $\mathbf{u}$ requires inverting the matrix $A_\mathbf{m}$, such that $\mathbf{u} = A_\mathbf{m}^{-1}\mathbf{q}$.

### Data synthesis

Once we are equipped with a scheme to form the system of equations $A_\mathbf{m}$ and invert it to solve for the field vector $\mathbf{u}$, we can go about the task of computing *synthetic data* to simulate the response of the field experiment. We describe a data restriction operator $\mathcal{R}: \mathscr{C}^3 \to \mathscr{C^1}$, which maps from the complex 3D wavefield to the responses at a series of receiver locations. The action of this operator is a good conceptual model to understand how the observed data $\mathbf{d}_\text{obs}$ arise from the field experiment. The equivalent matrix $R$ extracts a 1D vector of synthetic data $\mathbf{d}_\text{syn}$ from the field vector $\mathbf{u}$,

$$\mathbf{d}_\text{syn} = R\mathbf{u} = RA_\mathbf{m}^{-1}\mathbf{q}.$$

## Inversion

In an ideal world, the synthetic data $\mathbf{d}_\text{syn}$ would match the observed data $\mathbf{d}_\text{obs}$. This perfect correspondence between the experimental results and the results of the computer model would indicate that the earth model $\mathbf{m}$ is correct (within the resolving ability of the experiment).[^ButDontForgetNoise] In order to quantify the errors in the model $\mathbf{m}$, we define an *objective function*,

$$\phi\left(\mathbf{m}\right) = \frac{1}{2} \|\mathbf{d}_\text{syn} - \mathbf{d}_\text{obs}\|_2^2 = \frac{1}{2} \|R A_\mathbf{m}^-1 \mathbf{q} - \mathbf{d}_\text{obs}\|_2^2,$$

which measures the error between the data arising from the field experiment ($\mathbf{d}_\text{obs}$) and the data arising from the numerical simulation ($\mathbf{d}_\text{syn}$) under the $L_2$-norm. Then, we define an inverse problem

$$\mathbf{m}_\text{opt} = \underset{\mathbf{m}}{\operatorname{argmin}} \phi\left(\mathbf{m}\right),$$

with the purpose of finding the optimal model $\mathbf{m}_\text{opt}$. If we were in possession of infinite computer resources, we could employ a global search over all feasible models $\mathbf{m}_k$ to find the best $\phi_{\mathbf{m}_k} = \phi\left(\mathbf{m}_k\right)$ to fit the data[^NonUniqueness]; however, in practice the solution of the forward problem $\mathbf{u} = A_\mathbf{m}^{-1}\mathbf{q}$ is quite costly, and we must employ a more efficient method for finding (something close to) $\mathbf{m}_\text{opt}$.

### Local optimization

Rather than search over all possible $\mathbf{m}_k$, we can take advantage of the fact that we often have a good estimate of $\mathbf{m}_\text{opt}$ to begin with.[^InitialModel] In this case, we might consider implementing a *local optimization* method. The simplest example is the *steepest descent* or *gradient* algorigthm, which uses a first-order approximation to the rate of change of the data misfit with respect to each model parameter. The gradient is

$$\nabla_{\mathbf{m}_k} \phi\left(\mathbf{m}\right) = J_{\mathbf{m}_k}^T\delta\mathbf{d}^* = J_{\mathbf{m}_k}^T \left[\mathbf{d}_\text{syn} - \mathbf{d}_\text{obs}\right]^*,$$

where $J$ is the Jacobian matrix of partial derivatives $J_{\mathbf{m}_k;i,j} = \frac{\partial u_i}{\partial m_j}$ evaluated at the present model; $\cdot^T$ indicates transposition and $\cdot^*$ complex conjugation. The steepest descent algorithm is an iterative process, in which the model iterate $\mathbf{m}_k$ is updated in an attempt to go "downhill" in the space of the objective function $\mathbf{\phi}$.

$$\mathbf{m}_{k+1} = \mathbf{m}_k - \alpha_k \nabla_{\mathbf{m}_k} \delta\mathbf{d}^*$$

For appropriate choices of the scalar steplength $\alpha$ at each iteration, $\mathbf{m}_k$ will converge towards a model that finds a reduced value of $\phi$.[^ButStationaryPoint] Various schemes exist to improve on the steepest descent algorithm, including projection methods, conjugate gradient approaches, and higher-order methods including Newton, Gauss-Newton and quasi-Newton (l-BFGS) schemes.

### Model regularization

In the introduction to the [Inversion](#inversion) section, we define the inverse problem that involves finding $\mathbf{m}_\text{opt}$ to minimize the misfit function $\phi\left(m\right)$. However, we put no other *constraints* on the solution. In many practical cases, we know additional information about the sorts of models that can exist, or are most feasible. Therefore, it may make sense to solve a different problem, such as

$$\mathbf{m}_\text{opt} = \underset{\mathbf{m}}{\operatorname{argmin}} \phi\left(\mathbf{m}\right) \text{ subject to } \mathbf{m} \in \mathcal{C},$$

which additionally requires that $\mathbf{m}$ sits inside some (convex) constraint set $\mathcal{C}$. This set could include all models that have velocities within a feasible range, or all models that are sufficiently smooth, etc. All of these criteria represent types of *model regularization*.

In order to find models that fit this new problem, there are various approaches that may be used:

Projection methods
:   Define a projector $\mathcal{P}$ such that $\text{range}\left(\mathcal{P}\right) \in \mathcal{C}$.[^Projector] Then, the projector is applied to the candidate model terates to ensure that $\mathbf{m}_k$ continues to satisfy $\mathcal{C}$, e.g., $$\mathbf{m}_{k+1} = \mathcal{P} \left[\mathbf{m}_k - \alpha_k \nabla_{\mathbf{m}_k} \delta\mathbf{d}^*\right].$$

Penalty methods
:   Redefine the objective function $$\phi\left(\mathbf{m}\right) = \frac{1}{2} \|R A_\mathbf{m}^-1 \mathbf{q} - \mathbf{d}_\text{obs}\|_2^2 + \frac{\lambda_R}{2}\|R\mathbf{m}\|_2^2 + \frac{\lambda_D}{2} \|D\left(\mathbf{m}-\mathbf{m}_\text{ref}\right)\|_2^2,$$ with $R$ and $D$ chosen to penalize certain model properties. Typical choices might be for $R$ to be a discrete representation of $\nabla$ (i.e., first spatial derivative) and $D$ to be diagonal by construction.

[^ButDontForgetNoise]: Of course, in practice $\mathbf{d}_\text{obs} = \mathcal{R}\mathbf{P} + \epsilon$, where $\epsilon$ is some distribution of noise in the recordings, so a perfect match between $\mathbf{d}_\text{obs}$ and $\mathbf{d}_\text{syn}$ would be quite suspicious.
[^NonUniqueness]: It is also important to point out that, in general, there is no single $\mathbf{m}_\text{opt}$ with minimum misfit as measured under $\phi_\mathbf{m}$. Rather, there are usually an infinite number of models that can give rise to a particular misfit $\phi_{\mathbf{m}_k}$. This is an expression of nonuniqueness, and is one of the motivations for properly implementing [Model regularization](#model-regularization).
[^InitialModel]: In practice, this estimate typically comes from from another geophysical method (e.g., traveltime inversion), in combination with *a priori* knowledge of geology and rock physics information.
[^ButStationaryPoint]: NB: This is true as long as the initial model iterate is not a stationary point, in which case $\nabla_\mathbf{m}$ is zero.
[^Projector]: A projector is a linear operator $\mathcal{P}$ that is *idempotent*, meaning $\mathcal{PP}\mathbf{x} = \mathcal{P}\mathbf{x}$.

{!common.md!}