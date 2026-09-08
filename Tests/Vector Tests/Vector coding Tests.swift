import Foundation
import Testing
import Vector

@Suite
struct `Vector coding preserves static dimensions` {
    @Test
    func `Components encode in axis order and round trip`() throws {
        let vector = Vector<3, Int>(x: 3, y: -2, z: 1)
        let data = try JSONEncoder().encode(vector)
        #expect(String(decoding: data, as: UTF8.self) == "[3,-2,1]")
        #expect(try JSONDecoder().decode(Vector<3, Int>.self, from: data) == vector)
    }

    @Test
    func `Empty vectors decode without reading a first component`() throws {
        let value = try JSONDecoder().decode(Vector<0, Int>.self, from: Data("[]".utf8))
        #expect(value == Vector<0, Int>(repeating: 0))
        #expect(try JSONEncoder().encode(value) == Data("[]".utf8))
    }

    @Test(arguments: ["[]", "[1]", "[1,2,3]", "[1,null]", "[1,\"two\"]", "{}"])
    func `Malformed or differently dimensioned input is rejected`(_ json: String) {
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Vector<2, Int>.self, from: Data(json.utf8))
        }
    }

    @Test
    func `Empty vectors reject extra components`() {
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Vector<0, Int>.self, from: Data("[1]".utf8))
        }
    }

    @Test
    func `Encoding does not require a decodable scalar`() throws {
        struct Value: Encodable { let text: String }
        let data = try JSONEncoder().encode(Vector<1, Value>(repeating: Value(text: "a")))
        #expect(String(decoding: data, as: UTF8.self) == "[{\"text\":\"a\"}]")
    }

    @Test
    func `Decoding does not require an encodable scalar`() throws {
        struct Value: Decodable { let text: String }
        let value = try JSONDecoder().decode(
            Vector<1, Value>.self, from: Data("[{\"text\":\"a\"}]".utf8)
        )
        #expect(value[0].text == "a")
    }
}
