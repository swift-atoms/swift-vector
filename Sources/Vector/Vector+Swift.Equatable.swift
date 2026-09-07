extension Vector: Swift.Equatable where Scalar: Swift.Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        for i in 0..<N where lhs[i] != rhs[i] { return false }
        return true
    }
}
