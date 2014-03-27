class AddDataSources < ActiveRecord::Migration
  def up
    %w(Twitter Instagram 500px Flickr Facebook).each do |name|
      DataSource.create(name: name)
    end
  end

  def down
    DataSource.delete_all
  end
end
