#if Sequence
import Cardinal
import Sequence
import Testing
import Vector
import Vector_Test_Support

@Suite("Vector × Sequence")
struct Vector_Sequence_Tests {

    static func materialize<S: Sequenceable>(
        _ sequence: consuming S
    ) -> [S.Element] where S.Element: Copyable, S.Iterator.Failure == Never {
        var iterator = sequence.makeIterator()
        var result: [S.Element] = []
        while let element = iterator.next() {
            result.append(element)
        }
        return result
    }

    @Test
    func `Vector is Sequenceable in forward order`()  {
        let result = Self.materialize(Vector<5, Int>(InlineArray { $0 + 0 }))
        #expect(result == [0, 1, 2, 3, 4])
    }

    @Test
    func `reversed Vector is Sequenceable in reverse order`()  {
        let result = Self.materialize(Vector<5, Int>(InlineArray { $0 + 0 }).reversed())
        #expect(result == [4, 3, 2, 1, 0])
    }

    @Test
    func `Sequence count where derives Cardinal from Vector`()  {
        let count = Self.sequenceCount(Vector<8, Int>(InlineArray { $0 + 0 })) { $0.isMultiple(of: 2) }
        #expect(count == Cardinal(UInt(4)))
    }

    @Test
    func `empty Vector and reversed view both exhaust`()  {
        let vector = Vector<0, Int>(InlineArray { $0 + 0 })

        #expect(Self.materialize(vector).isEmpty)
        #expect(Self.materialize(vector.reversed()).isEmpty)
    }

    private static func sequenceCount<S: Sequenceable>(
        _ sequence: consuming S,
        where predicate: (borrowing S.Element) -> Bool
    ) throws(S.Iterator.Failure) -> Cardinal
    where S.Element: Copyable {
        try sequence.count(where: predicate)
    }
}

#endif
