require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  #The fixtures() directive loads the data from products.yml
  fixtures :products

  def new_product(image_url)
  	Product.new(title:'test',
   				description:'test',
   				price: 1,
   				image_url: image_url)
  end


  test "product must be no empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title]
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
   end

   test "price greater than zero" do
   	product = Product.new(title:'test',
   						  description:'test',
   						  image_url:'test.png' )
   	product.price = -1;
   	assert product.invalid?
   	assert !product.errors[:title].any?
   	assert product.errors[:price].all?
   	product.price= 0
   	assert product.invalid?
   	product.price= 0.012
   	assert product.valid?
   end

   test "image_url" do
   	#Array with correct names
   	ok = %w{fred.gif fred.jpg fred.png fred.PNG fred.JPG fred.GIF}
	#Array with invalid names
	bad = %w{fred.wasap fred.doc fred.realtalk fred.rb}   	

	ok.each do |name|
		assert new_product(name).valid?, "#{name} should be valid"
	end

	bad.each do |name|
		assert new_product(name).invalid?, "#{name} should be invalid"
	end

   end


   test "single name" do
   	product = Product.new(title: products(:ruby).title,
   						 description: 'this is will be invalid',
   						 price: 1,
   						 image_url: 'fake.gif')
   	product.errors[:title].all?
   	product.title= 'Truth be told'
   	product.valid?	  	

   end
end
