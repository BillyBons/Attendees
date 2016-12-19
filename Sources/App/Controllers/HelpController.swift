//
//  HelpController.swift
//  Attendees
//
//  Created by Sergiy Bilyk on 12/19/16.
//
//
import Vapor
import HTTP

final class HelpController {
    
    func addRoutes(drop: Droplet) {
        drop.get("help", handler: indexView)
    }
    
    func indexView(request: Request) throws -> ResponseRepresentable {
        return try drop.view.make("help")
    }
}
