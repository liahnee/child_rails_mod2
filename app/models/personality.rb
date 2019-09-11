class Personality < ApplicationRecord
    belongs_to :child
    belongs_to :learning
    belongs_to :hobby

    validates :social_trait, inclusion: { in: %w(Introvert, Extrovert) }
    validates :learning_trait, inclusion: { in: ["All-rounder", "Interest only"]}

end
