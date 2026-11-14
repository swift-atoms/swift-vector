extension Vector {

    /// Why a vector has no direction to give.
    public enum Error: Swift::Error, Hashable, Sendable {
        /// Every component is zero.
        case zero
        /// A component is infinite or NaN.
        case nonfinite
    }
}
