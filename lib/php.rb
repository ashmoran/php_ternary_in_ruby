require 'treetop'
Treetop.load(File.dirname(__FILE__) + '/php')

module PHP
  class PHPTernary < Treetop::Runtime::SyntaxNode
    def eval
      rest_ternaries.elements.inject(condition) { |condition, options|
        # It would seem ironic to not use a ternary operator in the implementation...
        condition = condition.true? ? options.value_if_true : options.value_if_false
      }.eval
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