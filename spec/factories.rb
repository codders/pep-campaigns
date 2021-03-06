FactoryGirl.define do

  factory :answer do
  end

  factory :contact do
    first_name "Robert"
    last_name "Paulson"
    email "his_name_is@robert.paulson"
    factory :applicant_contact, class: 'Contact::Applicant' do
      password 'foo'
    end
    factory :referee_contact, class: 'Contact::Referee'
  end

  factory :campaign do
    name { 'Campaign' }
    referee_introduction_text { "Please fill in the referee form" }
    required_reference_count 10
  end

  factory :question do
    ignore do
      answer nil
      application nil
      reference nil
    end
    after(:create) do |question, evaluator|
      if evaluator.answer
        create(:answer,
               application_id: evaluator.application.id,
               reference_id: evaluator.reference.try(:id),
               text_value: evaluator.answer,
               question: question
              )
      end
    end
    factory :text_question, class: 'Question::Text'
    factory :simple_text_question, class: 'Question::SimpleText'
    factory :rate_question, class: 'Question::Rate'
    factory :select_question, class: 'Question::Select'
    factory :boolean_question, class: 'Question::Boolean'
  end

  factory :reference do
    association :campaign
    association :application
    before(:create) do |reference, evaluator|
      reference.contact = evaluator.contact || create(:referee_contact)
    end
  end

  factory :application do
    association :campaign
    contact { create(:applicant_contact) }
  end

  factory :admin do
    sequence(:email) { |n| "email#{n}@example.com" }
    password { 'ecertv5634v5zfv345t' }
  end
end
