class MmsResource < ApplicationRecord
  def is_image?
    filename.include?('.jpg')
  end

  def path
    "./storage/#{filename}"
  end
end
