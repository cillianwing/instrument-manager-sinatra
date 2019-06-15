# Add seed data here. Seed your database with 'rake db:seed'.
cillian = User.create(username: "cillian_wing", email: "cillian_wing@gmail.com", password_digest: "test_password1")
elyssa = User.create(username: "elyssa_leal", email: "elyssa_leal@gmail.com", password_digest: "test_password2")

instrument_1 = Instrument.create(type_of: "Guitar", make: "PRS", model: "Special Semi-Hollow", status: "Usable", status_comments: "", user_id: "#{cillian[:id]}")
instrument_2 = Instrument.create(type_of: "Guitar", make: "Fender", model: "Stratocaster", status: "Usable", status_comments: "", user_id: "#{cillian[:id]}")
accessory_1 = Accessory.create(type_of: "Amp", make: "Fender", model: "Blues Jr.", status: "Usable", status_comments: "", user_id: "#{cillian[:id]}")
instrument_3 = Instrument.create(type_of: "Clarinet", make: "Sketch", model: "Loud Noises", status: "In Repair", status_comments: "Broken mouth piece", user_id: "#{cillian[:id]}")
