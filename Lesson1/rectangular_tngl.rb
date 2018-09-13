# Lesson 1 / Rectangular Triangle
#

# <LF> is still present if no chomp
puts "Enter triangle 1-st side (integer): "
a = gets.chomp
puts "Enter triangle 2-nd side (integer): "
b = gets.chomp
puts "Enter triangle 3-rd side (integer): "
c = gets.chomp

sent = "trivial"
# compute squares
a_sqr = a.to_i**2
b_sqr = b.to_i**2
c_sqr = c.to_i**2
# for later arrangement
sides_sqr = [a_sqr, b_sqr, c_sqr]

# first check if  all sides are equal
if a == b && a == c
  puts "Triangle has equal sides : #{a}, #{b}, #{c} and is not rectangular"

# then if  fig. is rectang. and/or sides are equal  
elsif   sides_sqr.sort.last == a_sqr
  if a_sqr == b_sqr + c_sqr
    puts "Sides are :  #{a}<, #{b}, #{c} and"
    sent = "rectangular"
  end  
  if  b_sqr == c_sqr
    puts "Triangle is  isosceles #{a}, #{b}<, #{c}<" 
# next operator correctly terminates the  "else", i think    
      else puts "Triangle is #{sent}" 
  end     
   
elsif   sides_sqr.sort.last == b_sqr
  if b_sqr == a_sqr + c_sqr
    puts "Sides are : #{a}, #{b}<, #{c} and"
    sent = "rectangular"
  end  
  if  a_sqr == c_sqr
    puts "Triangle is  isosceles  #{a}<, #{b}, #{c}<" 
      else puts "Triangle is #{sent}"  
  end
 
elsif   sides_sqr.sort.last == c_sqr
  if c_sqr == a_sqr + b_sqr
    puts "Sides are : #{a}, #{b}, #{c}< and"
    sent = "rectangular"
  end  
  if  a_sqr == b_sqr                                  
    puts "Triangle is  isosceles #{a}<, #{b}<, #{c}"                                                                     
      else puts "Triangle is #{sent}"       
  end
                                                    
end
