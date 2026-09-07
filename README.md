# Vector

A fixed-dimensional mathematical vector. Its dimension is part of its type. Addition/subtraction are componentwise; scalar multiplication and dot product follow the scalar arithmetic. Coordinate frames, quantization, named axes and geometric interpretation are not required by this contract. Zero-dimensional vectors are valid. Scalar overflow behavior is inherited from the scalar; no stronger numerical guarantees are implied.

Swift protocol conformances on this type belong in the core module. Extensions on Swift types belong in the Standard Library Integration module.
