class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
 
    #getter
    names.each do |ele|
      define_method(ele) do
        instance_variable_get("@"+ele.to_s)
      end
    end

    #setter
    names.each do |ele|
      define_method(ele.to_s + "=") do |input|
        instance_variable_set("@"+ele.to_s,input)
      end
    end
    
  end
end
