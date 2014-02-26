FactoryGirl.define do
  # Basic examples:
  #
  # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
  #
  # sequence(:age_seq) { |n| 18 + rand(50) }
  #
  # factory :user do
  #   first_name "John"
  #   last_name  "Doe"
  #   age { generate(:age_seq) } # Use of sequence
  #   email { "#{first_name}.#{last_name}@example.com".downcase } # Lazy attribute evaluation
  #   admin false
  # end
  #
  # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end
  #
  # factory :comment do
  #   text "This is a comment."
  #   association :author, factory: user
  # end
end
