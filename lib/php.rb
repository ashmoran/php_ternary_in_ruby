require 'treetop'
Treetop.load(File.dirname(__FILE__) + '/php')

module PHP
  class PHPNestedTernary < Treetop::Runtime::SyntaxNode
    def eval
      rest_ternaries.elements.inject(first.chosen_option) { |condition, options|
        condition =
          if condition.true?
            options.value_if_true
          else
            options.value_if_false
          end
      }.eval
    end
  end

  class PHPTernary < Treetop::Runtime::SyntaxNode
    def true?
      chosen_option.true?
    end

    def chosen_option
      if condition.true?
        options.value_if_true
      else
        options.value_if_false
      end
    end

    def eval
      chosen_option.eval
    end
  end

  class PHPTrue < Treetop::Runtime::SyntaxNode
    def true?
      eval
    end

    def eval
      true
    end

    def to_s
      "1"
    end
  end

  class PHPFalse < Treetop::Runtime::SyntaxNode
    def true?
      eval
    end

    def eval
      false
    end

    def to_s
      ""
    end
  end

  class PHPString < Treetop::Runtime::SyntaxNode
    def true?
      true # We hope
    end

    def eval
      body.text_value
    end
  end
end