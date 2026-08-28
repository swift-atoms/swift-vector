public import Index

extension Vector where Bound: ~Copyable {

    @inlinable
    package borrowing func _makeSequenceIterator() -> Iterator {
        Iterator(current: start, end: end, transform: transform)
    }

    @inlinable
    package mutating func _clear() {
        start = end
        count = .zero
    }
}

extension Vector.Reversed where Bound: ~Copyable {

    @inlinable
    package borrowing func _makeSequenceIterator() -> Iterator {
        Iterator(start: start, end: end, transform: transform)
    }

    @inlinable
    package mutating func _clear() {
        start = end
        count = .zero
    }
}
