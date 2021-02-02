RSpec.describe Enumeric do
  module ::EnumericTest
  end

  after do
    ::EnumericTest.send(:remove_const, :Enum) if defined?(::EnumericTest::Enum)
  end

  it "has a version number" do
    expect(Enumeric::VERSION).not_to be nil
  end

  describe "value method" do
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
      ::EnumericTest::Enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
      )

      res = case 1
      in ::EnumericTest::Enum::ONE
        1
      in ::EnumericTest::Enum::TWO
        2
      end

      expect(res).to eq 1

      expect {
        case 3
        in ::EnumericTest::Enum::ONE
          1
        in ::EnumericTest::Enum::TWO
          2
        end
      }.to raise_error(NoMatchingPatternError)
    end
  end

  describe "include?" do
    it "returns boolean" do
      obj = Object.new
      enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
        OBJECT: obj,
      )

      expect(enum.include?(1)).to eq true
      expect(enum.include?(3)).to eq false
      expect(enum.include?(obj)).to eq true
    end
  end

  describe "name" do
    it "returns Symbol or nil" do
      obj = Object.new
      enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
        OBJECT: obj,
      )

      expect(enum.name(1)).to eq :ONE
      expect(enum.name(3)).to eq nil
      expect(enum.name(obj)).to eq :OBJECT
    end
  end

  describe "names" do
    it "returns Array of Symbols" do
      obj = Object.new
      enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
        OBJECT: obj,
      )

      expect(enum.names).to eq %i(ONE TWO OBJECT)
      expect(enum.names).to be_frozen
    end
  end

  describe "values" do
    it "returns Array" do
      obj = Object.new
      enum = Enumeric.define(
        ONE: 1,
        TWO: 2,
        OBJECT: obj,
      )

      expect(enum.values).to eq [1, 2, obj]
      expect(enum.names).to be_frozen
    end
  end
end
