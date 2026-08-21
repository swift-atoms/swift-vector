internal import Property_Primitives
public import Sequence_Primitives
public import Vector_Primitive

extension Vector where Bound: Copyable {

    @inlinable
    public func count(where predicate: (Bound) -> Bool) -> Index.Count {
        var count: Index.Count = .zero
        var iterator: Iterator = makeIterator()
        while let element = iterator.next() {
            if predicate(element) { count += .one }
        }
        return count
    }
}

extension Vector.Reversed where Bound: Copyable {

    @inlinable
    public func count(where predicate: (Bound) -> Bool) -> Vector<Bound>.Index.Count {
        var count: Vector<Bound>.Index.Count = .zero
        var iterator: Iterator = makeIterator()
        while let element = iterator.next() {
            if predicate(element) { count += .one }
        }
        return count
    }
}
