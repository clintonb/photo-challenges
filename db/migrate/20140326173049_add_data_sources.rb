class AddDataSources < ActiveRecord::Migration
  def up
    %w(Twitter Instagram 500px Flickr Facebook).each do |name|
      DataSource.create(name: name)
      puts "Created DataSource #{name}"
    end
  end

  def down
    DataSource.delete_all
  end
end
