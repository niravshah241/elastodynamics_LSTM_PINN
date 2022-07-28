from dolfin import *
import os
import matplotlib.pyplot as plt
import numpy as np

os.system("gmsh -2 mesh.geo -format msh2")
os.system("dolfin-convert mesh.msh mesh.xml")

mesh = Mesh("mesh.xml")
subdomains = MeshFunction('size_t',mesh,"mesh_physical_region.xml")
boundaries = MeshFunction('size_t',mesh,"mesh_facet_region.xml")
File("mesh.pvd")<<mesh
File("subdomains.pvd")<<subdomains
File("boundaries.pvd")<<boundaries

os.system("paraview subdomains.pvd")

mesh.init(1) # for initialization of list of edges
quality = list() # quality as list
for i in range(mesh.num_cells()):
	cell = Cell(mesh,i) # create cell for element i
	a = cell.entities(1) # extract indices of entities of dimension 1
	denominator = 0 
	for j in range(len(a)):
		denominator += (cpp.mesh.Edge(mesh,a[j]).length())**2 # l_1^2 + l_2^2 + l_3^2
	quality.append(4 * sqrt(3) * cell.volume() / denominator)

quality = np.array(quality)
plt.hist(quality,bins=20,cumulative=True,normed=True)
plt.xlabel('Element quality')
plt.ylabel('Fraction of total no. of elements')
#plt.title(str('Cumulative histogram of element quality, Minimum quality : %f' % min(quality)))
plt.axis('tight')
plt.show()

print("Minimum quality : ",min(quality))
print("Average quality : ",np.mean(quality))
print("Maximum quality : ",max(quality))