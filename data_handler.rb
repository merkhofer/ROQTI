class DataHandler
  def initialize(owner)
    @owner = owner
    @data = {}
  end
  def refresh(source)
    temp_data = File_handler.new(source)
    headers, data = temp_data.read
    
    headers = headers [1..-1].join(",").downcase().gsub(" ", "_").split(",")
    
    for data_line in data
      year, month, day = data_line [0].split("-") 
      @data[year] = {} if !@data.has_key?(year)
      @data[year][month] = {} if !@data[year].has_key?(month)
      @data[year][month][day] = {}
      for data_item in headers.zip(data_line[1..-1])
        @data[year][month][day][data_item[0]] = data_item[1]
      end      
    end  
  end
  
  def retrieve(year, month, day)
   price = @data [year][month][day]["close"]
   return price
    
  end

  def most_recent_price
   return 0 #TODO: how to get this from that hash of hashes of hashes?
  end
end

