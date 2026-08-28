public import Sequence
public import Vector

extension Vector: Sequenceable where Bound: Copyable {}

extension Vector.Reversed: Sequenceable where Bound: Copyable {}
