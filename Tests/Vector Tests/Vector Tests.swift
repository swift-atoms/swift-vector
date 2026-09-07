import Vector
import Testing

@Suite struct MathematicalVectorTests {
    @Test func additiveIdentityAndInverse() {
        let value = Vector<3, Int>([2, -3, 7])
        #expect(value + .zero == value)
        #expect(value - value == .zero)
        #expect(value.scaled(by: 2) == value + value)
    }
    @Test func dotProductDistributes() {
        let a = Vector<2, Int>([2, 3])
        let b = Vector<2, Int>([4, 5])
        let c = Vector<2, Int>([6, 7])
        #expect(a.dot(b) == 23)
        #expect(a.dot(b + c) == a.dot(b) + a.dot(c))
    }
    @Test func emptyVectorDoesNotEvaluateMapping() {
        var calls = 0
        let empty = Vector<0, Int>(repeating: 0)
        let mapped = empty.map { value in calls += 1; return value }
        #expect(calls == 0)
        #expect(mapped.dot(empty) == 0)
    }
}
