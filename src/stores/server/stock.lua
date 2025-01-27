function Store:updateStock(new_stock)
  local past_sanitized = self:santizeItems()
  if not past_sanitized then return end
  self.stock = new_stock
end

lib.updateStoreStock = function(store_id, new_stock)
  local store = Store.get(store_id)
  if not store then return end
  store:updateStock(new_stock)
end 

function Store:getItemByListingId(listing_id)
  for k,v in pairs(self.stock) do
    if v.listing_id == listing_id then
      return v
    end
  end
end

function Store:updateStockByListingId(listing_id, amount)
  local item = self:getItemByListingId(listing_id)
  if not item then return end
  if not item.stock then return end
  item.stock = item.stock + amount
end