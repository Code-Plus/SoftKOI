class Ability
   include CanCan::Ability

   def initialize(user)
      if user.role.name == 'admin'
         can :manage, :all
      end
   end
end
