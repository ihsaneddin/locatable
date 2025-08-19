User.connection.truncate("users")
Customer.connection.truncate("customers")
Locatable::Location.connection.truncate("locatable_locations")
Locatable::Locator.connection.truncate("locatable_locators")

User.locatable

user = User.create(email: "user@mail.com", name: "user")

debugger

user.addresses
user