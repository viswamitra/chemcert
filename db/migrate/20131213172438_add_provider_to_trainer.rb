class AddProviderToTrainer < ActiveRecord::Migration
  def change
    add_column :trainers, :provider, :string
  end
end
