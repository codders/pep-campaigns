require 'hashed_id'

class Reference < ActiveRecord::Base

  include HashedId

  attr_accessible :contact_attributes, :referee_answers, :reference_answers_attributes

  belongs_to :contact
  accepts_nested_attributes_for :contact
  belongs_to :campaign
  belongs_to :application
  has_many :answers
  has_many :referee_answers,   class_name: Answer, include: :question, conditions: [ "questions.for = 'referee'" ]
  has_many :reference_answers, class_name: Answer, include: :question, conditions: [ "questions.for = 'reference'" ]
  accepts_nested_attributes_for :referee_answers, :reference_answers

  validates_associated :contact, :referee_answers, :reference_answers
  validates_presence_of :campaign, :application

  def to_param
    hashed_id
  end
end
