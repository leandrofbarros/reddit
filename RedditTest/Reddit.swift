import Foundation
import ObjectMapper

struct Reddit : Mappable {
	var kind : String?
	var test : Test?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		kind <- map["kind"]
		test <- map["test"]
	}

}
