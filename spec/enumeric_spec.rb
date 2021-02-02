RSpec.describe Enumeric do
  it "has a version number" do
    expect(Enumeric::VERSION).not_to be nil
  end

  describe "value method" do
    after do
      ::Object.send(:remove_const, :Enum) if defined?(Enum)
    end

    it "returns value" do
      obj = Object.new
      enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
        OBJECT: obj,
      )

      expect(enum::ONE).to eq 1
      expect(enum::TWO).to eq 2
      expect(enum::OBJECT).to eq obj
    end

    it "can be used in pattern matching" do
      obj = Object.new
      Enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
      )

      res = case 1
      in Enum::ONE
        1
      in Enum::TWO
        2
      end

      expect(res).to eq 1

      expect {
        case 3
        in Enum::ONE
          1
        in Enum::TWO
          2
        end
      }.to raise_error(NoMatchingPatternError)
    end
  end

  describe "include?" do
    it "returns boolean" do
      obj = Object.new
      Enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
        OBJECT: obj,
      )

      expect(Enum.include?(1)).to eq true
      expect(Enum.include?(3)).to eq false
      expect(Enum.include?(obj)).to eq true
    end
  end

  describe "name" do
    it "returns Symbol or nil" do
      obj = Object.new
      Enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
        OBJECT: obj,
      )

      expect(Enum.name(1)).to eq :ONE
      expect(Enum.name(3)).to eq nil
      expect(Enum.name(obj)).to eq :OBJECT
    end
  end
end
