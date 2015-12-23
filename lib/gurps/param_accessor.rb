module GURPS

  module ParamAccessor

    def hash_accessor(hash_name,*key_names)
      key_names.each do |name|
        define_method name do
          instance_variable_get("@#{hash_name}")[name]
        end
      end
    end

  end

end