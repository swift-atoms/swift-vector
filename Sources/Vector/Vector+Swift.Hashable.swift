extension Vector: Swift.Hashable where Scalar: Swift.Hashable {
    public func hash(into hasher: inout Hasher) {
        for i in 0..<N { hasher.combine(self[i]) }
    }
}
