require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @product = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
  end

  scenario "They can navigate from the home page to the product detail page by clicking on a product" do
    # ACT
    visit root_path

    first('article.product').find_link(@product.name).click

    # DEBUG / VERIFY
    
    within('header') do
      expect(page).to have_content @product.name
    end

    save_screenshot
    
  end


end
