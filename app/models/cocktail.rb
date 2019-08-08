class Cocktail < ApplicationRecord
  has_many :doses
  has_many :ingredients, through: :doses
end




# An ingredient has many doses
# A dose belongs to an ingredient
# A dose belongs to a cocktail
# You can't delete an ingredient if it used by at least one cocktail.
# When you delete a cocktail, you should delete associated doses (but not the ingredients as they can be linked to other cocktails).
