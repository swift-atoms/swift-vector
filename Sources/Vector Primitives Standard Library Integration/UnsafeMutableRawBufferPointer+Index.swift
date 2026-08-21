public import Index_Primitives

extension UnsafeMutableRawBufferPointer {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(
        start: UnsafeMutableRawPointer?,
        count: Index_Primitives.Index<Tag>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count))
    }

    @inlinable
    public static func allocate<Tag: ~Copyable & ~Escapable>(
        count: Index_Primitives.Index<Tag>.Count,
        alignment: Index_Primitives.Index<Tag>.Count
    ) -> Self {
        Self.allocate(byteCount: Int(bitPattern: count), alignment: Int(bitPattern: alignment))
    }

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(
        _ index: Index_Primitives.Index<Tag>
    ) -> UInt8 {
        get { unsafe self[Int(bitPattern: index)] }
        nonmutating set { unsafe self[Int(bitPattern: index)] = newValue }
    }
}
