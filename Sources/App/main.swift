
import Vapor
import VaporPostgreSQL

let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider.self)
drop.preparations.append(Attendee.self)

(drop.view as? LeafRenderer)?.stem.cache = nil

drop.get("version") { request in
    if let db = drop.database?.driver as? PostgreSQLDriver {
        let version = try db.raw("SELECT version()")
        return try JSON(node: version)
    } else {
        return "No db connection"
    }
}

drop.group("api") { api in
    api.resource("attendees", AttendeesController())
}

let adminController = AdminController()
adminController.addRoutes(drop: drop)

let helpController = HelpController()
helpController.addRoutes(drop: drop)

drop.run()
