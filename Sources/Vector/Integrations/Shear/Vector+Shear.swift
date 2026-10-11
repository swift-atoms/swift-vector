#if Shear
@_exported public import Shear

extension Shear {

    public enum ApplicationError: Swift::Error, Equatable, Sendable {
        case nonfiniteCoordinate
    }

    public func applied(to vector: Vector<N, Scalar>) throws(ApplicationError) -> Vector<N, Scalar> {
        for index in 0..<N {
            guard vector[index].isFinite else { throw .nonfiniteCoordinate }
        }
        var result = vector
        let value = vector[target.underlying] + factor.value * vector[source.underlying]
        guard value.isFinite else { throw .nonfiniteCoordinate }
        result[target.underlying] = value
        return result
    }
}
#endif
