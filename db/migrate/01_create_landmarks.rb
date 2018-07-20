class CreateLandmarks < ActiveRecord::Migration[4.2]
  # raise "Write CreateLandmarks migration here"
  def change
  	create_table :landmarks do |t|
  		t.string :name
  		t.integer :year_completed
  		t.integer :figure_id
  	end
  end
end
