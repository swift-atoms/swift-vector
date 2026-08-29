public import Cardinal_Carrier
public import Ordinal
public import Ordinal_Protocol
public import Ordinal_Advance
public import Tagged

extension Vector {

    public struct Drop: ~Copyable {
        @usableFromInline
        var base: Vector<Bound>

        @inlinable
        package init(_ base: Vector<Bound>) {
            self.base = base
        }
    }
}

extension Vector.Drop where Bound: Copyable {

    @inlinable
    public consuming func first(
        _ count: Vector<Bound>.Index.Count
    ) -> Vector<Bound> {
        let newStart = base.start.advance.clamped(by: count, to: base.end)
        return Vector<Bound>(
            __unchecked: (),
            start: newStart,
            end: base.end,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        var dropping = true
        var i = base.start
        while i < base.end {
            let element = base.transform(i)

            let next = i + .one
            if dropping && predicate(element) {
                i = next
                continue
            }
            dropping = false
            result.append(element)
            i = next
        }
        return result
    }
}

extension Vector where Bound: Copyable {

    @inlinable
    public var drop: Drop {
        Drop(self)
    }
}
