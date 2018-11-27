# Lesson6 (Railway)  Object Check Module
#
module CheckValid

 def valid?
    validate!
    true
  rescue
    false
  end
end
