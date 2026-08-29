public import Cardinal_Standard_Library_Integration
public import Index
public import Ordinal_Protocol
public import Ordinal_Standard_Library_Integration

extension UnsafeMutableRawBufferPointer {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(
        start: UnsafeMutableRawPointer?,
        count: Index::Index<Tag>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count))
    }

    @inlinable
    public static func allocate<Tag: ~Copyable & ~Escapable>(
        count: Index::Index<Tag>.Count,
        alignment: Index::Index<Tag>.Count
    ) -> Self {
        Self.allocate(byteCount: Int(bitPattern: count), alignment: Int(bitPattern: alignment))
    }

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(
        _ index: Index::Index<Tag>
    ) -> UInt8 {
        get { unsafe self[Int(bitPattern: index)] }
        nonmutating set { unsafe self[Int(bitPattern: index)] = newValue }
    }
}
