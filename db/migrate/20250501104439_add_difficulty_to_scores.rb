class AddDifficultyToScores < ActiveRecord::Migration[7.2]
  def change
    add_column :scores, :difficulty, :string
  end
end
