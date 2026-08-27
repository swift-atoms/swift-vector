import Testing
import Vector_Test_Support
@testable import Vector

@Suite
struct VectorCoreTests {
    @Test
    func countAndEmptiness() {
        let values = Vector(5..<15)
        #expect(values.count == 10)
        #expect(!values.isEmpty)
        #expect(Vector(3..<3).isEmpty)
    }

    @Test
    func transformAndForEach() {
        let values = Vector(0..<5) { $0 * 2 }
        var result: [Int] = []
        values.forEach { result.append($0) }
        #expect(result == [0, 2, 4, 6, 8])
    }

    @Test
    func iteratorExhaustionIsStable() {
        var iterator = Vector(0..<3).makeIterator()
        #expect(iterator.next() == 0)
        #expect(iterator.next() == 1)
        #expect(iterator.next() == 2)
        #expect(iterator.next() == nil)
        #expect(iterator.next() == nil)
    }

    @Test
    func offsetSubscript() {
        let values = Vector(10..<15)
        #expect(values[0] == 10)
        #expect(values[4] == 14)
    }

    @Test
    func negativeBounds() {
        let values = Vector(-3..<2)
        var result: [Int] = []
        values.forEach { result.append($0) }
        #expect(result == [-3, -2, -1, 0, 1])
    }

    @Test
    func reversedIteration() {
        let values = Vector(0..<5).reversed()
        var result: [Int] = []
        values.forEach { result.append($0) }
        #expect(result == [4, 3, 2, 1, 0])
    }

    @Test
    func reversedIteratorExhaustionIsStable() {
        var iterator = Vector(0..<2).reversed().makeIterator()
        #expect(iterator.next() == 1)
        #expect(iterator.next() == 0)
        #expect(iterator.next() == nil)
        #expect(iterator.next() == nil)
    }

    @Test
    func drainEmptiesVector() {
        var values = Vector(0..<4)
        var result: [Int] = []
        values.drain { result.append($0) }
        #expect(result == [0, 1, 2, 3])
        #expect(values.isEmpty)
    }

    @Test
    func reversedDrainEmptiesView() {
        var values = Vector(0..<4).reversed()
        var result: [Int] = []
        values.drain { result.append($0) }
        #expect(result == [3, 2, 1, 0])
        #expect(values.isEmpty)
    }

    @Test
    func prefixFirst() {
        let prefix = Vector(0..<8).prefix.first(3)
        var result: [Int] = []
        prefix.forEach { result.append($0) }
        #expect(result == [0, 1, 2])
    }

    @Test
    func dropFirst() {
        let suffix = Vector(0..<8).drop.first(3)
        var result: [Int] = []
        suffix.forEach { result.append($0) }
        #expect(result == [3, 4, 5, 6, 7])
    }

    @Test
    func prefixAndDropClamp() {
        #expect(Vector(0..<3).prefix.first(100).count == 3)
        #expect(Vector(0..<3).drop.first(100).isEmpty)
    }

    @Test
    func prefixWhile() {
        #expect(Vector(0..<8).prefix.while { $0 < 4 } == [0, 1, 2, 3])
    }

    @Test
    func dropWhile() {
        #expect(Vector(0..<8).drop.while { $0 < 4 } == [4, 5, 6, 7])
    }

    @Test
    func reversedPrefixFirst() {
        let prefix = Vector(0..<8).reversed().prefix.first(3)
        var result: [Int] = []
        prefix.forEach { result.append($0) }
        #expect(result == [7, 6, 5])
    }

    @Test
    func reversedDropFirst() {
        let suffix = Vector(0..<8).reversed().drop.first(3)
        var result: [Int] = []
        suffix.forEach { result.append($0) }
        #expect(result == [4, 3, 2, 1, 0])
    }

    @Test
    func emptyReversedViewsAreSafe() {
        #expect(Vector(0..<0).reversed().prefix.while { _ in true }.isEmpty)
        #expect(Vector(0..<0).reversed().drop.while { _ in true }.isEmpty)
    }

    @Test
    func largeCountIsConstantTime() {
        #expect(Vector(0..<1_000_000).count == 1_000_000)
    }
}
