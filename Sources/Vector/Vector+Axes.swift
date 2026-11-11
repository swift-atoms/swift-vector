extension Vector where N == 1 {
    @inlinable
    public init(x: Scalar) {
        self.init([x])
    }

    @inlinable
    public var x: Scalar {
        get { self[0] }
        set { self[0] = newValue }
    }
}

extension Vector where N == 2 {
    @inlinable
    public init(x: Scalar, y: Scalar) {
        self.init([x, y])
    }

    @inlinable
    public var x: Scalar {
        get { self[0] }
        set { self[0] = newValue }
    }

    @inlinable
    public var y: Scalar {
        get { self[1] }
        set { self[1] = newValue }
    }
}

extension Vector where N == 3 {
    @inlinable
    public init(x: Scalar, y: Scalar, z: Scalar) {
        self.init([x, y, z])
    }

    @inlinable
    public var x: Scalar {
        get { self[0] }
        set { self[0] = newValue }
    }

    @inlinable
    public var y: Scalar {
        get { self[1] }
        set { self[1] = newValue }
    }

    @inlinable
    public var z: Scalar {
        get { self[2] }
        set { self[2] = newValue }
    }
}
