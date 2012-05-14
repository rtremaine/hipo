class Ability
  include CanCan::Ability

  # Define abilities for the passed in user here. For example:
  #
  #   user ||= User.new # guest user (not logged in)
  #   if user.admin?
  #     can :manage, :all
  #   else
  #     can :read, :all
  #   end
  #
  # The first argument to `can` is the action you are giving the user permission to do.
  # If you pass :manage it will apply to every action. Other common actions here are
  # :read, :create, :update and :destroy.
  #
  # The second argument is the resource the user can perform the action on. If you pass
  # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
  #
  # The third argument is an optional hash of conditions to further filter the objects.
  # For example, here the user can only update published articles.
  #
  #   can :update, Article, :published => true
  #
  # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

  def initialize(user)
    # guest user
    user ||= User.new

    if user.is_admin?
      can :manage, :all 
    else
      can :manage, RecordSet do |record_set|
        record_set.check_shared(user)
      end

      can :manage, RecordSet do |record_set|
        record_set.user.company == user.company
      end 
      can :create, RecordSet

      can :manage, Record do |record|
        record.record_set.user.company == user.company 
      end
      can :create, Record

      can :manage, Patient do |patient|
        patient.company == user.company
      end
      can :create, Patient
      can :read, Patient

      can :manage, Company, :id => user.company_id

      can :manage, Contact, :company_id => user.company_id
      can :manage, Contact, :created_by => user.id
    end
  end
end
