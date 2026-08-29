public import Cardinal_Standard_Library_Integration
public import Index
public import Ordinal_Protocol
public import Ordinal_Standard_Library_Integration

extension UnsafeRawBufferPointer {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(
        start: UnsafeRawPointer?,
        count: Index::Index<Tag>.Count
    ) {
        unsafe self.init(start: start, count: Int(bitPattern: count))
    }

    @inlinable
    public subscript<Tag: ~Copyable & ~Escapable>(
        _ index: Index::Index<Tag>
    ) -> UInt8 {
        unsafe self[Int(bitPattern: index)]
    }
}
