public import Index_Primitives

extension UnsafeRawBufferPointer {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(
        start: UnsafeRawPointer?,
        count: Index_Primitives.Index<Tag>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count))
    }

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(
        _ index: Index_Primitives.Index<Tag>
    ) -> UInt8 {
        unsafe self[Int(bitPattern: index)]
    }
}
