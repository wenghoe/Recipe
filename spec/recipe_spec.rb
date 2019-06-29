require 'recipe'

RSpec.describe Recipe do
  subject {
    described_class.new("Fried Noodles", ["Fish", "Water"])
  }

  it "is valid with valid attributes" do
    expect(subject.valid?).to eq(true)
  end

  it "is not valid without a recipe name" do
    subject.name = nil
    expect(subject.valid?).to eq(false)
  end

  it "is not valid without ingredients" do
    subject.ingredients = []
    expect(subject.valid?).to eq(false)
  end

  describe 'self#describe' do
    it "creates a Recipe" do
      expect do
        described_class.describe do
          recipe 'Hot Cake' do
            ingredient 'Egg'
            ingredient 'Flour'
            ingredient 'Water'
            ingredient 'Sugar'
          end
        end
      end.to change{described_class.all.count}.by(1)
    end

    it "does not create a Recipe" do
      expect do
        described_class.describe do
          recipe 'Hot Cake' do
            ingredient ''
          end
        end
      end.to change{described_class.all.count}.by(0)
    end
  end

  describe '#recipe' do
    it "assigns a recipe name" do
      subject.recipe "Fish Soup"
      expect(subject.name).to eq("Fish Soup")
    end
  end

  describe '#ingredient' do
    it "adds a new ingredient" do
      subject.ingredient "Noodles"
      expect(subject.ingredients).to eq(["Fish", "Water", "Noodles"])
    end
  end

  describe '#for' do
    let!(:recipe1)  { described_class.new("Carrot Juice", ["Carrot", "Water"]) }
    let!(:existing_recipe)  { described_class.for "Carrot Juice" }
    let!(:nonexisting_recipe)  { described_class.for "Carrot Water" }

    it "looks for an existing recipe" do
      expect(existing_recipe).to eq(recipe1)
    end

    it "looks for a non existing recipe" do
      expect(nonexisting_recipe).to eq(nil)
    end
  end

end
