class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    joins(:classifications).where("classifications.name = ?", 'Catamaran')
  end

  def self.sailors
    distinct.joins(:classifications).where("classifications.name = ?", 'Sailboat')
  end

  def self.motorboat_operators
    joins(:classifications).where("classifications.name = ?", 'Motorboat')
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id))
  end
end
