digits_arr = ["zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
units = ["Ten", "Hundred", "Thounsand", "Hundred Thounsand", "Million", "Hundred Million", "Billion" ]
tens = ["Ten", "Twenty", "Thirty", "Fourty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]
line_count = 0
result = []
ARGF.each_line do |line|
    if line_count > 0
        output_val = ""
        count = 0
        line = line.gsub("\n","")
        size = line.size
        line.each_char do |char|
            if (!char.empty? && char != "\n")
                if char.to_i != 0
                    if(size == 3)
                        output_val = "#{digits_arr[char.to_i]} "
                        output_val << "#{units[size - 2]} "
                        size -= 1
                    elsif(size == 2 )
                        output_val << "#{tens[char.to_i - 1]} "
                        size -= 1
                    elsif(size == 1)
                        output_val << "#{digits_arr[char.to_i]}"    
                    elsif(size == 4)
                        output_val  = "#{digits_arr[char.to_i]} "
                        output_val << "#{units[size - 2]} "
                        size -= 1
                    elsif (size > 4 and size < 6)
                        output_val << "#{tens[char.to_i - 1]} "
                        output_val << "#{units[size - 3]} "
                        size -= 1
                    elsif (size ==6)
                        output_val << "#{digits_arr[char.to_i]} "
                        output_val << "#{units[size - 3]}"
                        size -= 1 
                    elsif (size > 6 and size < 9)
                        output_val << "#{tens[char.to_i - 1]} "
                        output_val << "#{units[size - 4]} "
                        size -= 1
                    elsif (size == 9)
                        output_val << "#{digits_arr[char.to_i]} "
                        output_val << "#{units[size - 4]} "
                        size -= 1
                    elsif (size == 10)
                        output_val << "#{digits_arr[char.to_i]} "
                        output_val << "#{units[size - 4]} "
                        size -= 1
                    end
                end
            end
        end
        result << output_val
    end
    line_count = line_count + 1
end

result.each { |number| puts number }
