//
//  Attendee.swift
//  Attendees
//
//  Created by Sergiy Bilyk on 09.12.16.
//
//

import Vapor
import Fluent

final class Attendee: Model {

    var id: Node?
    var exists: Bool = false

    var name: String
    var email: String

    init (name: String, email: String) {
        self.name = name
        self.email = email
    }

    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        email = try node.extract("email")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id" : id,
            "name" : name,
            "email" : email
            ])
    }
}

extension Attendee: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create("attendees") { attendees in
            attendees.id()
            attendees.string("name")
            attendees.string("email")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("attendees")
    }
}
