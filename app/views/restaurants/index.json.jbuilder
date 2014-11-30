json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :address, :rank, :price, :fjpn, :fchina, :fitarian, :fother, :sdate, :sconpa, :sfever, :sother
  json.url restaurant_url(restaurant, format: :json)
end
