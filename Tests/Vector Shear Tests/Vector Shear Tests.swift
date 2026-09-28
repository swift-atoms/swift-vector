#if Shear
import Vector
import Testing

@Suite struct `Shear vector application` {
    @Test func `Only the selected target changes and the inverse restores exact samples`() throws {
        let shear = try Shear<3, Double>(target: .primary, source: .tertiary, factor: Scale(2))
        let vector = Vector(x: 1.0, y: 4.0, z: 3.0)
        let moved = try shear.applied(to: vector)
        #expect(moved == Vector(x: 7.0, y: 4.0, z: 3.0))
        #expect(try shear.inverse.applied(to: moved) == vector)
    }

    @Test func `Overflow and nonfinite inputs are rejected by the integration`() throws {
        let shear = try Shear<2, Double>(target: .primary, source: .secondary, factor: Scale(2))
        #expect(throws: Shear<2, Double>.ApplicationError.nonfiniteCoordinate) {
            try shear.applied(to: Vector(x: 0.0, y: Double.greatestFiniteMagnitude))
        }
        #expect(throws: Shear<2, Double>.ApplicationError.nonfiniteCoordinate) {
            try shear.applied(to: Vector(x: Double.nan, y: 0.0))
        }
    }

    @Test func `Zero factor leaves finite vectors unchanged`() throws {
        let shear = try Shear<2, Double>(target: .primary, source: .secondary, factor: Scale(0))
        let vector = Vector(x: 1.0, y: 2.0)
        #expect(try shear.applied(to: vector) == vector)
    }
}

@Suite struct `Shear application boundaries` {
    @Test(arguments: [Double.infinity, -Double.infinity, Double.nan])
    func `Every nonfinite coordinate is rejected including unchanged coordinates`(value: Double) throws {
        let shear = try Shear<3, Double>(target: .primary, source: .secondary, factor: Scale(0))
        for index in 0..<3 {
            var vector = Vector<3, Double>(InlineArray(repeating: 1))
            vector[index] = value
            #expect(throws: Shear<3, Double>.ApplicationError.nonfiniteCoordinate) {
                try shear.applied(to: vector)
            }
        }
    }

    @Test func `Addition overflow is rejected even when multiplication stays finite`() throws {
        let shear = try Shear<2, Double>(target: .primary, source: .secondary, factor: Scale(1))
        #expect(throws: Shear<2, Double>.ApplicationError.nonfiniteCoordinate) {
            try shear.applied(to: Vector(x: Double.greatestFiniteMagnitude, y: Double.greatestFiniteMagnitude))
        }
    }

    @Test func `Reversed axis order and fractional factors preserve unrelated coordinates`() throws {
        let shear = try Shear<4, Float>(target: Axis(3), source: Axis(0), factor: Scale(-0.5))
        let vector = Vector<4, Float>([4, 7, -3, 2])
        let moved = try shear.applied(to: vector)
        #expect(moved == Vector<4, Float>([4, 7, -3, 0]))
        #expect(vector[3] == 2)
    }
}
#endif
