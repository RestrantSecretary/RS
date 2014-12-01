json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :address, :URL, :TEL, :rank, :price, :fjpn, :fchina, :fitarian,:ffranch,:fspanish, :fother, :sdate, :sconpa, :sfever, :sother,:extraText1 ,:extraText2 ,:extraText3
  json.url restaurant_url(restaurant, format: :json)
end
