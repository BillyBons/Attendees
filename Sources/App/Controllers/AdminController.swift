//
//  AdminController.swift
//  Attendees
//
//  Created by Sergiy Bilyk on 11.12.16.
//
//
import Vapor
import HTTP

final class AdminController {
    
    func addRoutes(drop: Droplet) {
        drop.get("admin", handler: indexView)
        drop.post("admin", handler: addAttendee)
        drop.post("admin", Attendee.self, "delete", handler: deleteAttendee)
    }
    
    func indexView(request: Request) throws -> ResponseRepresentable {
        let attendees = try Attendee.all().makeNode()
        let parameters = try Node(node: [
            "attendees" : attendees
            ])
        return try drop.view.make("index", parameters)
    }
    
    func addAttendee(request: Request) throws -> ResponseRepresentable {
        guard let name = request.data["name"]?.string, let email = request.data["email"]?.string
            else {
                throw Abort.badRequest
        }
        
        var attendee = Attendee(name: name, email: email)
        try attendee.save()
        return Response(redirect: "/admin")
    }
    
    func deleteAttendee(request: Request, attendee: Attendee) throws -> ResponseRepresentable {
        try attendee.delete()
        return Response(redirect: "/admin")
    }
}
