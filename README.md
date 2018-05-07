# Pompeii 2D Mesh Based Graphics API for Pharo

Pompeii graphics is 2D graphics API for Pharo based on meshes instead of SVG style paths. The reason of using meshes is that there are directly supported by 3D graphics cards instead of paths.

Pompeii is designed around a layered approach in order to allow having support for different 3D graphics API, but with a common API. This repository holds the main Pompeii graphics API, and the OpenGL based backend.
