require 'spec_helper'

describe Question::Rate do

  describe 'field_name' do
    subject { element.field_name }
    let(:element) { Question::Rate.new }

    it { should == :numeric_value }
  end

  describe 'input_element' do
    subject { element.input_element }
    let(:element) { Question::Rate.new }

    it 'returns numeric_value as input name' do
      subject.first.should == :numeric_value
    end

    it 'returns radio as type' do
      subject[1][:as].should == :radio
    end

    it 'returns question text as label' do
      element.stub(text: 'The question')
      subject[1][:label].should == 'The question'
    end

    it 'marks question as required' do
      element.stub(required: required = double('required'))
      subject[1][:required].should == required
    end
  end

  describe 'self.model_name' do
    subject { Question::Rate.model_name }

    it { should == Question.model_name }
  end

  describe 'input_valid?' do
    subject { question.input_valid?(value) }
    let(:question) { Question::Boolean.new }
    before { question.stub(required: required) }

    context 'value empty, not required' do
      let(:value) { nil }
      let(:required) { false }
      it { should be_true }
    end

    context 'empty value, required' do
      let(:value) { nil }
      let(:required) { true }
      it { should be_false }
    end

    context 'value, required' do
      let(:value) { 0 }
      let(:required) { true }
      it { should be_true }
    end
  end

  describe 'summary_type' do
    subject { Question::Rate.new.summary_type }

    it { should == :number }
  end

  describe 'summary' do
    subject { question.summary(Answer) }
    let(:question) { create(:rate_question, for: :application) }
    before do
      create(:answer, question: question, numeric_value: 1)
      create(:answer, question: question, numeric_value: 3)
      create(:answer, question: question, text_value: '')
    end

    it { should == 2 }
  end

  describe 'formatted_value' do
    subject { question.formatted_value(value) }
    let(:question) { create(:rate_question, for: :application) }
    let(:value) { double('value') }

    it 'returns value' do
      subject.should == value
    end
  end
end

