FactoryGirl.define do
  factory :movie do
    sequence(:title) { |n| "Movie #{n}" }
    sequence(:rating) {|n| ["g","pg","pg-13","r","nc-17","unrated"].sample}
  end
end