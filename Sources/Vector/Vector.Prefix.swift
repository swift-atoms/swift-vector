public import Cardinal_Carrier
public import Ordinal
public import Ordinal_Protocol
public import Ordinal_Advance
public import Tagged

extension Vector {

    public struct Prefix: ~Copyable {
        @usableFromInline
        var base: Vector<Bound>

        @inlinable
        package init(_ base: Vector<Bound>) {
            self.base = base
        }
    }
}

extension Vector.Prefix where Bound: Copyable {

    @inlinable
    public consuming func first(
        _ count: Vector<Bound>.Index.Count
    ) -> Vector<Bound> {
        let newEnd = base.start.advance.clamped(by: count, to: base.end)

        return Vector<Bound>(
            __unchecked: (),
            start: base.start,
            end: newEnd,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var i = base.start
        while i < base.end {
            let element = base.transform(i)
            if !predicate(element) { break }
            result.append(element)

            i += .one
        }
        return result
    }
}

extension Vector where Bound: Copyable {

    @inlinable
    public var `prefix`: Prefix {
        Prefix(self)
    }
}
