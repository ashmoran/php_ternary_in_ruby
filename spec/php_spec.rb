require 'spec_helper'

require 'php'

describe PHP do
  let(:parser) { PHPParser.new }

  describe "ternary operator" do
    context "simple" do
      example do
        expect(
          parser.parse('TRUE ? "a" : "b"').eval
        ).to be == "a"
      end

      example do
        expect(
          parser.parse('FALSE ? "a" : "b"').eval
        ).to be == "b"
      end
    end

    context "nested" do
      example do
        expect(
          parser.parse('TRUE ? "a" : TRUE ? "b" : "c"').eval
        ).to be == "b"
      end

      example do
        expect(
          parser.parse('FALSE ? "a" : TRUE ? "b" : "c"').eval
        ).to be == "b"
      end

      example do
        expect(
          parser.parse('TRUE ? "a" : FALSE ? "b" : "c"').eval
        ).to be == "b"
      end

      example do
        expect(
          parser.parse('FALSE ? "a" : FALSE ? "b" : "c"').eval
        ).to be == "c"
      end
    end
  end
end