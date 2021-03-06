class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :event

  has_many :sliders, -> { order 'created_at asc' }, :as => :sliderable, dependent: :destroy

  has_many :images, -> { order 'created_at asc' }, :as => :imageable, dependent: :destroy



  accepts_nested_attributes_for :sliders
  accepts_nested_attributes_for :images

  validates :name, :description, :problem, :solution, :team_description, presence: true
  validates :name, uniqueness: true

  #def event
  #  self.team.event
  #end

  def create_images
    problem_image = self.images.build
    File.open('./public/projects/problem_default.jpg') do |f|
      problem_image.image = f
    end

    solution_image = self.images.build
    File.open('./public/projects/solution_default.jpg') do |f|
      solution_image.image = f
    end

    team_image = self.images.build
    File.open('./public/projects/team_default.png') do |f|
      team_image.image = f
    end
  end

  def create_slides
    slide1 = self.sliders.build
    image1 = slide1.build_image
    File.open('./public/projects/slider_default.jpg') do |f|
      image1.image = f
    end
    slide1.title = "Slider"

    slide2 = self.sliders.build
    image2 = slide2.build_image
    File.open('./public/projects/slider_default.jpg') do |f|
      image2.image = f
    end
    slide2.title = "Slider"

    slide3 = self.sliders.build
    image3 = slide3.build_image
    File.open('./public/projects/slider_default.jpg') do |f|
      image3.image = f
    end
    slide3.title = "Slider"
  end

  def self.image_type index
    type = ""
    if index == 0
      type = "Problem"
    elsif index == 1
      type = "Solution"
    else
      type = "Team"
    end

    type
  end

end
