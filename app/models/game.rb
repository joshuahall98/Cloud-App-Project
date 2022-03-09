class Game < ApplicationRecord

    belongs_to :user
    belongs_to :category
    has_many :reviews

    #accesing the image
    has_attached_file :game_img, styles: { game_index: "250x350>", game_show: "325x475>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :game_img, content_type: /\Aimage\/.*\z/
end
