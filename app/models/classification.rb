class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    max = joins(:boats).maximum("length")
    joins(:boats).where("boats.length = ?", max)
  end
end
