require 'spec_helper'

require 'php'

describe PHP do
  let(:parser) { PHPParser.new }

  # These are only here to unit-test the language components
  describe "expressions" do
    describe "booleans" do
      describe "TRUE" do
        specify {
          expect(parser.parse("TRUE").eval).to be_true
        }

        specify {
          expect(parser.parse("TRUE").to_s).to be == "1"
        }
      end

      describe "FALSE" do
        specify {
          expect(parser.parse("FALSE").eval).to be_false
        }

        specify {
          expect(parser.parse("FALSE").to_s).to be == ""
        }
      end
    end

    describe "strings" do
      example do
        expect(parser.parse('"a"').eval).to be == "a"
      end
    end
  end

  # This is the point of the exercise
  describe "ternary operator" do
    context "simple" do
      context "boolean condition" do
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

      context "string condition" do
        example do
          expect(
            parser.parse('"x" ? "a" : "b"').eval
          ).to be == "a"
        end
      end
    end

    # And this is the nut I'm trying to crack
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

      # I don't actually know what PHP does here, but to be consistent(?!)
      # with the above behaviour, this is the only thing I can think of that
      # would make sense...
      context "twice" do
        example do
          expect(
            parser.parse('TRUE ? "a" : TRUE ? "b" : TRUE ? "c" : "d"').eval
          ).to be == "c"
        end
      end
    end
  end
end