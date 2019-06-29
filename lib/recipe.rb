class Recipe
  @@recipes = []
  attr_accessor :name, :ingredients

  def initialize(recipe, ingredients)
    @name = recipe
    @ingredients = ingredients
    @@recipes << self
  end

  def self.describe(&block)
    self.instance_eval &block
  end

  def self.recipe(recipe, &block)
    instance = allocate()
    instance.ingredients = []
    # Set recipe name
    instance.recipe recipe

    # Add ingredient
    instance.instance_eval &block

    @@recipes << instance if instance.valid?
  end

  def recipe(recipe)
    @name = recipe
  end

  def ingredient(ingredient)
    @ingredients << ingredient if !ingredient.empty?
  end

  def self.all
    @@recipes
  end

  def self.for(name)
    @@recipes.find{|recipe| recipe.name == name }
  end

  def valid?
    !@name.nil? && @ingredients.count > 0
  end
end
