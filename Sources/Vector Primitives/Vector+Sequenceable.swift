public import Sequence_Primitives
public import Vector_Primitive

extension Vector: Sequenceable where Bound: Copyable {}

extension Vector.Reversed: Sequenceable where Bound: Copyable {}
