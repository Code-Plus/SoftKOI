class Ability
   include CanCan::Ability

   def initialize(user)

      if user.role.name == 'Empleado'

         if user.can_inventory == true
            can :manage, Product
            can :manage, Category
            can :manage, TypeProduct
            can :manage, InputProduct
            can :manage, OutputProduct
         end

         if user.can_sales == true
            can :manage, Sale
         end

         # if user.can_changes == true
         #    can :manage, Change
         # end

         # if user.can_consoles
         #    can :manage, Console
         # end

         if user.can_customers == true
            can :manage, Customer
         end

      else
         can :manage, :all
      end

   end
end
