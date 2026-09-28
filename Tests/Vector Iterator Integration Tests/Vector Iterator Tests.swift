#if Iterator
import Iterator
import Testing
import Vector
import Vector_Test_Support

@Suite("Vector × Iterator")
struct Vector_Iterator_Tests {

    @Test
    func `Vector Iterator conforms and preserves forward order`()  {
        let result = Self.materialize(Vector<5, Int>(InlineArray { $0 + 0 }).makeIterator())

        #expect(result == [0, 1, 2, 3, 4])
    }

    @Test
    func `reversed Vector Iterator conforms and preserves reverse order`()  {
        let result = Self.materialize(Vector<5, Int>(InlineArray { $0 + 0 }).reversed().makeIterator())

        #expect(result == [4, 3, 2, 1, 0])
    }

    private static func materialize<I: Iterator::Iterator.`Protocol`>(
        _ source: consuming I
    ) -> [I.Element]
    where I.Element: Copyable & Escapable, I.Failure == Never {
        var source = source
        var result: [I.Element] = []
        while let element = source.next() {
            result.append(element)
        }
        return result
    }
}

#endif
