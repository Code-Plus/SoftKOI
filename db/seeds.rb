r1 = Role.create(:name => 'Administrador')
r2 = Role.create(:name => 'Empleado')

r1 = TypeDocument.create(:description => 'Cédula de ciudadania')
r2 = TypeDocument.create(:description => 'Tarjeta de identidad')
p "Created #{Role.count} types."
p "Created #{TypeDocument.count} types."
