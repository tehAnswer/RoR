class CombineItemsInCart < ActiveRecord::Migration
  def up
  	# Replace multiple line items for a single one.
  	Cart.all.each do |cart|
  		sums = cart.line_items.group(:product_id).sum(:quantity)

  		sums.each do |id, quantity|
  			# Remove individual items.
  			cart.line_items.where(product_id: id).delete_all

  			# New single line item.
  			line_item = cart.line_items.build(product_id: id)
  			line_item.quantity = quantity
  			line_item.save!
  		end
  	end
  end

  def down
  	LineItem.where("quantity>1").each do |line_item|
  		# Add individual items.
  		line_item.quantity.times do
  			LineItem.create cart_id: line_item.cart_id,
  			 product_id: line_item.product_id, quantity: 1
  		end
  	# Remove original item
  	line_item.destroy
  	end
  end
  
end
