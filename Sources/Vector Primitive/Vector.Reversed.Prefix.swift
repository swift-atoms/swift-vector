extension Vector.Reversed {

    public struct Prefix: ~Copyable {
        @usableFromInline
        var base: Vector<Bound>.Reversed

        @inlinable
        package init(_ base: Vector<Bound>.Reversed) {
            self.base = base
        }
    }
}

extension Vector.Reversed.Prefix where Bound: Copyable {

    @inlinable
    public consuming func first(_ count: Vector<Bound>.Index.Count) -> Vector<Bound>.Reversed {
        let newStart = base.end.retreat.clamped(by: count, to: base.start)
        return Vector<Bound>.Reversed(
            __unchecked: (),
            start: newStart,
            end: base.end,
            transform: base.transform
        )
    }

    @inlinable
    public consuming func `while`(_ predicate: (Bound) -> Bool) -> [Bound] {
        var result: [Bound] = []
        guard !base.isEmpty else { return result }

        let initial: Vector<Bound>.Index
        do throws(Ordinal.Error) {
            initial = try base.end.predecessor.exact()
        } catch {
            return result
        }
        var i = initial
        while i >= base.start {
            let element = base.transform(i)
            if !predicate(element) { break }
            result.append(element)
            if i == base.start { break }

            do throws(Ordinal.Error) {
                i = try i.predecessor.exact()
            } catch {
                break
            }
        }
        return result
    }
}

extension Vector.Reversed where Bound: Copyable {

    @inlinable
    public var `prefix`: Prefix {
        Prefix(self)
    }
}
