#if Sequence
@_exported public import Sequence

extension Vector: Sequenceable {
    public typealias Element = Scalar
}

extension Vector.Reversed: Sequenceable {
    public typealias Element = Scalar
}
#endif
