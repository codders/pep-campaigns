class Question
  class Text < Question

    def self.model_name
      Question.model_name
    end

    def field_name
      :text_value
    end

    def input_type
      :text
    end

    def input_valid?(value)
      !value.blank? || !required
    end

    def summary_type
      :list
    end

    def summary(answers)
      answers
        .reject { |answer| answer.value.blank? }
    end
  end
end
