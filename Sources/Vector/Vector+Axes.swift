// Named components are conveniences for one, two, and three dimensions.
// They do not select a coordinate frame or add an affine interpretation.

extension Vector where N == 1 {
    public init(x: Scalar) {
        self.init([x])
    }

    public var x: Scalar {
        get { self[0] }
        set { self[0] = newValue }
    }
}

extension Vector where N == 2 {
    public init(x: Scalar, y: Scalar) {
        self.init([x, y])
    }

    public var x: Scalar {
        get { self[0] }
        set { self[0] = newValue }
    }

    public var y: Scalar {
        get { self[1] }
        set { self[1] = newValue }
    }
}

extension Vector where N == 3 {
    public init(x: Scalar, y: Scalar, z: Scalar) {
        self.init([x, y, z])
    }

    public var x: Scalar {
        get { self[0] }
        set { self[0] = newValue }
    }

    public var y: Scalar {
        get { self[1] }
        set { self[1] = newValue }
    }

    public var z: Scalar {
        get { self[2] }
        set { self[2] = newValue }
    }
}
