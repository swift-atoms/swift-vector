import Testing
import Vector

enum `Vector geometry Tests` {}

extension `Vector geometry Tests` {
    @Suite struct `Length and direction follow the dot product` {
        @Test func `Length is the square root of the dot product with itself`() {
            let value = Vector<3, Double>(x: 2, y: 3, z: 6)
            #expect(value.dot(value) == 49)
            #expect(value.length == 7)
            #expect(Vector<2, Double>.zero.length == 0)
        }

        @Test func `A normalised vector has length one and keeps its direction`() throws {
            let value = Vector<3, Double>(x: 2, y: 3, z: 6)
            let unit = try value.normalized
            #expect(abs(unit.length - 1) <= 4 * Double.ulpOfOne)
            #expect(abs(unit.x - 2.0 / 7) <= Double.ulpOfOne)
            #expect(abs(unit.y - 3.0 / 7) <= Double.ulpOfOne)
            #expect(abs(unit.z - 6.0 / 7) <= Double.ulpOfOne)
        }

        @Test func `Normalising survives components whose squares underflow or overflow`() throws {
            let tiny = try Vector<2, Double>(x: 3e-200, y: 4e-200).normalized
            #expect(abs(tiny.x - 0.6) <= Double.ulpOfOne)
            #expect(abs(tiny.y - 0.8) <= Double.ulpOfOne)
            let huge = try Vector<2, Double>(x: 3e200, y: 4e200).normalized
            #expect(abs(huge.x - 0.6) <= Double.ulpOfOne)
            #expect(abs(huge.y - 0.8) <= Double.ulpOfOne)
        }

        @Test func `The zero vector and non-finite vectors have no direction`() {
            #expect(throws: Vector<3, Double>.Error.zero) { try Vector<3, Double>.zero.normalized }
            #expect(throws: Vector<2, Double>.Error.nonfinite) { try Vector<2, Double>(x: .infinity, y: 1).normalized }
            #expect(throws: Vector<2, Double>.Error.nonfinite) { try Vector<2, Double>(x: 0, y: .nan).normalized }
        }
    }

    @Suite struct `Cross products are perpendicular and anticommutative` {
        @Test func `The cross product is perpendicular to both factors`() {
            let a = Vector<3, Int>(x: 2, y: -3, z: 5)
            let b = Vector<3, Int>(x: 7, y: 1, z: -4)
            let c = a.cross(b)
            #expect(c.dot(a) == 0)
            #expect(c.dot(b) == 0)
        }

        @Test func `Swapping the factors negates the cross product`() {
            let a = Vector<3, Int>(x: 2, y: -3, z: 5)
            let b = Vector<3, Int>(x: 7, y: 1, z: -4)
            #expect(a.cross(b) + b.cross(a) == .zero)
            #expect(a.cross(a) == .zero)
        }

        @Test func `The basis follows the right hand rule`() {
            let x = Vector<3, Int>(x: 1, y: 0, z: 0)
            let y = Vector<3, Int>(x: 0, y: 1, z: 0)
            let z = Vector<3, Int>(x: 0, y: 0, z: 1)
            #expect(x.cross(y) == z)
            #expect(y.cross(z) == x)
            #expect(z.cross(x) == y)
        }
    }

    @Suite struct `Interpolation runs a share of the way between two vectors` {
        @Test func `Interpolation at zero one and one half gives the start the end and the midpoint`() {
            let start = Vector<2, Double>(x: 0.25, y: -3)
            let end = Vector<2, Double>(x: 0.75, y: 5)
            #expect(start.interpolated(to: end, at: 0) == start)
            #expect(start.interpolated(to: end, at: 1) == end)
            #expect(start.interpolated(to: end, at: 0.5) == Vector(x: 0.5, y: 1))
        }

        @Test func `Shares outside zero to one extrapolate along the same line`() {
            let start = Vector<1, Double>(x: 1)
            let end = Vector<1, Double>(x: 3)
            #expect(start.interpolated(to: end, at: 2) == Vector(x: 5))
            #expect(start.interpolated(to: end, at: -1) == Vector(x: -1))
        }
    }
}
