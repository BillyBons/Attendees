//
//  AttendeesController.swift
//  Attendees
//
//  Created by Sergiy Bilyk on 09.12.16.
//
//

import Vapor
import HTTP

final class AttendeesController: ResourceRepresentable {
    
    func makeResource() -> Resource<Attendee> {
        
        func index(request: Request) throws -> ResponseRepresentable {
            return try Attendee.all().makeNode().converted(to: JSON.self)
        }
        
        func create(request: Request) throws -> ResponseRepresentable {
            guard let name = request.data["name"]?.string else {
                throw Abort.custom(status: Status.preconditionFailed, message: "Missing name")
            }
            
            guard let email = request.data["email"]?.string else {
                throw Abort.custom(status: Status.preconditionFailed, message: "Missing email")
            }
            
            var attendee = Attendee(name: name, email: email)
            try attendee.save()
            return try attendee.converted(to: JSON.self)
        }
        
        return Resource(
            index: index,
            store: create
        )
    }
}
