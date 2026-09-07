import Vector
import Testing

@Suite struct `Vectors obey mathematical laws` {
    @Test func `Dot products preserve scalar rounding order`() {
        let values = Vector<3, Double>([1e16, 1, -1e16])
        #expect(values.dot(.init(repeating: 1)) == 0)
        let reordered = Vector<3, Double>([1e16, -1e16, 1])
        #expect(reordered.dot(.init(repeating: 1)) == 1)
    }

    @Test func `Mapping stops at the first thrown error`() {
        enum Failure: Swift.Error { case stopped }
        var visited: [Int] = []
        #expect(throws: Failure.stopped) {
            try Vector<3, Int>([1, 2, 3]).map { value in
                visited.append(value)
                if value == 2 { throw Failure.stopped }
                return value
            }
        }
        #expect(visited == [1, 2])
    }

    @Test func `Additive identity and inverse`() {
        let value = Vector<3, Int>([2, -3, 7])
        #expect(value + .zero == value)
        #expect(value - value == .zero)
        #expect(value.scaled(by: 2) == value + value)
    }
    @Test func `Dot product distributes`() {
        let a = Vector<2, Int>([2, 3])
        let b = Vector<2, Int>([4, 5])
        let c = Vector<2, Int>([6, 7])
        #expect(a.dot(b) == 23)
        #expect(a.dot(b + c) == a.dot(b) + a.dot(c))
    }
    @Test func `Empty vector does not evaluate mapping`() {
        var calls = 0
        let empty = Vector<0, Int>(repeating: 0)
        let mapped = empty.map { value in calls += 1; return value }
        #expect(calls == 0)
        #expect(mapped.dot(empty) == 0)
    }
}
