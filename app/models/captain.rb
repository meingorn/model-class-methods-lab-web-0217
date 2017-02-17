class Captain < ActiveRecord::Base
  has_many :boats
    def self.catamaran_operators
      with_classifications
      .where(classifications: { name: "Catamaran"})
    end

    def self.with_classifications
      joins(boats: :classifications)
    end

    def self.sailors
      get_boat_type("Sailboat")

    end

    def self.motorboaters
      get_boat_type("Motorboat")
    end

    def self.get_boat_type(type)
      with_classifications
      .where(classifications: { name: type}).uniq
    end

    def self.talented_seamen
      mb = motorboaters.pluck(:id)
      sb = sailors.pluck(:id)
      x = mb & sb
      where(id:(x))
    end

    def self.non_sailors
      all_cap_ids = self.pluck(:id)
      all_sailboat_cap_ids = sailors.pluck(:id)
      x = all_cap_ids - all_sailboat_cap_ids
      where(id:(x))
    end

end
