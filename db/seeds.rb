User.destroy_all
 
 
User.create!([
    {
        document: "admin", encrypted_password: 123456789
     },
 ])
 
p "Created #{User.count} customers."